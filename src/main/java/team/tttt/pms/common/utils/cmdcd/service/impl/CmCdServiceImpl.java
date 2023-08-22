package team.tttt.pms.common.utils.cmdcd.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.common.utils.cmdcd.mapper.CmCdMapper;
import team.tttt.pms.common.utils.cmdcd.service.CmCdService;
import team.tttt.pms.common.vo.CmCdVO;

@Service
public class CmCdServiceImpl implements CmCdService {


	@Inject
	private CmCdMapper mapper;

	@Override
	public List<CmCdVO> selectCode(String cdTypeId) {
		return mapper.selectCode(cdTypeId);
	}

	@Override
	public List<CmCdVO> readCMCdoe(String cdTypeId) {
		return mapper.readCMCdoe(cdTypeId);
	}



}
