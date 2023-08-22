package team.tttt.pms.stu.mypage.web;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.stu.mypage.service.ModifyProfileService;
import team.tttt.pms.stu.vo.StuVO;

@Slf4j
@Controller
@RequestMapping("/stu/mypage/modify")
public class ModifyProfileController {

	@Inject
	ModifyProfileService service;

	@GetMapping("")
	public String verifyPsMain(Model model) {
		model.addAttribute("temp_title", "회원정보 변경");

		return "stu/com/mypage/modifyProfile/verifyPs";
	}


	@PostMapping("")
	public String verifyPs(String userPs, Authentication auth, Model model) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		UserVO userVO = user.getMember();

		System.out.println(userPs);
		ServiceResult result = service.verifyPs(userVO.getUserNo(), userPs);

		if(result == ServiceResult.OK) {


			StuVO userInfoVO = service.readStuInfo(userVO.getUserNo());

			model.addAttribute("userData", userInfoVO);

			return "stu/com/mypage/modifyProfile/modifyProfile";
		} else {

			return "redirect:/stu/mypage/modify";
		}
	}

}
