package team.tttt.pms.project.task.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
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
import team.tttt.pms.project.memManage.service.MemManagementService;
import team.tttt.pms.project.task.service.ProjectTaskService;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.ProjVO;
import team.tttt.pms.project.vo.TaskVO;

@RequestMapping("/pms/project")
@Slf4j
@Controller
public class ProjectTaskController{

   @Inject
   private ProjectTaskService service;

   @Inject
   private MemManagementService memService;

   @GetMapping("/taskList")
   public String getTaskList(Authentication auth, String projNo, Model model, HttpSession session) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
	    UserVO userVO = mVO.getMember();
	    String userNo = userVO.getUserNo();

	    Map<String, String> mjMap = new HashMap<String, String>();
        mjMap.put("userNo", userNo);
        mjMap.put("projNo", projNo);

        MemManagementVO memVO = service.getMemJbttlCd(mjMap);

        ProjVO pVO = service.getProjNm(projNo);
        String projNm = pVO.getProjNm();


        model.addAttribute("memVO",memVO);
	    model.addAttribute("userNo", userNo);
	    model.addAttribute("projNo", projNo);
	    model.addAttribute("userVo", userVO);
	    model.addAttribute("projNm", projNm);

	    return "pms/com/taskBoard";
   }

   // 업무 출력
   @PostMapping("/taskListOut")
   @ResponseBody
   public List<TaskVO> getTaskList(String projNo) {

   System.out.println("-----------------["+projNo+"]--------------------");
   List<TaskVO> taskList = service.taskList(projNo);
   log.info(taskList.size()+"");

   return taskList;
   }


   // 업무 상세보기
   @GetMapping("/taskDetail")
   @ResponseBody
   public TaskVO getDetailTask(String taskNo) {
      System.out.println(taskNo+"--------------- taskNo getDetailTask");
      TaskVO vo = service.getDetailTask(taskNo);
      return vo;
   }


   // 업무 삭제
   @DeleteMapping("/taskDelete")
   @ResponseBody
   public String deleteTask(@RequestBody Map<String, String> map) {

      String msg;

      System.out.println(map.get("taskNo")+"--------------- taskDelete");

      ServiceResult result = service.taskDelete(map.get("taskNo"));

        if (result.equals(ServiceResult.OK)) {
            msg = "성공";
        } else {
           msg = "실패";
        }
      return msg;
   }

   // 프로젝트 멤버 추출
    @ResponseBody
    @GetMapping(value="/extractMem",produces = "application/json;charset=utf-8")
    public List<MemManagementVO> memList(String projNo) {

       log.info("------------- mem.do 실행 "+ projNo);

        List<MemManagementVO> memList = memService.memList(projNo);

        log.info(" memList 사이즈 : "+memList.size());

        return memList;
    }

    // 일감 업데이트 모달창
    @ResponseBody
    @PutMapping(value="/updateTask",produces = "application/json;charset=utf-8" )
    public String updateTask(@RequestBody TaskVO updateTask) {

       log.info("updateTask.getTaskBengDt()   : " + updateTask.getTaskBengDt());
       log.info("updateTask.getTaskDdlnDt()   : " + updateTask.getTaskDdlnDt());
       log.info("updateTask.getTaskCn()       : " + updateTask.getTaskCn());
       log.info("updateTask.getTaskNo()       : " + updateTask.getTaskNo());
       log.info("updateTask.getTaskPriority() : " + updateTask.getTaskPriority());
       log.info("updateTask.getTaskRegDt()      : " + updateTask.getTaskRegDt());
       log.info("updateTask.getTaskSttr()       : " + updateTask.getTaskSttr());
       log.info("updateTask.getTaskStts()       : " + updateTask.getTaskStts());
       log.info("updateTask.getTaskTitle()    : " + updateTask.getTaskTitle());

       ServiceResult result = service.taskUpdate(updateTask);

       String msg ="";

        if (result.equals(ServiceResult.OK)) {
            msg = "성공";
        } else {
           msg = "실패";
        }
       return msg;
    }

   // 프로젝트 상위 일감 추출
    @ResponseBody
    @GetMapping(value="/upperTask",produces = "application/json;charset=utf-8")
    public List<TaskVO> upperTask(String projNo) {

       log.info("------------- upperTask 실행 "+ projNo);

       List<TaskVO> upperTask = service.upperTask(projNo);

       return upperTask;
    }

    // 업무 추가
    @ResponseBody
    @PostMapping(value="/insertTask",produces = "application/json;charset=utf-8")
    public String insertTask(@RequestBody TaskVO insertTask ,Authentication auth) {

       CustomUser mVO = (CustomUser) auth.getPrincipal();
	   UserVO userVO = mVO.getMember();
	   String uNo = userVO.getUserNo();
	   insertTask.setStuNo(uNo);

       ServiceResult result = service.insertTask(insertTask);

       String msg ="";

        if (result.equals(ServiceResult.OK)) {
            msg = "성공";
        } else {
           msg = "실패";
        }
       return msg;
    }




}