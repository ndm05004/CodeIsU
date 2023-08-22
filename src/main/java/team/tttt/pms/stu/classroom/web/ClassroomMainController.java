package team.tttt.pms.stu.classroom.web;

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
import team.tttt.pms.emp.vo.SbjctVO;
import team.tttt.pms.stu.classroom.service.ClassroomMainService;
import team.tttt.pms.stu.vo.StuVO;

@Slf4j
@Controller
@RequestMapping("/stu")
public class ClassroomMainController {
	@Inject
	private ClassroomMainService classroomService;

	@GetMapping("/classroom")
	public String classroom(
			Model model,
			Authentication auth
			) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		String userNo = userVO.getUserNo();
		List<SbjctVO> classroomList = classroomService.selectClassroomList(userNo);
		model.addAttribute("classroomList", classroomList);
		model.addAttribute("temp_title", "수업 선택");
		return "stu/com/classroom";
	}


}
