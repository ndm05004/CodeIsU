package team.tttt.pms.tch.classroom.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.AtchFileVO;

public interface TchStorageService {

	public List<AtchFileVO> selectStorageList(String sbjctCd);

	public ServiceResult insertStorage(AtchFileVO atchFileVO, String userNo, HttpServletRequest request) throws IOException;

	public ServiceResult deleteStorage(AtchFileVO atchFileVO);

}
