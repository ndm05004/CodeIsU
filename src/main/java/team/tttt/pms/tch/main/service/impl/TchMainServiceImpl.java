package team.tttt.pms.tch.main.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.stu.vo.QstnVO;
import team.tttt.pms.tch.main.mapper.TchMainMapper;
import team.tttt.pms.tch.main.service.TchMainService;
import team.tttt.pms.tch.vo.TchVO;

@Service
public class TchMainServiceImpl implements TchMainService{

	@Inject
	private TchMainMapper tchMainMapper;

	@Override
	public List<TchVO> selectClassList(String userNo) {
		return tchMainMapper.selectClassList(userNo);
	}

	@Override
	public List<QstnVO> selectQntnAnsNoList(String userNo) {
		return tchMainMapper.selectQntnAnsNoList(userNo);
	}

	@Override
	public List<QstnVO> selectAsmtList(String userNo) {
		return tchMainMapper.selectAsmtList(userNo);
	}

}
