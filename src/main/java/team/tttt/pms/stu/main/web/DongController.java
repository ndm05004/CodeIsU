package team.tttt.pms.stu.main.web;

import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.Date;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.emp.vo.AttdVO;
import team.tttt.pms.stu.main.service.DongService;

@Slf4j
@Controller
@RequestMapping("/stu/dong")
public class DongController {

	@Inject
	private DongService dongService;

	@GetMapping("/dongmain")
	public String dongMain() {
		log.info("dongMain()...실행");

		return "stu/com/mainDong";
	}

	@ResponseBody
	@GetMapping("/usercheck")
	public String userCheck(String userNo) {
		log.info("userCheck()...실행");
		String result = "";

		// 오늘 날짜 가져오기
		Date today = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		// 오늘 날짜를 지정된 형식으로 변환하여 출력
		String formattedDate = dateFormat.format(today);

		AttdVO dataVO = new AttdVO();
		dataVO.setAttdDt(formattedDate);
		dataVO.setStuNo(userNo);

		AttdVO attdVO = dongService.userCheck(dataVO);

		if(attdVO != null) {
			result = "inData";
		}else {
			result = "noData";
		}

		return result;
	}

	@ResponseBody
	@GetMapping("/selectData")
	public AttdVO selectData(AttdVO attdVO) {
		log.info("userCheck()...실행");

		AttdVO tempVO = dongService.searchAttd(attdVO);

		return tempVO;
	}

	@ResponseBody
	@PostMapping(value = "/attdInsert", produces = "application/json;charset=utf-8")
	public String attdInsert(@RequestBody AttdVO attdVO) {
		log.info("attdInsert()...실행");
		String result = "";

		int check = dongService.insertAttd(attdVO);

		if(check == 1) {
			result = "formattedDate";
		}else {
			result = "실패";
		}

		return result;
	}

	@ResponseBody
	@PostMapping(value = "/inClass", produces = "application/json;charset=utf-8")
	public String inClass(@RequestBody AttdVO attdVO) {
		log.info("inClass()...실행");
		String result = "";
		int check = 0;

		String basicTime = "09:05";
		String inTime = attdVO.getAttdAbmiYmd();

		//09:05보다 빠르거나 같은 때
		int timeCheck = basicTime.compareTo(inTime);
		if(timeCheck >= 0) {
			check = dongService.inClass(attdVO);
		}
		//09:05를 넘겼을 때
		else if(timeCheck < 0) {
			check = dongService.inClassLate(attdVO);
		}


		if(check == 1) {
			result = "OK";
		}else {
			result = "FAIL";
		}

		return result;
	}

	@ResponseBody
	@PostMapping(value = "/outClass", produces = "application/json;charset=utf-8")
	public String outClass(@RequestBody AttdVO attdVO) {
		log.info("outClass()...실행");
		String result = "";

		int check = dongService.outClass(attdVO);

		if(check == 1) {
			//오늘 출석부를 가져와 퇴실과 입실을 비교
			AttdVO tempVO = dongService.searchAttd(attdVO);

			String inTemp = tempVO.getAttdAbmiYmd();
			String outTemp = tempVO.getAttdLeaveYmd();

			LocalTime inTime = LocalTime.parse(inTemp);
			LocalTime outTime = LocalTime.parse(outTemp);

			long diffMinutes = inTime.until(outTime, ChronoUnit.MINUTES);

			//시간 차이가 480이상이고 출결 코드가 결석이 상태
			if(diffMinutes >= 480 || tempVO.getAttdCd() == "S001-4") {
				dongService.attdOk(attdVO);
				result = "OK";
			}else {
				dongService.attdFail(attdVO);
				result = "OK";
			}


		}else {
			result = "FAIL";
		}

		return result;
	}
}
