package team.tttt.pms.stu.classroom.web;

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
import team.tttt.pms.stu.classroom.service.StuStorageService;

@Controller
@Slf4j
@RequestMapping("/stu/classroom")
public class StuStorageController {
	@Inject
	private StuStorageService stuStorageService;

	@GetMapping("/storage")
	public String getStorageList(@RequestParam("sbjctCd") String sbjctCd, Model model) {
		List<AtchFileVO> fileList = stuStorageService.selectStorageList(sbjctCd);
		model.addAttribute("fileList", fileList);
		model.addAttribute("sbjctCd", sbjctCd);
		model.addAttribute("temp_title", "자료실");
		return "stu/com/classroom/storage";
	}
}
