package team.tttt.pms.project.storage.service.Impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.utils.cmFile.mapper.CommonFileMapper;
import team.tttt.pms.common.vo.AtchFileVO;
import team.tttt.pms.project.storage.mapper.PmsStorageMapper;
import team.tttt.pms.project.storage.service.PmsStorageService;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.PaginationInfoVO;
import team.tttt.pms.project.vo.StorageVO;

@Service
public class PmsStorageServiceImpl implements PmsStorageService {

   @Inject
   private PmsStorageMapper mapper;

   @Inject
   private CommonFileMapper fileMapper;




   @Override
   public List<StorageVO> storageList(PaginationInfoVO<StorageVO> pagingVO) {

      return mapper.storageList(pagingVO);
   }

   @Override
   public StorageVO getDetailStorage(String storageNo) {

	  mapper.increaseViews(storageNo);
      return mapper.getDetailStorage(storageNo);

   }

   @Override
   @Transactional
   public ServiceResult insertStorage(StorageVO insertStorage, List<AtchFileVO> fileVOList) {
      int cnt =0;
      int cnt2 =0;
      int cnt3 = 0;

      cnt = mapper.insertStorage(insertStorage);   // 게시글 업로드 부분
      String[] noInsertItem = insertStorage.getNoInsertItem();

      for (int i = 0; i < fileVOList.size(); i++) { // 파일 업로드 부분, 파일 갯수만큼 반복문 돌려줌
    	  if(noInsertItem != null) {
	         for (int j = 0; j < noInsertItem.length; j++) {
	            if (noInsertItem[j].equals(fileVOList.get(i).getFileNm())) {
	               fileVOList.remove(i);
	            }
	         }
         }
      }

      if(fileVOList != null) {
         for(int i=0; i<fileVOList.size(); i++) {             // 파일 업로드 부분, 파일 갯수만큼 반복문 돌려줌
            cnt2 += fileMapper.fileUpload(fileVOList.get(i));
         }
      }

      String[] delFileSeq = insertStorage.getAtchFileSeq();

      if (delFileSeq != null) {
         for (int i = 0; i < delFileSeq.length; i++) {
            cnt3 += fileMapper.fileUDelete(delFileSeq[i]);
         }
      }

      if(cnt > 0 && cnt2 == fileVOList.size()) {
         return ServiceResult.OK;
      }else {
         return ServiceResult.FAILED;
      }
   }

   @Override
   @Transactional
   public ServiceResult StorageUpdate(StorageVO updateStorage, List<AtchFileVO> fileVOList) {
      int cnt = 0;
      int cnt2 = 0;
      int cnt3 = 0;

      cnt = mapper.StorageUpdate(updateStorage);
      String[] noInsertItem = updateStorage.getNoInsertItem();

      for (int i = 0; i < fileVOList.size(); i++) { // 파일 업로드 부분, 파일 갯수만큼 반복문 돌려줌
    	  if(noInsertItem != null) {
	         for (int j = 0; j < noInsertItem.length; j++) {
	            if (noInsertItem[j].equals(fileVOList.get(i).getFileNm())) {
	               fileVOList.remove(i);
	            }
	         }
         }
      }

      if (fileVOList != null) {
         for (int i = 0; i < fileVOList.size(); i++) { // 파일 업로드 부분, 파일 갯수만큼 반복문 돌려줌

            fileVOList.get(i).setAtchFileNo(updateStorage.getAtchFileNo());
            cnt2 += fileMapper.fileUUpload(fileVOList.get(i));

         }
      }

      String[] delFileSeq = updateStorage.getAtchFileSeq();

      if (delFileSeq != null) {
         for (int i = 0; i < delFileSeq.length; i++) {
            cnt3 += fileMapper.fileUDelete(delFileSeq[i]);
         }
      }

      if (cnt > 0 && cnt2 == fileVOList.size()) {
         return ServiceResult.OK;
      } else {
         return ServiceResult.FAILED;
      }
   }

   @Override
   @Transactional
   public ServiceResult StorageDelete(StorageVO deleteVO) {
      int cnt =0;

      cnt = mapper.StorageDelete(deleteVO.getStrNo());

      cnt += fileMapper.fileDelete(deleteVO.getAtchFileNo());

      if(cnt > 1){
         return ServiceResult.OK;

      }
      return ServiceResult.FAILED;
   }

   @Override
   public int selectBoardCount(PaginationInfoVO<StorageVO> pagingVO) {
      return mapper.selectBoardCount(pagingVO);
   }

@Override
public MemManagementVO getMemJbttlCd(Map<String, String> mjMap) {
	return mapper.getMemJbttlCd(mjMap);
}

}