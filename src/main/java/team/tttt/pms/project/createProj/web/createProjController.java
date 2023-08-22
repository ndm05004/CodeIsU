package team.tttt.pms.project.createProj.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import team.tttt.pms.project.createProj.service.createProjService;
import team.tttt.pms.project.vo.MemJoinAplyVO;
import team.tttt.pms.project.vo.ProjVO;


@Controller
@Slf4j
@RequestMapping("/pms")
public class createProjController {

	@Inject
	private createProjService projService;


	//프로젝트생성 화면
	@GetMapping(value="/projects")
	public String createProj(Authentication auth, Model model) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
	    UserVO userVO = mVO.getMember();
	    String userNo = userVO.getUserNo();

	    model.addAttribute("userNo", userNo);
        model.addAttribute("userVO",userVO);


		return "pms/com/createProj";
	}

	//프로젝트 총 리스트
	@ResponseBody
	@GetMapping(value="/projlist", produces = "application/json;charset=utf-8")
	public List<ProjVO> projList(ProjVO vo){
		List<ProjVO> list = projService.projList(vo);
		log.info("projlist"+list);
		return list;
	}

	//프로젝트 생성
	@ResponseBody
	@PostMapping(value="/insertproj", produces = "application/json;charset=utf-8")
	public String insertProj(@RequestBody ProjVO projVO) {

    	ServiceResult result = projService.insertProj(projVO);

    	String goPage ="";

    	if (result.equals(ServiceResult.OK)) {
            goPage = "성공";
        } else {
            goPage = "실패";
        }
        return goPage;
    }

	//프로젝트 지원 신청
	@ResponseBody
	@PostMapping(value="/insertaply", produces = "application/json;charset=utf-8")
	public String insertAply(@RequestBody MemJoinAplyVO aplyVO) {


		ServiceResult result = projService.insertAply(aplyVO);

		String goPage ="";

		if (result.equals(ServiceResult.OK)) {
			goPage = "성공";
		} else {
			goPage = "실패";
		}
		return goPage;
	}


	@ResponseBody
	@PostMapping(value="/detail",produces = "application/json;charset=utf-8" )
	public ProjVO detail(@RequestBody String projNo) {

		ProjVO vo = new ProjVO();
		vo = projService.detail(projNo);

		return vo;
	}

	@ResponseBody
	@PostMapping(value="/yn" ,produces = "application/json;charset=utf-8" )
	public List<ProjVO> aplyYn(@RequestBody String stuNo) {

		List<ProjVO> vo = projService.aplyYn(stuNo);
		log.info("stuNo::: ", vo);

		return vo;
	}


}
