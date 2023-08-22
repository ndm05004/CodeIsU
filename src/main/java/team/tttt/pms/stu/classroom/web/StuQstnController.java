package team.tttt.pms.stu.classroom.web;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.stu.classroom.service.StuQstnService;
import team.tttt.pms.stu.vo.AttdanVO;
import team.tttt.pms.stu.vo.QstnVO;
import team.tttt.pms.tch.vo.TchVO;


@Slf4j
@Controller
@RequestMapping("/stu/classroom")
public class StuQstnController {

    @Inject
    private StuQstnService qstnService;

    @GetMapping(value = "/qstn")
    public String qstn(Model model, @RequestParam("sbjctCd") String sbjctCd) {
        model.addAttribute("sbjctCd", sbjctCd);
        log.info("qstn 메인 컨트롤러");
        model.addAttribute("temp_title", "질문");
//        model.addAttribute("temp_title", "");
    	return "stu/com/classroom/qstnList";
    }

    // 리스트 출력
    @ResponseBody
    @GetMapping(value = "/qstn/qstnList", produces = "application/json;charset=utf-8")
    public Map<String,Object> qstnList(Model model, String sbjctCd, Authentication auth) {
    	CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		QstnVO qstnVO = new QstnVO();
		qstnVO.setStuNo(userVO.getUserNo());
		qstnVO.setSbjctCd(sbjctCd);
		log.info("sbjctCd"+sbjctCd);
    	List<QstnVO> qstnList = qstnService.selectQstnList(qstnVO);
    	log.info("리스트 출력 컨트롤러");
    	log.info("qstnList"+qstnList);
    	Map<String,Object> map = new HashMap<String, Object>();
    	map.put("qstnList", qstnList);
    	map.put("profile", userVO.getUserProfile());
    	return map;
    }

	// 질문업데이트  폼
	@PostMapping("/qstn/updateform")
	public String qstnUpdateForm(
			QstnVO qstnVO
			,Model model) {
		int qstnNo = qstnVO.getQstnNo();
		String sbjctCd = qstnVO.getSbjctCd();
		QstnVO myQstn = qstnService.selectQstn(qstnNo);
		model.addAttribute("qstFormcd", "update");
		model.addAttribute("sbjctCd", sbjctCd);
		model.addAttribute("qstn", myQstn);
		model.addAttribute("temp_title", "질문 수정");
		return "stu/com/classroom/qstnForm";
	}

	// 질문 등록 폼
	@GetMapping("/qstn/insertform")
	public String qstnInsertForm( Model model, @RequestParam("sbjctCd") String sbjctCd) {
		model.addAttribute("qstFormcd", "insert");
		model.addAttribute("sbjctCd", sbjctCd);
		model.addAttribute("temp_title", "질문 등록");
		return "stu/com/classroom/qstnForm";
	}

	// 상세정보 폼
	@GetMapping("/qstn/selectform")
	public String qstnUpdateForm(
			@RequestParam("qstnNo") int qstnNo
			, @RequestParam("sbjctCd") String sbjctCd
			, Model model
			, Authentication auth) {
    	CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
    	QstnVO myQstn = qstnService.selectQstn(qstnNo);
    	TchVO tchVO = qstnService.selectTch(sbjctCd);
    	model.addAttribute("profile", userVO.getUserProfile());
    	model.addAttribute("qstn", myQstn);
    	model.addAttribute("sbjctCd", sbjctCd);
    	model.addAttribute("tch", tchVO);
		return "stu/com/classroom/qstn";
	}

    @PostMapping(value = "/qstn")
    @ResponseBody
    public ServiceResult insertQstn(
    		QstnVO qstnVO,
    		RedirectAttributes ra,
    		Authentication auth,
    		Model model) {
    	CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
    	qstnVO.setStuNo(userVO.getUserNo());
        ServiceResult result = qstnService.insertQstn(qstnVO);
        ra.addFlashAttribute("result", result);
        model.addAttribute("temp_title", "질문 보기");
        log.info("ㅎㅎ");
        return result;
    }

    @PostMapping(value = "/qstn/update")
    @ResponseBody
    public ServiceResult updateQstn(
    		QstnVO qstnVO,
    		RedirectAttributes ra,
    		Authentication auth) {
    	ServiceResult result = qstnService.updateQstn(qstnVO);
    	ra.addFlashAttribute("result", result);
    	log.info("ㅎㅎ");
    	return result;
    }

    @PostMapping(value = "/qstn/delete")
    @ResponseBody
    public ServiceResult deleteQstn(
    		@RequestBody QstnVO qstnVO,
    		RedirectAttributes ra,
    		Authentication auth) {
    	ServiceResult result = qstnService.deleteQstn(qstnVO.getQstnNo());
    	ra.addFlashAttribute("result", result);
    	log.info("ㅎㅎ");
    	return result;
    }


}
