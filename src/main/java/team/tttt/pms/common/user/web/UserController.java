package team.tttt.pms.common.user.web;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.user.service.UserService;
import team.tttt.pms.common.user.utils.ProfileUploadUtils;
import team.tttt.pms.common.vo.SmsVO;
import team.tttt.pms.common.vo.UserVO;


@Slf4j
@Controller
@RequestMapping("/user")
public class UserController {

	@Inject
	private UserService userService;

	@RequestMapping(value = "/login")
	public String login() {
		log.info("로그인 컨트롤러");
		return "common/user/login";
	}



	/*
	 *  로그아웃
	 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String userLogout(HttpServletRequest request, HttpServletResponse response) {
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    if (authentication != null) {
	        new SecurityContextLogoutHandler().logout(request, response, authentication);
	        String cookieName = "remember-me";
	        Cookie cookie = new Cookie(cookieName, null);
	        cookie.setMaxAge(0);
	        cookie.setPath(StringUtils.hasLength(request.getContextPath()) ? request.getContextPath() : "/");
	        response.addCookie(cookie);
	        return "redirect:/";
	    }

	    return "redirect:/user/login";
	}




	/*
	 *  가입명단에 번호있는지 확인
	 */
	@ResponseBody
	@RequestMapping(value = "/phonecheck", method = RequestMethod.POST)
	public String phoneCheck(@RequestParam Map<String, String> phoneInfo) {

		ServiceResult result = userService.phoneCheck(phoneInfo); // DB명단에 있는 이름과  번호인지 확인

		if(result == ServiceResult.OK) { // OK시 문자 발송

			ServiceResult sendRst = userService.sendMessage(phoneInfo.get("joinPhone")); // 인증번호 발송
		}
		return result.name();
	}

	/*
	 * 사용자 문자 전송 값 확인
	 */
	@ResponseBody
	@PostMapping(value = "/numcheck", produces = "application/json;charset=utf-8")
	public String numCheck(@RequestBody SmsVO replyNum, HttpSession session) {
		log.info("[사용자문자인증전송값] " + replyNum.getSmsCn());

		ServiceResult result = userService.matchNum(replyNum); // 사용자가 인증한 값과 DB에서 일치하는 지 확인 (5분 검증)

		if(result == ServiceResult.MATCH) { // 일치시 사용자이름과 연락처를 리턴
			session.setAttribute("userNm", replyNum.getUserNm());
			session.setAttribute("userPhone", replyNum.getSmsRcvr());
		}
		return result.name();
	}


	/*
	 *  세부 정보 가입페이지
	 */
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signup(HttpSession session, HttpServletResponse res, Model model) throws IOException, ParseException {

		String userNm = (String) session.getAttribute("userNm");
		String userPhoneno = (String) session.getAttribute("userPhone");
		if (userNm == null) {
			model.addAttribute("msg", "비정상 접근입니다. 초기페이지로 이동합니다.");
			model.addAttribute("url", "/user/login");
			return "common/error/alert";
		}

		if (userNm != null) {
		session.removeAttribute("userNm");
		session.removeAttribute("userPhone");

		Map<String, String> userInfo = userService.readSvlfNm(userNm, userPhoneno);
		System.out.println(userInfo);
		Map<String, String> userData = new HashMap<String, String>();


		userData.put("svlfNm", userInfo.get("SVLF_NM"));
		userData.put("userNo", userInfo.get("STU_NO"));
		userData.put("userGender", userInfo.get("USER_GENDER"));

        LocalDate userBrdt = LocalDate.parse(userInfo.get("USER_BRDT"), DateTimeFormatter.ofPattern("yyyyMMdd"));

		userData.put("userBrdt", userBrdt.toString());
		userData.put("userNm", userNm);
		userData.put("userPhoneno", userPhoneno);

		model.addAttribute("userData", userData);
		}


		return "common/user/signup";

	}


	/**
	 * @Method설명 : 회원가입 진행
	 * @param userVO
	 * @param model
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 */
	@ResponseBody
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String signupProcess(UserVO userVO, Model model, HttpServletRequest request) throws IOException {

		ServiceResult result = null;


		{
			System.out.println(userVO);
		}


		MultipartFile profileImgFile = userVO.getProfileFile();
		String realPath = request.getSession().getServletContext().getRealPath("");
		String setPath = "static/resources/img/profile/";  // Tomcat Server의 경로 (webapp 부터시작)

		String thumbPath = ProfileUploadUtils.uploadProfile(userVO.getUserNo(), realPath, setPath, profileImgFile);
		userVO.setUserProfile(thumbPath);

		log.info(userVO.toString());


		try {
			result = userService.signupUser(userVO);
		} catch (IOException | SQLException e) {
			e.printStackTrace();
			log.info("[회원가입처리] DB등록중 에러");
			result = result.FAILED;
		}

		return result.name();


	}


	/*
	 * 아이디 찾기
	 */
	@ResponseBody
	@RequestMapping(value = "/findid", method = RequestMethod.POST)
	public Map<String, String> findId(@RequestBody Map<String, String> findInfo) {

		System.out.println(findInfo);
		Map<String, String> info = new HashMap<String, String>();

		Map<String, String> findResult = userService.findId(findInfo);

		System.out.println(findResult);

		return findResult;
	}

	/*
	 * 비밀번호 찾기
	 */
	@ResponseBody
	@RequestMapping(value = "/findps", method = RequestMethod.POST)
	public String findPs(@RequestBody Map<String, String> findInfo) {

		System.out.println(findInfo);
		Map<String, String> info = new HashMap<String, String>();

		ServiceResult findResult = userService.findPs(findInfo);

		System.out.println(findResult);

		return findResult.name();
	}



	@RequestMapping(value = "/signtest")
	public String signupTest() {
		return "common/user/signupTest";
	}
}
