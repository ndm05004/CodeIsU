package team.tttt.pms.project.myProjects.web;


import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.project.myProjects.service.myProjectsService;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.ProjVO;

@Controller
@Slf4j
@RequestMapping("/pms")
public class myProjectsController {

	@Inject
	private myProjectsService myProjectsService;

	@GetMapping(value="/myprojects")
	public String myProjects(Authentication auth, Model model) {

		CustomUser mVO = (CustomUser) auth.getPrincipal();
	    UserVO userVO = mVO.getMember();
	    String userNo = userVO.getUserNo();

	    model.addAttribute("userNo", userNo);
		return "pms/com/myProjects";
	}

	@ResponseBody
	@GetMapping(value="/myprojlist", produces = "application/json;charset=utf-8")
	public List<ProjVO> myProjList(ProjVO vo){

		log.info("public List<ProjVO> myProjList(String stuNo, String projSttsCd) " + vo);

		List<ProjVO> list = myProjectsService.myProjList(vo);
		log.info("public List<ProjVO> myProjList : " + list);

		return list;
	}

	@ResponseBody
	@PostMapping(value="/delmyproj", produces = "application/json;charset=utf-8")
	public String delMyProj(@RequestBody ProjVO projVO) {

		String goPage = "";
		ServiceResult result = myProjectsService.delMyProj(projVO);
		if (result.equals(ServiceResult.OK)) {
			goPage = "성공";
		} else {
			goPage = "실패";
		}
		return goPage;
	}


}
