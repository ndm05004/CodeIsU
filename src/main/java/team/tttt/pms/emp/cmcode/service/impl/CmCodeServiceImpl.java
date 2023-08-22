package team.tttt.pms.emp.cmcode.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import team.tttt.pms.common.vo.CmCdVO;
import team.tttt.pms.emp.cmcode.mapper.CmCodeMapper;
import team.tttt.pms.emp.cmcode.service.CmCodeService;
import team.tttt.pms.emp.vo.cmTypeVO;

@Service
public class CmCodeServiceImpl implements CmCodeService {

	@Inject
	private CmCodeMapper cmCodeMapper;

	@Override
	public List<cmTypeVO> cmtyList() {
		return cmCodeMapper.cmtyList();
	}

	@Override
	public List<CmCdVO> codeList(String cdTypeId) {
		return cmCodeMapper.codeList(cdTypeId);
	}

	@Override
	public int codeTypeInsert(cmTypeVO cmtypeVO) {
		return cmCodeMapper.codeTypeInsert(cmtypeVO);
	}

	@Override
	public int codeTypeUpdate(cmTypeVO cmtypeVO) {
		return cmCodeMapper.codeTypeUpdate(cmtypeVO);
	}

	@Override
	public int codeInsert(CmCdVO codeVO) {
		return cmCodeMapper.codeInsert(codeVO);
	}

	@Override
	public int codeUpdate(CmCdVO codeVO) {
		return cmCodeMapper.codeUpdate(codeVO);
	}

	@Override
	public int noneCodeInsert(CmCdVO codeVO) {
		return cmCodeMapper.noneCodeInsert(codeVO);
	}

	@Override
	public List<cmTypeVO> noMecodeTypeList(String codeTypeId) {
		return cmCodeMapper.noMecodeTypeList(codeTypeId);
	}

	@Override
	public List<CmCdVO> noMeCodeList(CmCdVO cmcdVO) {
		return cmCodeMapper.noMeCodeList(cmcdVO);
	}


}
