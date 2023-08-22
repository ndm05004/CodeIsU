package team.tttt.pms.project.main.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.project.main.mapper.MainMapper;
import team.tttt.pms.project.main.service.MainService;
import team.tttt.pms.project.vo.MemJoinAplyVO;
import team.tttt.pms.project.vo.ProjVO;

@Service
public class MainServiceImpl implements MainService{

	@Inject
	private MainMapper mapper;

	@Override
	public List<ProjVO> pList(String stuNo) {
		return mapper.pList(stuNo);
	}

	@Override
	public List<MemJoinAplyVO> aplyList(String stuNo) {
		return mapper.aplyList(stuNo);
	}


}
