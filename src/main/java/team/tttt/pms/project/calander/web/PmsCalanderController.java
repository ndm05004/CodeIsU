package team.tttt.pms.project.calander.web;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.project.dashBoard.service.PmsDashBoardService;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.TaskVO;

@Controller
@RequestMapping("/pms/project")
public class PmsCalanderController {

	@Inject
	PmsDashBoardService service;

	@RequestMapping("/calander")
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
        model.addAttribute("projNo",projNo);
        model.addAttribute("userVO",userVO);
	    session.setAttribute("userVO" ,userVO);
	    session.setAttribute("projNo" ,projNo);

		return "pms/com/taskCalander";
	}


}
