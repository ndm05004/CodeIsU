package team.tttt.pms.stu.classroom.service;

import java.util.List;

import team.tttt.pms.emp.vo.SbjctVO;
import team.tttt.pms.stu.vo.StuVO;

public interface ClassroomMainService {
	public List<SbjctVO> selectClassroomList(String userNo);

}
