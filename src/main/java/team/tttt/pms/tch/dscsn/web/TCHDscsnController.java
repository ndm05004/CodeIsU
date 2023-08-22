package team.tttt.pms.tch.dscsn.web;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.emp.dscsn.service.DscsnService;
import team.tttt.pms.emp.vo.ConsulReservationVO;
import team.tttt.pms.emp.vo.ConsultingRoomVO;
import team.tttt.pms.emp.vo.DscsnVO;
import team.tttt.pms.emp.vo.RejectVO;
import team.tttt.pms.stu.vo.ResumeVO;

@Slf4j
@Controller
@RequestMapping("/tch/dscsn")
public class TCHDscsnController {

	@Inject
	private DscsnService dscsnService;

	@GetMapping("/dscsnBoard")
	public String dscsnBoard(Model model) {
		log.info("dscsnBoard()...실행");
		model.addAttribute("temp_title", "상담관리");
		return "tch/com/dscsn/TCHdscsnBoard";
	}

	@GetMapping("/resultPage")
	public String resultPage(int no, String name, String status, Model model) {
		log.info("resultPage()...실행");

		String resumeNo = dscsnService.selectResume(name);

		model.addAttribute("dscsnNo",no);
		model.addAttribute("stuNm",name);
		model.addAttribute("dscsnYn",status);
		model.addAttribute("resumeNo", resumeNo);

		model.addAttribute("temp_title", "상담 결과");
		log.info("상담체크 : "+status);

		if(status.equals("상담완료")) {
			String dscsnResult = dscsnService.selectResult(no);
			model.addAttribute("dscsnRslt",dscsnResult);
		}


		return "tch/com/dscsn/TCHdscsnresultpage";
	}

	@ResponseBody
	@GetMapping("/dscsnNoList")
	public List<DscsnVO> dscsnNoList(String userNo){
		log.info("dscsnNoList()...실행");

		List<DscsnVO> dscsnNoList = new ArrayList<DscsnVO>();

		dscsnNoList = dscsnService.dscsnNoList(userNo);

		return dscsnNoList;
	}

	@ResponseBody
	@GetMapping("/dscsnApprovList")
	public List<DscsnVO> dscsnApprovList(String userNo){
		log.info("dscsnApprovList()...실행");

		List<DscsnVO> dscsnApprovList = new ArrayList<DscsnVO>();

		dscsnApprovList = dscsnService.dscsnApprovList(userNo);

		return dscsnApprovList;
	}

	@ResponseBody
	@GetMapping("/dscsnUnApprovList")
	public List<DscsnVO> dscsnUnApprovList(String userNo){
		log.info("dscsnUnApprovList()...실행");

		List<DscsnVO> dscsnUnApprovList = new ArrayList<DscsnVO>();

		dscsnUnApprovList = dscsnService.dscsnUnApprovList(userNo);

		return dscsnUnApprovList;
	}

	@ResponseBody
	@GetMapping("/dscsnClearList")
	public List<DscsnVO> dscsnClearList(String userNo){
		log.info("dscsnClearList()...실행");

		List<DscsnVO> dscsnClearList = new ArrayList<DscsnVO>();

		dscsnClearList = dscsnService.dscsnClearList(userNo);

		return dscsnClearList;
	}

	@ResponseBody
	@GetMapping("/viewConsulRoom")
	public List<ConsultingRoomVO> viewConsulRoom(ConsulReservationVO consulReservationVO){
		log.info("viewConsulRoom()...실행");

		List<ConsultingRoomVO> consulList = dscsnService.consulList(consulReservationVO);

		return consulList;
	}

	@ResponseBody
	@PostMapping(value = "/insertReservation", produces = "application/json;charset=utf-8")
	public String insertReservation(@RequestBody ConsulReservationVO consulReservationVO) {
		log.info("insertReservation()...실행");
		String result = "";

		int check = dscsnService.insertReservation(consulReservationVO);

		if(check == 1) {
			result = "성공";
			//상담글의 상담 승인 여부를 변경
			int dscsnNo = consulReservationVO.getDscsnNo();
			String dscsnroomCd = consulReservationVO.getConsulCd();

			DscsnVO dscsnVO = new DscsnVO();
			dscsnVO.setDscsnNo(dscsnNo);
			dscsnVO.setDscsnroomCd(dscsnroomCd);

			dscsnService.approvalUpdate(dscsnVO);
		}else {
			result = "실패";
		}

		return result;
	}

	@ResponseBody
	@PostMapping(value = "/insertReject", produces = "application/json;charset=utf-8")
	public String insertReject(@RequestBody RejectVO rejectVO) {
		log.info("insertReject()...실행");
		String result = "";

		int check = dscsnService.insertReject(rejectVO);

		if(check == 1) {
			result = "성공";
			//상담글의 상담 승인 여부를 변경
			int dscsnNo = rejectVO.getDscsnNo();

			dscsnService.unApprovalUpdate(dscsnNo);

		}else {
			result = "실패";
		}

		return result;
	}

	@ResponseBody
	@GetMapping("/myDscsnList")
	public List<DscsnVO> myDscsnList(String stuName){
		log.info("myDscsnList()...실행");

		List<DscsnVO> dscsnList = dscsnService.myDscsnList(stuName);

		return dscsnList;
	}

	@ResponseBody
	@PostMapping(value = "/resultInsert", produces = "application/json;charset=utf-8")
	public String resultInsert(@RequestBody DscsnVO dscsnVO) {
		log.info("resultInsert()...실행");
		String result = "";

		int check = dscsnService.resultInsert(dscsnVO);

		if(check == 1) {
			result = "성공";
		}else {
			result = "실패";
		}

		return result;
	}

	@GetMapping("/goDscsnList")
	public String goDscsnList(Model model, String userNo) {
		log.info("goDscsnList()...실행");

		List<DscsnVO> dscsnNoList = dscsnService.dscsnNoList(userNo);

		model.addAttribute("dscsnList",dscsnNoList);

		return "tch/com/dscsn/TCHdscsnList";
	}

	@GetMapping("/approlist")
	public String approlist(Model model) {
		log.info("approlist()...실행");

		List<DscsnVO> dscsnNoList = dscsnService.allapprolist();

		model.addAttribute("alldscsnList",dscsnNoList);

		return "tch/com/dscsn/approvaldscsnlist";
	}

	@GetMapping("/unapprolist")
	public String unapprolist(Model model, String userNo) {
		log.info("unapprolist()...실행");

		List<DscsnVO> dscsnUnApprovList = dscsnService.dscsnUnApprovList(userNo);

		model.addAttribute("alldscsnList",dscsnUnApprovList);

		return "tch/com/dscsn/TCHunapprovaldscsnlist";
	}

	@ResponseBody
	@GetMapping("/selectResume")
	public String selectResume(String stuName) {
		log.info("selectResume()...실행");
		String result = "";

		result = dscsnService.selectResume(stuName);

		return result;
	}

	@ResponseBody
	@GetMapping("/noapprovdscsn")
	public int noapprovdscsn(String userNo) {
		log.info("noapprovdscsn()...실행");

		int result = dscsnService.noapprovdscsn(userNo);

		return result;
	}

	@ResponseBody
	@GetMapping("/todaydscsn")
	public int todaydscsn(String userNo) {
		log.info("todaydscsn()...실행");

		int result = dscsnService.todaydscsn(userNo);

		return result;
	}

	@ResponseBody
	@GetMapping("/tomorrowdscsn")
	public int tomorrowdscsn(String userNo) {
		log.info("tomorrowdscsn()...실행");

		int result = dscsnService.tomorrowdscsn(userNo);

		return result;
	}

}
