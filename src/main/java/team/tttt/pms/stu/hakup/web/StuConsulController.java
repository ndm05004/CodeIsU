package team.tttt.pms.stu.hakup.web;

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
import team.tttt.pms.common.utils.cmdcd.service.CmCdService;
import team.tttt.pms.common.vo.CmCdVO;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.emp.vo.DscsnVO;
import team.tttt.pms.emp.vo.EmpVO;
import team.tttt.pms.stu.hakup.service.StuConsulService;
import team.tttt.pms.stu.vo.AttdanVO;

@Slf4j
@Controller
@RequestMapping("/stu/hak")
public class StuConsulController {

	@Inject
    private StuConsulService stuConsulService;

	@Inject
	private CmCdService cmCdservice;

	@GetMapping("/consult")
	public String consul(Model model, Authentication auth) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		String stuNo = userVO.getUserNo();
		// 상담코드
		List<CmCdVO> consulCmCdVO = cmCdservice.selectCode("D003");
		model.addAttribute("consulCmCdVO", consulCmCdVO);
		// 상담원 이름, 번호 리스트
		List<EmpVO> empList = stuConsulService.selectEmpList(stuNo);
		model.addAttribute("empList", empList);
		model.addAttribute("temp_title", "상담 신청");
		return "stu/com/hakup/consul/consulRequest";
	}

	@PostMapping(value = "/consult", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ServiceResult insertConsul(@RequestBody DscsnVO dscsnVO, Authentication auth) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		String stuNo = userVO.getUserNo();
		dscsnVO.setStuNo(stuNo);
		ServiceResult result = stuConsulService.insertConsul(dscsnVO);
		return result;
	}

	// 신청한 상담 내역 조회
	@PostMapping(value = "/consult/list", produces = "application/json;charset=utf-8")
	@ResponseBody
	public Map<String, Object> selectConsulList(Authentication auth) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		String stuNo = userVO.getUserNo();
		Map<String, Object> map = stuConsulService.selectConsulMap(stuNo);

		return map;
	}

	@ResponseBody
	@PostMapping(value = "/consult/delete", produces = "application/json;charset=utf-8")
	public ServiceResult deleteDscsn(@RequestBody DscsnVO dscsnVO) {
		ServiceResult result = stuConsulService.deleteDscsn(dscsnVO.getDscsnNo());
		return result;
	}


}
