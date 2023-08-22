package team.tttt.pms.project.task.service;

import java.util.List;
import java.util.Map;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.ProjVO;
import team.tttt.pms.project.vo.TaskVO;

public interface ProjectTaskService {

	// 업무 목록 조회
	public List<TaskVO> taskList(String projNo);

	// 업무 상세조회
	public TaskVO taskDetail(String taskNo);

	// 업무 삭제
	public ServiceResult taskDelete(String taskNo);

	// 업무 업데이트
	public ServiceResult taskUpdate(TaskVO taskVO);

	// 업무
	public TaskVO getDetailTask(String taskNo);

	// 상위 업무 검색
	public List<TaskVO> upperTask(String projNo);

	// 업무 추가
	public ServiceResult insertTask(TaskVO insertTask);

	//메뉴 권한 체크 위한 직급 검색
	public MemManagementVO getMemJbttlCd(Map<String, String> mjMap);

	public ProjVO getProjNm(String projNo);

}
