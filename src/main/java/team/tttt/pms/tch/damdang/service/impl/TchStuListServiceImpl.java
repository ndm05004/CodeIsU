package team.tttt.pms.tch.damdang.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.stu.vo.StuVO;
import team.tttt.pms.tch.damdang.mapper.TchStuListMapper;
import team.tttt.pms.tch.damdang.service.TchStuListService;

@Service
public class TchStuListServiceImpl implements TchStuListService{
	@Inject
	private TchStuListMapper tchStuMapper;

	@Override
	public List<StuVO> selectStuList(String userNo) {
		return tchStuMapper.selectStuList(userNo);
	}

}
