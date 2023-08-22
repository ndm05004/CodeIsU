package team.tttt.pms.tch.damdang.web;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.emp.vo.AttdVO;
import team.tttt.pms.stu.hakup.service.AttdanService;
import team.tttt.pms.tch.damdang.service.TchAttendService;

@Slf4j
@Controller
@RequestMapping("/tch")
public class TchAttendController {
	@Inject
	private TchAttendService tchAttdanService;

	@GetMapping("/dam/attdan")
	public String attdan() {
		return "tch/com/damdang/addtanList";
	}

	@GetMapping("/dam/attdan/attdanList")
	@ResponseBody
	public List<AttdVO> attdan(String attdDt, Authentication auth) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		String userNo = userVO.getUserNo();
		List<AttdVO> attdList = tchAttdanService.selectAttdList(userNo, attdDt);
		return attdList;
	}
}
