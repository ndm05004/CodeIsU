package team.tttt.pms.project.storage.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.PaginationInfoVO;
import team.tttt.pms.project.vo.StorageVO;

@Mapper
public interface PmsStorageMapper {

	List<StorageVO> storageList(PaginationInfoVO<StorageVO> pagingVO);

	StorageVO getDetailStorage(String storageNo);

	int insertStorage(StorageVO insertStorage);

	int StorageUpdate(StorageVO updateStorage);

	int StorageDelete(String storageNo);

	int selectBoardCount(PaginationInfoVO<StorageVO> pagingVO);

	MemManagementVO getMemJbttlCd(Map<String, String> mjMap);

	void increaseViews(String storageNo);

}
