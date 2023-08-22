package team.tttt.pms.project.gantt.mapper;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.project.vo.TaskVO;

@Mapper
public interface PmsGanttMapper {

	int updateTask(TaskVO updateTask);

}
