package team.tttt.pms.stu.classroom.web;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.AtchFileVO;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.stu.classroom.service.StuAsmtService;
import team.tttt.pms.tch.vo.AsmtVO;
import team.tttt.pms.tch.vo.QstAnswerVO;
import team.tttt.pms.tch.vo.SbmsnVO;

@Slf4j
@Controller
@RequestMapping("/stu/classroom")
public class StuAsmtController {

	@Inject
	private StuAsmtService stuAsmtService;

	@GetMapping("/assign")
	public String asmt2(@RequestParam("sbjctCd") String sbjctCd, Model model) {
		model.addAttribute("sbjctCd", sbjctCd);
		model.addAttribute("temp_title", "과제");
		return "stu/com/classroom/asmtList";
	}

	// 과제 리스트
	@GetMapping("/assign/asmtList")
	@ResponseBody
	public List<AsmtVO> asmtList(@RequestParam("sbjctCd") String sbjctCd, Authentication auth) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
        UserVO userVO = mVO.getMember();
        String userNo = userVO.getUserNo();
		List<AsmtVO> asmtList = stuAsmtService.selectAsmtList(sbjctCd, userNo); // 과제 리스트
		return asmtList;
	}

	// 문제풀기
	@GetMapping("/assign/sbmsn")
	public String sbmsn(
			@RequestParam("asmtNo") int asmtNo
			,@RequestParam("sbjctCd") String sbjctCd
			, Model model) {
		AsmtVO asmtVO = stuAsmtService.selectAmst(asmtNo);
		List<AtchFileVO> atchFileList = stuAsmtService.selectAtchFileList(asmtNo);
		model.addAttribute("asmtVO", asmtVO);
		model.addAttribute("sbjctCd", sbjctCd);
		model.addAttribute("asmtNo", asmtNo);
		model.addAttribute("atchFileList", atchFileList);
		model.addAttribute("temp_title", "과제 보기");
		return "stu/com/classroom/sbmsn";
	}

	@PostMapping("/assign/sbmsn")
	public String insertSbmsn(SbmsnVO sbmsnVO, Authentication auth) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
        UserVO userVO = mVO.getMember();
        String userNo = userVO.getUserNo();
		List<QstAnswerVO> astAnswerList = sbmsnVO.getQstAnswerList();
		String sbjctCd = sbmsnVO.getSbjctCd();
		ServiceResult result = stuAsmtService.insertSbmsn(astAnswerList,userNo,sbjctCd);
		return "redirect:/stu/classroom/assign/sbmsn/result?sbjctCd=" + sbjctCd + "&asmtNo=" +sbmsnVO.getAsmtNo();
	}

	// 문제 푼 결과
	@GetMapping("/assign/sbmsn/result")
	public String insertSbmsnResult(
			@RequestParam("asmtNo") int asmtNo
			,@RequestParam("sbjctCd") String sbjctCd
			, Authentication auth
			, Model model) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		String userNo = userVO.getUserNo();
		// 해당 유저가 해당 문제를 푼 결과
		List<SbmsnVO> sbmsnList = stuAsmtService.selectSbmsnList(userNo,asmtNo);
		model.addAttribute("sbmsnList", sbmsnList);
		model.addAttribute("sbjctCd", sbjctCd);
		AsmtVO asmtVO = stuAsmtService.selectAmst(asmtNo);
		List<AtchFileVO> atchFileList = stuAsmtService.selectAtchFileList(asmtNo);
		model.addAttribute("asmtVO", asmtVO);
		model.addAttribute("atchFileList", atchFileList);
		model.addAttribute("temp_title", "과제 결과");
		return "stu/com/classroom/sbmsnResult";
	}
}
