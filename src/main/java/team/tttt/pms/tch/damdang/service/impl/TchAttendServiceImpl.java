package team.tttt.pms.tch.damdang.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.emp.vo.AttdVO;
import team.tttt.pms.tch.damdang.mapper.TchAttendMapper;
import team.tttt.pms.tch.damdang.service.TchAttendService;

@Service
public class TchAttendServiceImpl implements TchAttendService{
	@Inject
	private TchAttendMapper tchAttendMapper;

	@Override
	public List<AttdVO> selectAttdList(String userNo, String attdDt) {
		return tchAttendMapper.selectAttdList(userNo, attdDt);
	}

}
