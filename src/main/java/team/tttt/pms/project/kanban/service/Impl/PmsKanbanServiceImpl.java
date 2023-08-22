package team.tttt.pms.project.kanban.service.Impl;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.project.kanban.mapper.PmsKanbanMapper;
import team.tttt.pms.project.kanban.service.PmsKanbanService;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.TaskVO;

@Service
public class PmsKanbanServiceImpl implements PmsKanbanService {

	@Inject
	private PmsKanbanMapper mapper;

	@Override
	public ServiceResult moveBoard(Map<String, Object> moveBoard) {

		TaskVO taskVO = (TaskVO) moveBoard.get("taskVO");

		if(taskVO.getTaskSttr() == 100 || taskVO.getTaskStts() == "P003-4") {
			taskVO.setTaskSttr(100);
			taskVO.setTaskStts("P003-4");
		}

		int cnt = mapper.moveBoard(taskVO);

		ServiceResult result;

		if(cnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}

		return result;
	}

	@Override
	public MemManagementVO getMemJbttlCd(Map<String, String> mjMap) {
		return mapper.getMemJbttlCd(mjMap);
	}

}
