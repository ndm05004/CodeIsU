package team.tttt.pms.tch.main.web;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.emp.vo.SbjctVO;
import team.tttt.pms.stu.vo.QstnVO;
import team.tttt.pms.tch.main.service.TchMainService;
import team.tttt.pms.tch.vo.AsmtVO;
import team.tttt.pms.tch.vo.TchVO;

@Slf4j
@Controller
@RequestMapping("/tch")
public class TchMainController {

	@Inject
	private TchMainService service;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String tchMain(Authentication auth, Model model) {

		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();

		log.info("정보" + userVO.getUserAddr());
		System.out.println(userVO);

		model.addAttribute("temp_title", "강사 대시보드");

		return "tch/com/main";
	}

	// 시간표 - 오전, 오후
	@ResponseBody
	@GetMapping(value = "/timetable", produces = "application/json;charset=utf-8")
	public List<TchVO> timetable(Authentication auth) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		String userNo = userVO.getUserNo();
		List<TchVO> classList = service.selectClassList(userNo);

		log.info("classList : " + classList);
		return classList;
	}

	// 미답변 리스트 목록
	@ResponseBody
	@GetMapping(value = "/qstnlist", produces = "application/json;charset=utf-8")
	public List<QstnVO> qstnAnsNoList(Authentication auth) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		String userNo = userVO.getUserNo();
		List<QstnVO> qstnAnsNoList = service.selectQntnAnsNoList(userNo);

		log.info("qstnList : " + qstnAnsNoList);
		return qstnAnsNoList;
	}

	// 과제 리스트 목록
	@ResponseBody
	@GetMapping(value = "/asmtList", produces = "application/json;charset=utf-8")
	public List<QstnVO> asmtList(Authentication auth) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		String userNo = userVO.getUserNo();
		List<QstnVO> asmtList = service.selectAsmtList(userNo);
		log.info("qstnList : " + asmtList);
		return asmtList;
	}

}
