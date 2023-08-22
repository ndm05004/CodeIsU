package team.tttt.pms.tch.damdang.web;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.stu.vo.StuVO;
import team.tttt.pms.tch.classroom.web.TchQstnController;
import team.tttt.pms.tch.damdang.service.TchStuListService;

@Slf4j
@Controller
@RequestMapping("/tch")
public class TchStuListController {
	@Inject
	private TchStuListService tchStuListService;

	@GetMapping("/dam/stulist")
	public String stuList(Model model, Authentication auth) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		String userNo = userVO.getUserNo();
		List<StuVO> stuList = tchStuListService.selectStuList(userNo);
		model.addAttribute("stuList", stuList);
		return "tch/com/damdang/stuList";
	}

}
