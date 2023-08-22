package team.tttt.pms.emp.schedule.service.Impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.emp.schedule.mapper.ScheduleMapper;
import team.tttt.pms.emp.schedule.service.ScheduleService;
import team.tttt.pms.emp.vo.SbjctVO;
import team.tttt.pms.emp.vo.SvlfVO;

@Service
public class ScheduleServiceImpl implements ScheduleService{

	@Inject
	private ScheduleMapper scheduleMapper;

	@Override
	public List<SvlfVO> svlfAllList() {
		return scheduleMapper.svlfAllList();
	}

	@Override
	public List<SbjctVO> sbjctInfoList(String svlfNo) {
		return scheduleMapper.sbjctInfoList(svlfNo);
	}

}
