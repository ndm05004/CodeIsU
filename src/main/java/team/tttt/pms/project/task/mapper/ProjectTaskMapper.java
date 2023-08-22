package team.tttt.pms.project.task.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.project.vo.ASGVO;
import team.tttt.pms.project.vo.AlarmVO;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.ProjVO;
import team.tttt.pms.project.vo.TaskVO;

@Mapper
public interface ProjectTaskMapper {

	int insertUpperTask(TaskVO taskVO);

	int insertLowerTask(TaskVO taskVO);

	List<TaskVO> taskList(String projNo);

	TaskVO taskDetail(String taskNo);

	int taskDelete(String taskNo);

	int taskUpdate(TaskVO taskVO);

	int deleteTaskPic(ASGVO asgVO);

	int updateTaskPic(ASGVO asgVO);

	int insertTaskPic(ASGVO asgVO);

	List<ASGVO> searchTaskPic(String taskNo);

	List<TaskVO> upperTask(String projNo);

	MemManagementVO getMemJbttlCd(Map<String, String> mjMap);

	int insertAlarm(AlarmVO alarmVO);

	ProjVO getProjNm(String projNo);



}
