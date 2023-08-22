package team.tttt.pms.tch.classroom.service;

import java.util.List;

import team.tttt.pms.tch.vo.TchVO;

public interface ClassMainService {
	public List<TchVO> selectClassList(String userNo);

	public List<TchVO> selectLastClassList(String userNo);
}
