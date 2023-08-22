package team.tttt.pms.emp.kalleave.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.emp.kalleave.mapper.KalleaveMapper;
import team.tttt.pms.emp.kalleave.service.KalleaveService;
import team.tttt.pms.emp.vo.AttdVO;
import team.tttt.pms.stu.vo.AttdanVO;

@Service
public class KalleaveServiceImpl implements KalleaveService {

	@Inject
	private KalleaveMapper kalleaveMapper;

	@Override
	public List<AttdanVO> attdanAllList() {
		return kalleaveMapper.attdanAllList();
	}

	@Override
	public List<AttdanVO> attdanapproval() {
		return kalleaveMapper.attdanapproval();
	}

	@Override
	public List<AttdanVO> attdanunapproved() {
		return kalleaveMapper.attdanunapproved();
	}

	@Override
	public int approvalUpdate(AttdanVO attdanVO) {
		return kalleaveMapper.approvalUpdate(attdanVO);
	}

	@Override
	public int selectattd(AttdVO attdVO) {
		return kalleaveMapper.selectattd(attdVO);
	}

	@Override
	public int inattd(AttdVO attdVO) {
		return kalleaveMapper.inattd(attdVO);
	}

	@Override
	public int upattd(AttdVO attdVO) {
		return kalleaveMapper.upattd(attdVO);
	}

	@Override
	public int inoutattd(AttdVO attdVO) {
		return kalleaveMapper.inoutattd(attdVO);
	}

	@Override
	public int upinoutattd(AttdVO attdVO) {
		return kalleaveMapper.upinoutattd(attdVO);
	}
}
