package team.tttt.pms.tch.damdang.service;

import java.util.List;

import team.tttt.pms.stu.vo.StuVO;

public interface TchStuListService {

	public List<StuVO> selectStuList(String userNo);

}
