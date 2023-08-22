package team.tttt.pms.tch.classroom.web;


import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.AtchFileVO;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.tch.classroom.service.TchStorageService;

@Controller
@Slf4j
@RequestMapping("tch/class")
public class TchStorageController {

	@Inject
	TchStorageService tchStorageService;

	@GetMapping("/storage")
	public String getStorageList(@RequestParam("sbjctCd") String sbjctCd, Model model) {
		model.addAttribute("sbjctCd", sbjctCd);
		model.addAttribute("temp_title", "자료실");
		return "tch/com/class/storage";
	}

	@GetMapping(value = "/storage/selectlist" ,produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<AtchFileVO> storageList(@RequestParam("sbjctCd") String sbjctCd) {
		List<AtchFileVO> fileList = tchStorageService.selectStorageList(sbjctCd);
		return fileList;
	}

	@PostMapping("/storage/insert")
	@ResponseBody
	public ServiceResult insertStorage(AtchFileVO atchFileVO, Authentication auth, HttpServletRequest request) throws IOException {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
        UserVO userVO = mVO.getMember();
        String userNo = userVO.getUserNo();
		ServiceResult result = tchStorageService.insertStorage(atchFileVO, userNo, request);
		return result;
	}

	@PostMapping("/storage/delete")
	@ResponseBody
	public ServiceResult deleteStorage(@RequestBody AtchFileVO atchFileVO) {
		// 해당 경로의 사진 파일 삭제
		File file = new File(atchFileVO.getFilePath());

        if (file.exists()) {
        	if(file.delete()){
    			log.info("파일삭제 성공");
    		}else{
    			log.info("파일삭제 실패");
    		}
        }

        // 데이터베이스에서 삭제
        ServiceResult result = tchStorageService.deleteStorage(atchFileVO);
		return result;
	}
}
