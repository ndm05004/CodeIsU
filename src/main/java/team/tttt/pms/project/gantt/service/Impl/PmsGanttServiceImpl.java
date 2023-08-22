package team.tttt.pms.project.gantt.service.Impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.project.gantt.mapper.PmsGanttMapper;
import team.tttt.pms.project.gantt.service.PmsGanttService;
import team.tttt.pms.project.task.mapper.ProjectTaskMapper;
import team.tttt.pms.project.vo.TaskVO;

@Service
public class PmsGanttServiceImpl implements PmsGanttService {

	@Inject
	private PmsGanttMapper mapper;

	@Override
	public ServiceResult updateTask(TaskVO updateTask) {

		int cnt = mapper.updateTask(updateTask);

		if(cnt > 0){
			return ServiceResult.OK;
		}else {
			return ServiceResult.FAILED;
		}

	}



}
