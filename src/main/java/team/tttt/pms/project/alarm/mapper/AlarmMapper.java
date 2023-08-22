package team.tttt.pms.project.alarm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.project.vo.AlarmVO;

@Mapper
public interface AlarmMapper {

	public void saveAlarm(AlarmVO aVO);

	public List<AlarmVO> alarmList(String projNo);


}
