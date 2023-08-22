package team.tttt.pms.stu.main.service.impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.emp.vo.AttdVO;
import team.tttt.pms.stu.main.mapper.DongMapper;
import team.tttt.pms.stu.main.service.DongService;

@Service
public class DongServiceImpl implements DongService {

	@Inject
	private DongMapper dongMapper;

	@Override
	public AttdVO userCheck(AttdVO dataVO) {
		return dongMapper.userCheck(dataVO);
	}

	@Override
	public int insertAttd(AttdVO attdVO) {
		return dongMapper.insertAttd(attdVO);
	}

	@Override
	public int inClass(AttdVO attdVO) {
		return dongMapper.inClass(attdVO);
	}

	@Override
	public int outClass(AttdVO attdVO) {
		return dongMapper.outClass(attdVO);
	}

	@Override
	public AttdVO searchAttd(AttdVO attdVO) {
		return dongMapper.searchAttd(attdVO);
	}

	@Override
	public void attdOk(AttdVO attdVO) {
		dongMapper.attdOk(attdVO);
	}

	@Override
	public void attdFail(AttdVO attdVO) {
		dongMapper.attdFail(attdVO);
	}

	@Override
	public int inClassLate(AttdVO attdVO) {
		return dongMapper.inClassLate(attdVO);
	}
}
