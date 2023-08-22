package team.tttt.pms.project.alarm.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.project.alarm.mapper.AlarmMapper;
import team.tttt.pms.project.alarm.service.AlarmService;
import team.tttt.pms.project.vo.AlarmVO;

@Service
public class AlarmServiceImpl implements AlarmService{

	@Inject
	private AlarmMapper mapper;

	@Override
	public void saveAlarm(AlarmVO aVO) {
		mapper.saveAlarm(aVO);
	}

	@Override
	public List<AlarmVO> alarmList(String projNo) {
		return mapper.alarmList(projNo);
	}




}
