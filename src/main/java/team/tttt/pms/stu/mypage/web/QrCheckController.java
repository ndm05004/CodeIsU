package team.tttt.pms.stu.mypage.web;

import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.emp.vo.AttdVO;
import team.tttt.pms.stu.main.service.DongService;
import team.tttt.pms.stu.mypage.service.QrCheckService;

@Slf4j
@Controller
public class QrCheckController {

	@Inject
	QrCheckService service;
	@Inject
	private DongService dongService;

	/* QR코드 페이지 */
	@RequestMapping(value = "/qrcheck/qrcode", method = RequestMethod.GET)
	public String qrGenPage() {
		return "/common/qrcheck/qrGenPage";
	}

	/* QRCode 토큰 전송 */
	@ResponseBody
	@RequestMapping(value = "/qrcheck/reloadQR", method = RequestMethod.POST)
	public String reloadQrCode() {
		String uuidToken = "codeisuQRCheck-" + UUID.randomUUID().toString();

		ServiceResult result = service.insertToken(uuidToken);

		if(result == ServiceResult.OK) {
			return uuidToken;
		} else {
			return ServiceResult.FAILED.name();
		}
	}

	public String qrCheck() {
		return "";
	}


	@RequestMapping(value = "/stu/qrattd")
	public String qrReadPage(Authentication auth, Model model) {
		// 여기서 slect를 해본다.
		CustomUser cUser  = (CustomUser) auth.getPrincipal();
		UserVO userVO = cUser.getMember();

		AttdVO attdVO = service.selectAttdVO(userVO.getUserNo());

		model.addAttribute("attd", attdVO);

		return "/stu/com/qrcheck/qrreadpage";

	}


//
//	@ResponseBody
//	@PostMapping(value = "/inClass", produces = "application/json;charset=utf-8")
//	public Map<String, String> inClass(@RequestBody AttdVO attdVO) {
//		log.info("inClass()...실행");
//		String result = "";
//		int check = 0;
//
//		String basicTime = "09:05";
//		String inTime = attdVO.getAttdAbmiYmd();
//
//		//09:05보다 빠르거나 같은 때
//		int timeCheck = basicTime.compareTo(inTime);
//		if(timeCheck >= 0) {
//			check = dongService.inClass(attdVO);
//		}
//		//09:05를 넘겼을 때
//		else if(timeCheck < 0) {
//			check = dongService.inClassLate(attdVO);
//		}
//
//
//		if(check == 1) {
//			result = "OK";
//		}else {
//			result = "FAIL";
//		}
//
//		// 결과값 (성공/실패)
//		// 지각인지? 결석인지?
//		// 시각 같이 전송
//
//		return result;
//	}
//
//	@ResponseBody
//	@PostMapping(value = "/outClass", produces = "application/json;charset=utf-8")
//	public String outClass(@RequestBody AttdVO attdVO) {
//		log.info("outClass()...실행");
//		String result = "";
//
//		int check = dongService.outClass(attdVO);
//
//		if(check == 1) {
//			//오늘 출석부를 가져와 퇴실과 입실을 비교
//			AttdVO tempVO = dongService.searchAttd(attdVO);
//
//			String inTemp = tempVO.getAttdAbmiYmd();
//			String outTemp = tempVO.getAttdLeaveYmd();
//
//			LocalTime inTime = LocalTime.parse(inTemp);
//			LocalTime outTime = LocalTime.parse(outTemp);
//
//			long diffMinutes = inTime.until(outTime, ChronoUnit.MINUTES);
//
//			//시간 차이가 480이상이고 출결 코드가 결석이 상태
//			if(diffMinutes >= 480 || tempVO.getAttdCd() == "S001-4") {
//				dongService.attdOk(attdVO);
//				result = "OK";
//			}else {
//				dongService.attdFail(attdVO);
//				result = "OK";
//			}
//
//
//		}else {
//			result = "FAIL";
//		}
//
//		return result;
//	}

}
