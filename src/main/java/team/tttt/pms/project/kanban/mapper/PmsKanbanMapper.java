package team.tttt.pms.project.kanban.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.TaskVO;

@Mapper
public interface PmsKanbanMapper {

	int moveBoard(TaskVO vo);

	MemManagementVO getMemJbttlCd(Map<String, String> mjMap);


}
