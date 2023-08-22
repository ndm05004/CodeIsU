package team.tttt.pms.common.utils.cmdcd.service;

import java.util.List;

import team.tttt.pms.common.vo.CmCdVO;

public interface CmCdService {

	List<CmCdVO> selectCode(String cdTypeId);

	List<CmCdVO> readCMCdoe(String cdTypeId);


}
