package team.tttt.pms.project.createProj.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.project.createProj.mapper.CreateProjMapper;
import team.tttt.pms.project.createProj.service.createProjService;
import team.tttt.pms.project.vo.MemJoinAplyVO;
import team.tttt.pms.project.vo.ProjVO;

@Service
public class createProjServiceImpl implements createProjService{

	@Inject
	private CreateProjMapper createProjMapper;

	@Override
	public List<ProjVO> projList(ProjVO vo) {
		return createProjMapper.projList(vo);
	}

	@Override
	@Transactional
	public ServiceResult insertProj(ProjVO projVO) {
		int cnt = createProjMapper.insertProj(projVO);
		cnt += createProjMapper.insertPL(projVO.getStuNo());

		if(cnt > 1){
			return ServiceResult.OK;
		} else {
		return ServiceResult.FAILED;
		}
	}

	@Override
	public ServiceResult insertAply(MemJoinAplyVO aplyVO) {
		int cnt = createProjMapper.insertAply(aplyVO);

		if(cnt > 0) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAILED;
		}
	}

	@Override
	public ProjVO detail(String projNo) {
		return createProjMapper.detail(projNo);
	}

	@Override
	public List<ProjVO> aplyYn(String stuNo) {
		return createProjMapper.aplyYn(stuNo);
	}


}
