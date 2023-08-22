package team.tttt.pms.emp.schedule.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.emp.vo.SbjctVO;
import team.tttt.pms.emp.vo.SvlfVO;

@Mapper
public interface ScheduleMapper {
	public List<SvlfVO> svlfAllList();
	public List<SbjctVO> sbjctInfoList(String svlfNo);
}
