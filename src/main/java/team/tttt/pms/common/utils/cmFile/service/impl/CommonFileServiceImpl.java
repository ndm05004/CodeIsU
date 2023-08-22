package team.tttt.pms.common.utils.cmFile.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.utils.FileUploadUtils;
import team.tttt.pms.common.utils.cmFile.mapper.CommonFileMapper;
import team.tttt.pms.common.utils.cmFile.service.CommonFileService;
import team.tttt.pms.common.vo.AtchFileVO;

@Service
public class CommonFileServiceImpl implements CommonFileService{

	@Inject
	private CommonFileMapper mapper;

	@Override
	public ServiceResult fileUpload(List<AtchFileVO> fileVOList) {

		int cnt =0;

		for(int i=0; i<fileVOList.size(); i++) {
			cnt += mapper.fileUpload(fileVOList.get(i));
		}

		if(cnt == fileVOList.size()) {
			return ServiceResult.OK;
		}else {
			return ServiceResult.FAILED;
		}

	}
}
