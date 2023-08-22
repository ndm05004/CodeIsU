package team.tttt.pms.project.dashBoard.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.project.vo.IssueVO;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.ProjVO;
import team.tttt.pms.project.vo.ProjectMemberSttrVO;
import team.tttt.pms.project.vo.TaskVO;
import team.tttt.pms.project.vo.memberInfoVO;

@Mapper
public interface PmsDashBoardMapper {

	List<TaskVO> getTask(String projNo);

	ProjVO getProject(String projNo);

	List<memberInfoVO> memList(String projNo);

	List<IssueVO> getIssue(String projNo);

	MemManagementVO getMemJbttlCd(Map<String, String> mjMap);

	List<TaskVO> countMyTask(Map<String, String> map);

	List<IssueVO> countMyIssue(Map<String, String> map);

	List<TaskVO> indivisualTask(Map<String, String> map);

	List<IssueVO> indivisualIssue(Map<String, String> map);

	MemManagementVO indivisualInfo(Map<String, String> map);

	ProjectMemberSttrVO indivisualSttr(Map<String, String> map);

	List<ProjVO> getProjNm(String projNo);

}
