package team.tttt.pms.project.dashBoard.service.Impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import team.tttt.pms.project.dashBoard.mapper.PmsDashBoardMapper;
import team.tttt.pms.project.dashBoard.service.PmsDashBoardService;
import team.tttt.pms.project.task.mapper.ProjectTaskMapper;
import team.tttt.pms.project.vo.IssueVO;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.ProjVO;
import team.tttt.pms.project.vo.ProjectMemberSttrVO;
import team.tttt.pms.project.vo.TaskVO;
import team.tttt.pms.project.vo.memberInfoVO;

@Service
public class PmsDashBoardServiceImpl implements PmsDashBoardService {

	@Inject
	private PmsDashBoardMapper mapper;


	@Override
	public ProjVO getProject(String projNo) {
		return mapper.getProject(projNo);
	}

	@Override
	public List<TaskVO> getTask(String projNo) {
		return mapper.getTask(projNo);
	}

	@Override
	public Map<String, Object> memList(String projNo) {

		List<memberInfoVO> memManagement =  mapper.memList(projNo);

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("memList", memManagement);

		return map;
	}


	@Override
	public List<IssueVO> getIssue(String projNo) {
		// TODO Auto-generated method stub
		return mapper.getIssue(projNo);
	}

	@Override
	public MemManagementVO getMemJbttlCd(Map<String, String> mjMap) {
		return mapper.getMemJbttlCd(mjMap);
	}

	@Override
	@Transactional
	public Map<String, Object> getCountMyTaskAndIssue(Map<String, String> map) {

		List<TaskVO> taskCount  =  mapper.countMyTask(map);
		List<IssueVO> issueCount =  mapper.countMyIssue(map);

		Map<String, Object> countMap = new HashMap<>();

		countMap.put("taskCount", taskCount);
		countMap.put("issueCount", issueCount);

		return countMap;
	}

	@Override
	public Map<String, Object> getCountMemberTaskAndIssue(Map<String, String> map) {


		List<TaskVO>  indivisualTask  =  mapper.indivisualTask(map);
		List<IssueVO> indivisualIssue =  mapper.indivisualIssue(map);
		MemManagementVO indivisualInfo = mapper.indivisualInfo(map);
		ProjectMemberSttrVO indivisualSttr = mapper.indivisualSttr(map);


		Map<String, Object> indivisualMap = new HashMap<>();

		indivisualMap.put("indivisualTask", indivisualTask);
		indivisualMap.put("indivisualIssue", indivisualIssue);
		indivisualMap.put("indivisualInfo", indivisualInfo);
		indivisualMap.put("indivisualSttr", indivisualSttr);

		return indivisualMap;
	}

	@Override
	public List<ProjVO> getProjNm(String projNo) {

		return mapper.getProjNm(projNo);
	}





}
