package team.tttt.pms.project.storage.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.utils.FileUploadUtils;
import team.tttt.pms.common.utils.cmFile.service.CommonFileService;
import team.tttt.pms.common.vo.AtchFileVO;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.project.storage.service.PmsStorageService;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.PaginationInfoVO;
import team.tttt.pms.project.vo.StorageVO;

@RequestMapping("/pms/project")
@Slf4j
@Controller
public class PmsStorageController {

	@Inject
	PmsStorageService service;


	@GetMapping("/storage")
	public String getStorageList(Authentication auth, String projNo, Model model, HttpSession session) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
        UserVO userVO = mVO.getMember();
        String userNo = userVO.getUserNo();

        Map<String, String> mjMap = new HashMap<String, String>();
        mjMap.put("userNo", userNo);
        mjMap.put("projNo", projNo);


        MemManagementVO memVO = service.getMemJbttlCd(mjMap);


        model.addAttribute("memVO",memVO);
        model.addAttribute("userNo", userNo);
        model.addAttribute("projNo",projNo);
        model.addAttribute("userVO",userVO);

		return "pms/com/storage";
	}


	@GetMapping("/storageList")
	@ResponseBody
	public Map<String, Object> storageList(PaginationInfoVO<StorageVO> vo) {

		PaginationInfoVO<StorageVO> pagingVO = new PaginationInfoVO<StorageVO>();



		Map<String, Object> StorageList = new HashMap<String, Object>();

		if(StringUtils.isNotBlank(vo.getSearchWord())) {
			pagingVO.setSearchType(vo.getSearchType());
			pagingVO.setSearchWord(vo.getSearchWord());
			StorageList.put("searchType", vo.getSearchType());
			StorageList.put("searchWord", vo.getSearchWord());
		}

		pagingVO.setCurrentPage(vo.getCurrentPage());

		pagingVO.setProjNo(vo.getProjNo());

		int totalRecord = service.selectBoardCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);

		List<StorageVO> dataList = service.storageList(pagingVO);

		pagingVO.setDataList(dataList);

		StorageList.put("pagingVO", pagingVO);

		return StorageList;
	}


	@GetMapping("/StorageDetail")
	@ResponseBody
	public StorageVO getDetailStorage(String strNo) {
		System.out.println(strNo + "--------------- StorageNo getDetailStorage");
		StorageVO vo = service.getDetailStorage(strNo);
		return vo;
	}


	@DeleteMapping(value = "/StorageDelete" , produces = "application/json;charset=utf-8")
	@ResponseBody
	public String deleteStorage(@RequestBody StorageVO deleteVO) {

		String msg;

		ServiceResult result = service.StorageDelete(deleteVO);

		if (result.equals(ServiceResult.OK)) {
			msg = "성공";
		} else {
			msg = "실패";
		}
		return msg;
	}


	@ResponseBody
	@RequestMapping(value = "/insertStorage", method = RequestMethod.POST)
	public String insertStorage(StorageVO insertStorage, HttpServletRequest request) throws IOException {

		List<MultipartFile> fileList = insertStorage.getFileList();

		String realPath = request.getSession().getServletContext().getRealPath("");
		String setPath = "static/resources/bbs/storage/";


		List<AtchFileVO> fileVOList = new ArrayList<AtchFileVO>();

		String tbNm = "TB_STORAGE";				  // 테이블 명

		System.out.println(" -------- fileList.get(0).getSize() --------"+fileList.get(0).getOriginalFilename());

		String fileNullCheck = fileList.get(0).getOriginalFilename();

		if(!(fileNullCheck == null || fileNullCheck.trim().isEmpty())) {
			for(int i=0; i<fileList.size(); i++) {		// 파일 저장 utils 리턴값은 List<AtchFileVO>
				fileVOList.add(
						FileUploadUtils.uploadfile(
								insertStorage.getStuNo(), realPath, setPath, fileList.get(i), tbNm ));
			}
		}
		// FileUploadUtils.uploadfile의 매개변수 1. 작성자, 2. realPath, 3. 본인이 설정할 경로, MultipartFile, 테이블명

		ServiceResult result = service.insertStorage(insertStorage, fileVOList);


		if(result == ServiceResult.OK) {
			return result.name();
		}else {
			return result.name();
		}
	}


	@ResponseBody
	@PutMapping(value = "/updateStorage", produces = "application/json;charset=utf-8")
	public String updateStorage(StorageVO updateStorage, HttpServletRequest request) throws IOException {


		List<MultipartFile> fileList = updateStorage.getFileList();

		String realPath = request.getSession().getServletContext().getRealPath("");
		String setPath = "static/resources/bbs/storage/";


		List<AtchFileVO> fileVOList = new ArrayList<AtchFileVO>();

		String tbNm = "TB_STORAGE";				  // 테이블 명

		if(fileList.get(0).getSize() != 0) {
			for(int i=0; i<fileList.size(); i++) {		// 파일 저장 utils 리턴값은 List<AtchFileVO>
				fileVOList.add(
						FileUploadUtils.uploadfile(
								updateStorage.getStuNo(), realPath, setPath, fileList.get(i), tbNm ));
			}
		}
		// FileUploadUtils.uploadfile의 매개변수 1. 작성자, 2. realPath, 3. 본인이 설정할 경로, MultipartFile, 테이블명

		ServiceResult result = service.StorageUpdate(updateStorage, fileVOList);


		if(result == ServiceResult.OK) {
			return result.name();
		}else {
			return result.name();
		}
	}
}
