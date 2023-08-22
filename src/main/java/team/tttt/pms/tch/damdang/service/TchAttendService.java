package team.tttt.pms.tch.damdang.service;

import java.util.List;

import team.tttt.pms.emp.vo.AttdVO;

public interface TchAttendService {

	public List<AttdVO> selectAttdList(String userNo, String attdDt);

}
