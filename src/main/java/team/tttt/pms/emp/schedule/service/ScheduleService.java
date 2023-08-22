package team.tttt.pms.emp.schedule.service;

import java.util.List;

import team.tttt.pms.emp.vo.SbjctVO;
import team.tttt.pms.emp.vo.SvlfVO;

public interface ScheduleService {

	public List<SvlfVO> svlfAllList();
	public List<SbjctVO> sbjctInfoList(String svlfNo);
}
