package team.tttt.pms.project.alarm.service;

import java.util.List;

import team.tttt.pms.project.vo.AlarmVO;

public interface AlarmService {

	public void saveAlarm(AlarmVO aVO);

	public List<AlarmVO> alarmList(String projNo);


}
