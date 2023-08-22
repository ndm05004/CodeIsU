package team.tttt.pms.tch.classroom.web;

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
import team.tttt.pms.tch.classroom.service.ClassMainService;
import team.tttt.pms.tch.vo.TchVO;

@Slf4j
@Controller
@RequestMapping("/tch")
public class ClassMainController {
	@Inject
	private  ClassMainService classMainService;

	@GetMapping("/class")
	public String classroomMain(Model model, Authentication auth) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		String userNo = userVO.getUserNo();
		List<TchVO> classList = classMainService.selectClassList(userNo);
		List<TchVO> lastClassList = classMainService.selectLastClassList(userNo);
		model.addAttribute("classList", classList);
		model.addAttribute("lastClassList", lastClassList);
		model.addAttribute("temp_title", "수업선택");
		return "tch/com/class";
	}
}
