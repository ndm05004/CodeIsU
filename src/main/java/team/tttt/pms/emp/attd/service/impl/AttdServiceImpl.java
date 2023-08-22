package team.tttt.pms.emp.attd.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.emp.attd.mapper.AttdMapper;
import team.tttt.pms.emp.attd.service.AttdService;
import team.tttt.pms.emp.vo.AttdVO;
import team.tttt.pms.emp.vo.SvlfVO;

@Service
public class AttdServiceImpl implements AttdService{

	@Inject
	AttdMapper attdMapper;

	@Override
	public List<SvlfVO> findSvlfList(String dateInfo) {
		return attdMapper.findSvlfList(dateInfo);
	}

	@Override
	public List<AttdVO> stuList(AttdVO attdVO) {
		return attdMapper.stuList(attdVO);
	}

	@Override
	public int attdStatusUp(AttdVO attdVO) {
		return attdMapper.attdStatusUp(attdVO);
	}
}
