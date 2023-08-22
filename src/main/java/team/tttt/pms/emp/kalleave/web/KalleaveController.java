package team.tttt.pms.emp.kalleave.web;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.emp.kalleave.service.KalleaveService;
import team.tttt.pms.emp.vo.AttdVO;
import team.tttt.pms.stu.vo.AttdanVO;

@Slf4j
@Controller
@RequestMapping("/emp/stuman")
public class KalleaveController {

	@Inject
	private KalleaveService kalleaveService;

	@GetMapping("/kalleave")
	public String kalleave() {
		log.info("kalleave()...실행");

		return "emp/com/stumanage/kalleave/kalleaveMain";
	}

	// 조퇴/외출 신청 목록 전체 가져오는 컨트롤러
	@GetMapping("/allList")
	public String allList() {
		log.info("allList()...실행");

		return "emp/com/stumanage/kalleave/kalleaveAllList";
	}

	@GetMapping("/approvalList")
	public String approvalList() {
		log.info("approvalList()...실행");

		return "emp/com/stumanage/kalleave/approvalList";
	}

	@GetMapping("/unapprovedList")
	public String unapprovedList() {
		log.info("unapprovedList()...실행");

		return "emp/com/stumanage/kalleave/unapprovedList";
	}

	@ResponseBody
	@GetMapping("/attdanAllList")
	public List<AttdanVO> attdanAllList() {
		log.info("attdanAllList()...실행");

		List<AttdanVO> attdanList = new ArrayList<AttdanVO>();

		attdanList = kalleaveService.attdanAllList();

		return attdanList;
	}

	@ResponseBody
	@GetMapping("/attdanapproval")
	public List<AttdanVO> attdanapproval() {
		log.info("attdanapproval()...실행");

		List<AttdanVO> approvalList = new ArrayList<AttdanVO>();

		approvalList = kalleaveService.attdanapproval();

		return approvalList;
	}

	@ResponseBody
	@GetMapping("/attdanunapproved")
	public List<AttdanVO> attdanunapproved() {
		log.info("attdanunapproved()...실행");

		List<AttdanVO> unApprovalList = new ArrayList<AttdanVO>();

		unApprovalList = kalleaveService.attdanunapproved();

		return unApprovalList;
	}

	//번호로 받아서 업데이트
	@ResponseBody
	@PostMapping(value = "/approvalUpdate", produces = "application/json;charset=utf-8")
	public String approvalUpdate(@RequestBody AttdanVO attdanVO) {
		log.info("approvalUpdate()...실행");
		String result = "";

		int check = kalleaveService.approvalUpdate(attdanVO);

		if(check == 1) {
			result = "성공";
		}else {
			result = "실패";
		}

		return result;
	}

	@ResponseBody
	@PostMapping(value = "/checkAttd", produces = "application/json;charset=utf-8")
	public String checkAttd(@RequestBody AttdVO attdVO) {
		log.info("checkAttd()...실행");
		String result = "";

		int check = kalleaveService.selectattd(attdVO);


		if(check != 1) {
			//출석부 미존재
			int cho = kalleaveService.inattd(attdVO);

			if(cho == 1) {
				result = "성공";
			}else {
				result = "실패";
			}
		}else {
			int cho = kalleaveService.upattd(attdVO);

			if(cho == 1) {
				result = "성공";
			}else {
				result = "실패";
			}
		}

		return result;
	}

	@ResponseBody
	@PostMapping(value = "/outAttd", produces = "application/json;charset=utf-8")
	public String outAttd(@RequestBody AttdVO attdVO) {
		log.info("outAttd()...실행");
		String result = "";

		int check = kalleaveService.selectattd(attdVO);


		if(check != 1) {
			//출석부 미존재
			int cho = kalleaveService.inoutattd(attdVO);

			if(cho == 1) {
				result = "성공";
			}else {
				result = "실패";
			}
		}else {
			int cho = kalleaveService.upinoutattd(attdVO);

			if(cho == 1) {
				result = "성공";
			}else {
				result = "실패";
			}
		}

		return result;
	}

}
