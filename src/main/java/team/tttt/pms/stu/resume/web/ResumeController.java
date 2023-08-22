package team.tttt.pms.stu.resume.web;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.utils.cmdcd.service.CmCdService;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.stu.resume.service.ResumeService;
import team.tttt.pms.stu.vo.ResumeVO;

@Controller
@Slf4j
public class ResumeController {

	@Inject
	private ResumeService resumeService;

	@Inject
	private CmCdService cmCdService;


	@GetMapping("/stu/mypage/resume")
	public String resumeMain(Authentication auth, Model model) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		model.addAttribute("user", userVO);

		model.addAttribute("temp_category", "마이페이지");
		model.addAttribute("temp_title", "이력서 관리");

		List<ResumeVO> ResList = resumeService.selectResumeList(userVO.getUserNo());
		model.addAttribute("resList", ResList);
		return "stu/com/mypage/resume/list";

	}


	@GetMapping("/stu/mypage/resume/write")
	public String resumeWrite(Authentication auth, Model model) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		model.addAttribute("user", userVO);
		model.addAttribute("cmcd_schlSeCd", cmCdService.readCMCdoe("R001"));


		return "stu/com/resume_nt/write";
	}

	@PostMapping("/stu/mypage/resume/write")
	public String resumeInsert(ResumeVO resumeVO, Authentication auth, RedirectAttributes ra) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		resumeVO.setStuNo(userVO.getUserNo());

		ServiceResult result = null;

		{
			System.out.println(resumeVO);
		}

		result = resumeService.resumeInsert(resumeVO);

		if(result == ServiceResult.OK) {
			ra.addAttribute("writeResult", "OK");
		} else {
			ra.addAttribute("writeResult", "FAILED");
		}

		return "redirect:/stu/mypage/resume";
	}

	/* 이력서 보기 */
	@RequestMapping(value = "/resume/view", method = RequestMethod.GET)
	public String resumeView(String no, Model model) {


		ResumeVO resumeVO = resumeService.resumeView(no);

		model.addAttribute("res", resumeVO);

		return "stu/com/resume_nt/resumeView";
	}

	@ResponseBody
	@PostMapping(value = "/stu/mypage/resume/ajax/mainresset")
	public String mainResSet(@RequestBody Map<String, String> paramMap , Authentication auth) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();


		ServiceResult result = resumeService.mainResSet(userVO.getUserNo() , paramMap.get("resumeNo"));

		return result.name();

	}

}
