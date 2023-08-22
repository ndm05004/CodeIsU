package team.tttt.pms.project.chatting.web;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.project.memManage.service.MemManagementService;
import team.tttt.pms.project.task.service.ProjectTaskService;
import team.tttt.pms.project.vo.MemManagementVO;

@Controller
@RequestMapping("/pms/project")
@Slf4j
public class ChattingController {

	@Inject
	private ProjectTaskService service;

	@RequestMapping("/chatting")
	public String list(Authentication auth, String projNo, Model model, HttpSession session) {

		CustomUser mVO = (CustomUser) auth.getPrincipal();
	    UserVO userVO = mVO.getMember();
	    String userNo = userVO.getUserNo();

	    Map<String, String> mjMap = new HashMap<String, String>();
        mjMap.put("userNo", userNo);
        mjMap.put("projNo", projNo);

        MemManagementVO memVO = service.getMemJbttlCd(mjMap);

        model.addAttribute("memVO",memVO);
	    model.addAttribute("userNo", userNo);
	    model.addAttribute("projNo", projNo);
	    model.addAttribute("userVo", userVO);

	    session.setAttribute("userVO" ,userVO);
	    session.setAttribute("projNo" ,projNo);

		return "pms/com/chatting";
	}


}
