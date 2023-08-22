package team.tttt.pms.tch.classroom.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.utils.FileUploadUtils;
import team.tttt.pms.common.vo.AtchFileVO;
import team.tttt.pms.tch.classroom.mapper.TchStorageMapper;
import team.tttt.pms.tch.classroom.service.TchStorageService;

@Controller
public class TchStorageServiceImpl implements TchStorageService {
	@Inject
	private TchStorageMapper tchStorageMapper;

	@Override
	public List<AtchFileVO> selectStorageList(String sbjctCd) {
		return tchStorageMapper.selectStorageList(sbjctCd);
	}

	@Override
	public ServiceResult insertStorage(AtchFileVO atchFileVO, String userNo, HttpServletRequest request) throws IOException {

		List<MultipartFile> fileList = atchFileVO.getFileList();
		String realPath = request.getSession().getServletContext().getRealPath("");
		String setPath = "static/resources/bbs/storage/";
		String tbNm = atchFileVO.getFileTbNm(); // sbjctNo

		// 파일 리스트에 내가 등록한 파일 정보 추가
		List<AtchFileVO> fileVOList = new ArrayList<AtchFileVO>();
		for(int i=0; i<fileList.size(); i++) {
			fileVOList.add(
					FileUploadUtils.uploadfile(userNo, realPath, setPath, fileList.get(i), tbNm));
		}

		// 데이터베이스에 파일 등록
		int status = 0;
		for(int j=0; j<fileVOList.size(); j++) {
			AtchFileVO myAtchFile = fileVOList.get(j);
			status += tchStorageMapper.insertStorage(myAtchFile);
		}
		if(status > 0) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAILED;
		}
	}

	@Override
	public ServiceResult deleteStorage(AtchFileVO atchFileVO) {
		int status = tchStorageMapper.deleteStorage(atchFileVO);
		if(status > 0) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAILED;
		}
	}

}
