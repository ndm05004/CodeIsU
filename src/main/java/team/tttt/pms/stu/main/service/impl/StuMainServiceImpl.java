package team.tttt.pms.stu.main.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.emp.vo.SbjctVO;
import team.tttt.pms.stu.main.mapper.StuMainMapper;
import team.tttt.pms.stu.main.service.StuMainService;
import team.tttt.pms.stu.vo.IssueListVO;
import team.tttt.pms.stu.vo.ProjListVO;
import team.tttt.pms.stu.vo.StorageListVO;
import team.tttt.pms.tch.vo.AsmtVO;

@Service
public class StuMainServiceImpl implements StuMainService{

	@Inject
	private StuMainMapper mapper;

	@Override
	public List<ProjListVO> projList(String stuNo) {
		return mapper.projList(stuNo);
	}


	@Override
	public List<StorageListVO> storageList(String stuNo) {
		return mapper.storageList(stuNo);
	}


	@Override
	public List<IssueListVO> issueList(String stuNo) {
		return mapper.issueList(stuNo);
	}


	@Override
	public List<SbjctVO> selectTimetableList(String stuNo) {
		return mapper.selectTimetableList(stuNo);
	}


	@Override
	public List<AsmtVO> selectAsmtList(String stuNo) {
		return mapper.selectAsmtList(stuNo);
	}



}
