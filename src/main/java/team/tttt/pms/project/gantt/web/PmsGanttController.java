package team.tttt.pms.project.gantt.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Update;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.project.gantt.service.PmsGanttService;
import team.tttt.pms.project.task.service.ProjectTaskService;
import team.tttt.pms.project.task.web.ProjectTaskController;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.TaskVO;

@RequestMapping("/pms/project")
@Slf4j
@Controller
public class PmsGanttController {

	@Inject
	private ProjectTaskService service;

	@Inject
	private PmsGanttService ganttService;

	@GetMapping("/gantt")
	public String getTaskList(Authentication auth, String projNo, Model model, HttpSession session) {
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

	        return "pms/com/taskGantt";
	}


	// 업무 출력
	@GetMapping("/ganttTask")
	@ResponseBody
	public List<TaskVO> getTaskList(String projNo) {

		System.out.println("-----------------[" + projNo + "]--------------------");
		List<TaskVO> taskList = service.taskList(projNo);
		log.info(taskList.size() + "");

		return taskList;
	}

	@PutMapping("/ganttTaskUpdate")
	@ResponseBody
	public String updateTask(@RequestBody TaskVO updateTask) {
		log.info("-------- updateTask -------- : : : " + updateTask);

		ServiceResult result = ganttService.updateTask(updateTask);

		String msg = "";

		if (result.equals(ServiceResult.OK)) {
			msg = "성공";
		} else {
			msg = "실패";
		}
		return msg;
	}

}
