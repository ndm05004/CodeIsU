package team.tttt.pms.emp.stulist.web;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.emp.stulist.service.StuListService;
import team.tttt.pms.emp.vo.SvlfVO;
import team.tttt.pms.stu.vo.StuVO;

@Controller
@Slf4j
@RequestMapping("/emp/stuman/stulist")
public class StuListController {

	@Inject
	StuListService stuListService;

	@GetMapping("")
	public String stuListMain(Model model) {
		model.addAttribute("temp_title", "학원생 등록");


		return "emp/com/stumanage/stulist/list";
	}

	// Ajax로 전체 학생 목록을 불러옵니다.
	@ResponseBody
	@RequestMapping(value = "/getlist", method = RequestMethod.POST)
	public Map<String, Object> getStuListAll() {

		List<StuVO> stuList = stuListService.getStuListAll();
		List<SvlfVO> svlfList = stuListService.getSvlfAll();

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("stuList", stuList);
		dataMap.put("svlfList", svlfList);

		return dataMap;
	}

	// ajax로 전체 연수과정을 읽어옵니다.
	@ResponseBody
	@RequestMapping(value = "/getsvlf", method = RequestMethod.POST)
	public List<SvlfVO> getSvlfAll() {
		return stuListService.getSvlfAll();
	}

	// 학생정보 1명 입력
	@ResponseBody
	@RequestMapping(value = "/insertstuone", method = RequestMethod.POST)
	public Map<String, String> insertStuOne(@RequestBody StuVO stuVO) {
		System.out.println(stuVO);
		ServiceResult ResultDb = stuListService.insertStuOne(stuVO);

		Map<String, String> resMap = new HashMap<String, String>();
		resMap.put("userID", stuVO.getStuNo());
		resMap.put("resultDB", ResultDb.name());
		resMap.put("userName", stuVO.getUserNm());
		return resMap;
	}


	/* 업로드한 엑셀 파일 수신 */
	@SuppressWarnings("null")
	@ResponseBody
	@RequestMapping(value = "/excelupload", method = RequestMethod.POST)
	public Map<String, Object> excelUploadAjax(MultipartHttpServletRequest request) throws Exception{
	    Map<String, Object> result = new HashMap<String, Object>();

	    // 업로드한 엑셀 파일을 가져온다.
	    MultipartFile excelFile = request.getFile("excelFile");

	    try {
	        if(excelFile != null || !excelFile.isEmpty()) {

	            File destFile = new File("C:\\upload\\"+excelFile.getOriginalFilename()); // 파일위치 지정
	            excelFile.transferTo(destFile); // 엑셀파일을 임시저장
	            result = stuListService.excelUpload(destFile); // service 호출
	            destFile.delete(); // 업로드된 엑셀파일 삭제
	            result.put("state", "OK");


	        }else {
	            result.put("state", "FAILED");
	        }
	    }catch(Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}
}
