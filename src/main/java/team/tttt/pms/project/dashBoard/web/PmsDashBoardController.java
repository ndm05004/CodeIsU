package team.tttt.pms.project.dashBoard.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.project.dashBoard.service.PmsDashBoardService;
import team.tttt.pms.project.vo.IssueVO;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.ProjVO;
import team.tttt.pms.project.vo.ProjectMemberSttrVO;
import team.tttt.pms.project.vo.TaskVO;

@Controller
@RequestMapping("/pms/project")
@Slf4j
public class PmsDashBoardController {

	@Inject
	PmsDashBoardService service;

	@RequestMapping("/dashBoard")
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

		return "pms/com/pmsDashBoard";
	}


	// 프로젝트 멤버 추출
    @ResponseBody
    @GetMapping(value="/projectInfo", produces = "application/json;charset=utf-8")
    public ProjVO getProject (String projNo) {

       log.info("------------- projectInfo 실행 "+ projNo);

       ProjVO vo = service.getProject(projNo);

        return vo;
    }

    // 프로젝트 일감 추출
    @ResponseBody
    @GetMapping(value="/ProjectTaskInfo", produces = "application/json;charset=utf-8")
    public List<TaskVO> getTask (String projNo) {

       log.info("------------- ProjectTaskInfo 실행 "+ projNo);

       List<TaskVO> vo = service.getTask(projNo);

        return vo;
    }

    // 프로젝트 팀원 조회
    @ResponseBody
    @GetMapping(value="/ProjectMemberInfo", produces = "application/json;charset=utf-8")
    public Map<String, Object> ProjectMemberInfo (String projNo) {

    	log.info("------------- ProjectMemberInfo 실행 "+ projNo);

    	Map<String, Object> map = service.memList(projNo);

    	return map;
    }

    // 프로젝트 팀원 진척도 조회
	/*
	 * @ResponseBody
	 *
	 * @GetMapping(value="/proMemProgress", produces =
	 * "application/json;charset=utf-8") public List<ProjectMemberSttrVO>
	 * proMemProgress (String projNo) {
	 *
	 * log.info("------------- proMemProgress 실행 "+ projNo);
	 *
	 * List<ProjectMemberSttrVO> vo = service.proMemProgress(projNo);
	 *
	 * return vo; }
	 */


    // 프로젝트 팀원 진척도 조회
    @ResponseBody
    @GetMapping(value="/getIssue", produces = "application/json;charset=utf-8")
    public List<IssueVO> getIssue (String projNo) {

    	log.info("------------- getIssue 실행 "+ projNo);

    	List<IssueVO> vo = service.getIssue(projNo);

    	return vo;
    }

    // 프로젝트 내 내 일감 & 이슈 갯수 조회
    @ResponseBody
    @GetMapping(value="/getCountMyTaskAndIssue", produces = "application/json;charset=utf-8")
    public Map<String, Object> getCountMyTaskAndIssue(@RequestParam String projNo, @RequestParam String stuNo) {

        Map<String, String> map = new HashMap<>();
        map.put("projNo", projNo);
        map.put("stuNo", stuNo);

    	Map<String, Object> countMap = service.getCountMyTaskAndIssue(map);

    	return countMap;
    }


    // 같은 프로젝트 내 조원 일감 & 이슈 조회
    @ResponseBody
    @GetMapping(value="/getCountMemberTaskAndIssue", produces = "application/json;charset=utf-8")
    public Map<String, Object> getCountMemberTaskAndIssue(@RequestParam String projNo, @RequestParam String stuNo) {

        Map<String, String> map = new HashMap<>();
        map.put("projNo", projNo);
        map.put("stuNo", stuNo);

    	Map<String, Object> indivisualMap = service.getCountMemberTaskAndIssue(map);

    	return indivisualMap;
    }


	// 프로젝트 멤버 추출
    @ResponseBody
    @GetMapping(value="/getProjNm", produces = "application/json;charset=utf-8")
    public List<ProjVO> projInfo (String projNo) {

       log.info("------------- projNm 실행 "+ projNo);

       List<ProjVO> projNm = service.getProjNm(projNo);

        return projNm;
    }




}
