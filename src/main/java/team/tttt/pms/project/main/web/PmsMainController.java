package team.tttt.pms.project.main.web;

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
import team.tttt.pms.project.main.service.MainService;
import team.tttt.pms.project.vo.MemJoinAplyVO;
import team.tttt.pms.project.vo.ProjVO;
import team.tttt.pms.stu.vo.ProjListVO;

@Slf4j
@Controller
@RequestMapping("/pms")
public class PmsMainController {

	@Inject
	private MainService service;


	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String tchMain(Authentication auth, Model model) {

	CustomUser mVO = (CustomUser) auth.getPrincipal();
	UserVO userVO = mVO.getMember();
	String userNo = userVO.getUserNo();

	model.addAttribute("userNo", userNo);
	log.info("정보" + userVO.getUserAddr());
	System.out.println(userVO);

	return "pms/com/main";


	}


	//프로젝트 리스트 (제목만)
	@ResponseBody
	@GetMapping(value = "/projlist2", produces = "application/json;charset=utf-8")
	public List<ProjVO> pList(String stuNo) {
		log.info("컨트롤러 : " + stuNo);

		List<ProjVO> vo = service.pList(stuNo);

		log.info("projList : ", vo);

		return vo;
	}



	//프로젝트 가입 신청 리스트
	@ResponseBody
	@GetMapping(value = "/aplylist", produces = "application/json;charset=utf-8")
	public List<MemJoinAplyVO> aplyList(String stuNo) {
		log.info("컨트롤러 : " + stuNo);

		List<MemJoinAplyVO> vo = service.aplyList(stuNo);

		log.info("aplyList : ", vo);

		return vo;
	}

}
