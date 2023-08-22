package team.tttt.pms.stu.main.web;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.emp.vo.SbjctVO;
import team.tttt.pms.project.vo.StorageVO;
import team.tttt.pms.stu.main.service.StuMainService;
import team.tttt.pms.stu.vo.IssueListVO;
import team.tttt.pms.stu.vo.ProjListVO;
import team.tttt.pms.stu.vo.StorageListVO;
import team.tttt.pms.tch.vo.AsmtVO;

@Slf4j
@Controller
@RequestMapping("/stu")
public class StuMainController {

	@Inject
	private StuMainService service;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String stuMain(Authentication auth, Model model) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		String userNo = userVO.getUserNo();

		model.addAttribute("userNo", userNo);
		log.info("정보" + userVO.getUserAddr());
		System.out.println(userVO);
		model.addAttribute("temp_title", "원생 대시보드");

		return "stu/com/main";
	}

	//프로젝트 리스트 (제목만)
	@ResponseBody
	@GetMapping(value = "/projlist", produces = "application/json;charset=utf-8")
	public List<ProjListVO> projList(String stuNo) {

		List<ProjListVO> vo = service.projList(stuNo);

		log.info("projList : ", vo);

		return vo;
	}

	//이슈 리스트
	@ResponseBody
	@GetMapping(value = "/issuelist", produces = "application/json;charset=utf-8")
	public List<IssueListVO> issueList(String stuNo) {

		List<IssueListVO> vo = service.issueList(stuNo);

		log.info("issueList : ", vo);

		return vo;
	}

	// 시간표
	@ResponseBody
	@GetMapping(value = "/timetable", produces = "application/json;charset=utf-8")
	public List<SbjctVO> timetable(Authentication auth) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		String stuNo = userVO.getUserNo();
		List<SbjctVO> timetableList = service.selectTimetableList(stuNo);

		log.info("timetableList : " + timetableList);

		return timetableList;
	}

	// 과제
	@ResponseBody
	@GetMapping(value = "/asmt", produces = "application/json;charset=utf-8")
	public List<AsmtVO> asmtList(Authentication auth) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		String stuNo = userVO.getUserNo();
		List<AsmtVO> asmtList = service.selectAsmtList(stuNo);

		log.info("asmtList : " + asmtList);
		return asmtList;
	}

	//자료실 리스트
	/*
	@ResponseBody
	@GetMapping(value = "/storagelist", produces = "application/json;charset=utf-8")
	public List<StorageListVO> storageList(String stuNo) {

		List<StorageListVO> vo = service.storageList(stuNo);

		log.info("issueList : ", vo);

		return vo;
	}
	*/

}


