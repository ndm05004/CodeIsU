package team.tttt.pms.project.memManage.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.project.memManage.mapper.MemManagementMapper;
import team.tttt.pms.project.memManage.service.MemManagementService;
import team.tttt.pms.project.vo.MemJoinAplyVO;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.ProjVO;

@Service
public class MemManagementImpl implements MemManagementService {

	@Inject
	private MemManagementMapper memMapper;

	@Override
	public List<MemManagementVO> memList(String projNo) {
		return memMapper.memList(projNo);
	}


	@Override
	public ServiceResult positionModify(MemManagementVO vo) {

		int cnt = memMapper.positionModify(vo);
		if(cnt > 0){
			return ServiceResult.OK;

		} else {
		return ServiceResult.FAILED;
		}
	}


	@Override
	public List<MemJoinAplyVO> memJoinAplyList(String projNo) {
		return memMapper.memJoinAplyList(projNo);
	}


	@Override
	public MemJoinAplyVO memJoinDetail(Map<String, String> map) {
		return memMapper.memJoinDetail(map);
	}


	@Transactional
	@Override
	public ServiceResult memInsert(MemManagementVO memVO) {

		int cnt =  memMapper.memInsert(memVO);
		cnt +=  memMapper.memDel(memVO);
		cnt +=  memMapper.projMemCount(memVO.getProjNo());

		if(cnt == 3){
			return ServiceResult.OK;

		} else {
		return ServiceResult.FAILED;
		}
	}


	@Override
	public ServiceResult memDel(MemManagementVO memVO) {

		int cnt =  memMapper.memDel(memVO);
		if(cnt > 0){
			return ServiceResult.OK;

		} else {
		return ServiceResult.FAILED;

		}
	}



	@Override public ProjVO projStatus(ProjVO projVO) {
		return memMapper.projStatus(projVO);
	}


	@Override
	public ProjVO projUpdate(ProjVO projVO) {
		return memMapper.projUpdate(projVO);
	}

	@Transactional
	@Override
	public ServiceResult projDelete(String projNo) {
		ServiceResult res = null;
		int result = 0;
		int memDelStatus = memMapper.projMemDel(projNo);
		int	memAplyDelStatus = memMapper.aplyDel(projNo);
		if(memDelStatus >= 0 && memAplyDelStatus >= 0) {
			result = memMapper.projDelete(projNo);
			if(result > 0){
				res = ServiceResult.OK;
			}else {
				res = ServiceResult.FAILED;
			}
		}
		return res;
	}


	@Override
	public ServiceResult projMemDel(MemManagementVO memVO) {

		int cnt =  memMapper.memDel(memVO);
		if(cnt > 0){
			return ServiceResult.OK;

		} else {
		return ServiceResult.FAILED;

		}
	}

	@Override
	public ServiceResult aplyDel(String projNo) {
		int cnt =  memMapper.aplyDel(projNo);
		if(cnt > 0){
			return ServiceResult.OK;

		} else {
		return ServiceResult.FAILED;

		}
	}

	@Override
	public String plCheck(String userName) {
		return memMapper.plCheck(userName);
	}


	@Override
	public ServiceResult projConUpdate(ProjVO projVO) {
		int cnt = memMapper.projConUpdate(projVO);

		if(cnt > 0) {
			return ServiceResult.OK;
		} else {
		return ServiceResult.FAILED;
	}


}


	@Override
	public ServiceResult projMemCount(String projNo) {

		int cnt = memMapper.projMemCount(projNo);

		if(cnt > 0) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAILED;
		}
	}


	@Override
	public MemManagementVO getMemJbttlCd(Map<String, String> mjMap) {
		return memMapper.getMemJbttlCd(mjMap);
	}



}
