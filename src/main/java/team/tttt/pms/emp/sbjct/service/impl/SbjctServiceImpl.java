package team.tttt.pms.emp.sbjct.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.emp.sbjct.mapper.SbjctMapper;
import team.tttt.pms.emp.sbjct.service.SbjctService;
import team.tttt.pms.emp.vo.EmpVO;
import team.tttt.pms.emp.vo.SbjctVO;
import team.tttt.pms.emp.vo.SvlfVO;
import team.tttt.pms.stu.vo.StuVO;

@Service
public class SbjctServiceImpl implements SbjctService {

	@Inject
	private SbjctMapper sbjctMapper;

	@Override
	public List<SvlfVO> svlfNmList() {
		return sbjctMapper.svlfNmList();
	}

	@Override
	public List<EmpVO> empNmList() {
		return sbjctMapper.empNmList();
	}

	@Override
	public List<SbjctVO> sbjctList() {
		return sbjctMapper.sbjctList();
	}

	@Override
	public int sbjctInsert(SbjctVO sbjctVO) {
		return sbjctMapper.sbjctInsert(sbjctVO);
	}

	@Override
	public SvlfVO svlfTime(String svlfNo) {
		return sbjctMapper.svlfTime(svlfNo);
	}

	@Override
	public SbjctVO sbjctInfo(String sbjCd) {
		return sbjctMapper.sbjctInfo(sbjCd);
	}

	@Override
	public List<SbjctVO> sbjctListInfo(SbjctVO sbjctVO) {
		return sbjctMapper.sbjctListInfo(sbjctVO);
	}

	@Override
	public int sbjctUpdate(SbjctVO sbjctVO) {
		return sbjctMapper.sbjctUpdate(sbjctVO);
	}

	@Override
	public int sbjctDel(String sbjctCd) {
		return sbjctMapper.sbjctDel(sbjctCd);
	}

	@Override
	public List<SbjctVO> scduInfo(SbjctVO sbjctVO) {
		return sbjctMapper.scduInfo(sbjctVO);
	}

	@Override
	public List<SbjctVO> sbjctListInfo2(SbjctVO sbjctVO) {
		return sbjctMapper.sbjctListInfo2(sbjctVO);
	}

	@Override
	public List<SbjctVO> scduInfo2(SbjctVO sbjctVO) {
		return sbjctMapper.scduInfo2(sbjctVO);
	}

	@Override
	public List<StuVO> sbjctStuList(String sbjctCd) {
		return sbjctMapper.sbjctStuList(sbjctCd);
	}

	@Override
	public List<SvlfVO> svlfList() {
		return sbjctMapper.svlfList();
	}

	@Override
	public List<SbjctVO> resbjctlist(SbjctVO sbjctVO) {
		return sbjctMapper.resbjctlist(sbjctVO);
	}

}
