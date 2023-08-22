package team.tttt.pms.stu.classroom.service;

import java.util.List;

import team.tttt.pms.common.vo.AtchFileVO;

public interface StuStorageService {

	public List<AtchFileVO> selectStorageList(String sbjctCd);

}
