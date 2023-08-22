package team.tttt.pms.common.utils.cmFile.service;

import java.util.List;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.AtchFileVO;

public interface CommonFileService {

	ServiceResult fileUpload(List<AtchFileVO> fileVOList);

}
