package team.tttt.pms.project.kanban.service;

import java.util.Map;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.project.vo.MemManagementVO;

public interface PmsKanbanService {

	ServiceResult moveBoard(Map<String, Object> moveBoard);

	MemManagementVO getMemJbttlCd(Map<String, String> mjMap);

}
