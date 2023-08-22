package team.tttt.pms.stu.hakup.web;

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

import com.google.common.util.concurrent.AbstractService;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.utils.cmdcd.service.CmCdService;
import team.tttt.pms.common.vo.CmCdVO;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.stu.hakup.service.AttdanService;
import team.tttt.pms.stu.vo.AttdanVO;
import team.tttt.pms.stu.vo.StuVO;

@Slf4j
@Controller
@RequestMapping("/stu/hak")
public class AttdanController {
	@Inject
	private AttdanService attdanService;

	@Inject
	private CmCdService cmCdservice;


	@GetMapping("/attdan")
	public String attdan(Model model, Authentication auth) {
		// userNo 추출
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		String userNo = userVO.getUserNo();

		// modal에 들어갈 user 기본 정보
		StuVO stuVo = attdanService.selectStu(userNo);
		List<CmCdVO> attdanCmCdVO = cmCdservice.selectCode("S003");
		model.addAttribute("stuVo", stuVo);
		model.addAttribute("attdanCmCdVO", attdanCmCdVO);
		model.addAttribute("temp_title", "조퇴 외출");

		return "stu/com/hakup/attdan/attdan";
	}

	@ResponseBody
	@PostMapping(value ="/attdan",produces = "application/json;charset=utf-8")
	public ServiceResult insertAttdan(@RequestBody AttdanVO attdanVO, Authentication auth) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		String stuNo = userVO.getUserNo();

		attdanVO.setStuNo(stuNo);
		log.info("이건 출석/외출 인서트" + attdanVO);
		ServiceResult result = attdanService.insertAttdan(attdanVO);
		return result;
	}

	@ResponseBody
	@GetMapping(value = "/attdan/attdanList", produces = "application/json;charset=utf-8")
	public List<AttdanVO> attdanList(Authentication auth){
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		String stuNo = userVO.getUserNo();
		List<AttdanVO> attdanList = attdanService.selectAttdanList(stuNo);
		System.out.println("aList" + attdanList.size());
		return attdanList;
	}

	@ResponseBody
	@PostMapping(value = "/attdan/delete", produces = "application/json;charset=utf-8")
	public ServiceResult deleteAttdan(@RequestBody AttdanVO attdanVO) {
		ServiceResult result = attdanService.deleteAttdan(attdanVO.getAttdanNo());
		return result;
	}
}
