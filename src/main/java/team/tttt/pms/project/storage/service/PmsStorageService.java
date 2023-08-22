package team.tttt.pms.project.storage.service;

import java.util.List;
import java.util.Map;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.AtchFileVO;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.PaginationInfoVO;
import team.tttt.pms.project.vo.StorageVO;

public interface PmsStorageService {

	List<StorageVO> storageList(PaginationInfoVO<StorageVO> pagingVO);

	StorageVO getDetailStorage(String storageNo);

	ServiceResult insertStorage(StorageVO insertStorage, List<AtchFileVO> fileVOList);

	ServiceResult StorageUpdate(StorageVO updateStorage, List<AtchFileVO> fileVOList);

	ServiceResult StorageDelete(StorageVO deleteVO);

	int selectBoardCount(PaginationInfoVO<StorageVO> pagingVO);

	MemManagementVO getMemJbttlCd(Map<String, String> mjMap);


}
