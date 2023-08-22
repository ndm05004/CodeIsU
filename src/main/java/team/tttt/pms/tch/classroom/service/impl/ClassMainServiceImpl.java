package team.tttt.pms.tch.classroom.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.tch.classroom.mapper.ClassMainMapper;
import team.tttt.pms.tch.classroom.service.ClassMainService;
import team.tttt.pms.tch.vo.TchVO;

@Service
public class ClassMainServiceImpl implements ClassMainService{

	@Inject
	private ClassMainMapper classMainMapper;

	@Override
	public List<TchVO> selectClassList(String userNo) {
		return classMainMapper.selectClassList(userNo);
	}

	@Override
	public List<TchVO> selectLastClassList(String userNo) {
		return classMainMapper.selectLastClassList(userNo);
	}
}
