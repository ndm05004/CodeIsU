package team.tttt.pms.project.gantt.service;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.project.vo.TaskVO;

public interface PmsGanttService {

	public ServiceResult updateTask(TaskVO updateTask);

}
