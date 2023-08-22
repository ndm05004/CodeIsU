package team.tttt.pms.project.kanban.web;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kotlin.PublishedApi;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.project.kanban.service.PmsKanbanService;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.TaskVO;

@Controller
@RequestMapping("/pms/project")
public class PmsKanbanController {

	@Inject
	private PmsKanbanService service;



	@RequestMapping("/kanban")
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



		return "pms/com/taskKanban";
	}


	@PutMapping(value = "/moveboard", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String moveBoard(@RequestBody TaskVO vo) {

		Map<String, Object> moveBoard = new HashMap<String, Object>();
		moveBoard.put("taskVO", vo);

		ServiceResult result =  service.moveBoard(moveBoard);

		String msg="";
		if (result.equals(ServiceResult.OK)) {
			msg = "성공";
		} else {
			msg = "실패";
		}
		return msg;

	}



}
