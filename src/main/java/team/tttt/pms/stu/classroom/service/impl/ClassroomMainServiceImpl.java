package team.tttt.pms.stu.classroom.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.emp.vo.SbjctVO;
import team.tttt.pms.stu.classroom.mapper.ClassroomMainMapper;
import team.tttt.pms.stu.classroom.service.ClassroomMainService;
import team.tttt.pms.stu.vo.StuVO;

@Service
public class ClassroomMainServiceImpl implements ClassroomMainService{
	@Inject
	private ClassroomMainMapper classroomMapper;

	@Override
	public List<SbjctVO> selectClassroomList(String userNo) {
		return classroomMapper.selectClassroomList(userNo);
	}
}
