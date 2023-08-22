package team.tttt.pms.project.dashBoard.service;

import java.util.List;
import java.util.Map;

import team.tttt.pms.project.vo.IssueVO;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.ProjVO;
import team.tttt.pms.project.vo.ProjectMemberSttrVO;
import team.tttt.pms.project.vo.TaskVO;

public interface PmsDashBoardService {

	ProjVO getProject(String projNo);

	List<TaskVO> getTask(String projNo);

	Map<String, Object> memList(String projNo);

	List<IssueVO> getIssue(String projNo);

	MemManagementVO getMemJbttlCd(Map<String, String> mjMap);

	Map<String, Object> getCountMyTaskAndIssue(Map<String, String> map);

	Map<String, Object> getCountMemberTaskAndIssue(Map<String, String> map);

	List<ProjVO> getProjNm(String projNo);



}
