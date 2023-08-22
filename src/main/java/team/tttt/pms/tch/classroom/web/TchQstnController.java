package team.tttt.pms.tch.classroom.web;

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

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.stu.vo.QstnVO;
import team.tttt.pms.tch.classroom.service.TchQstnService;

@Slf4j
@Controller
@RequestMapping("/tch/class")
public class TchQstnController {

	@Inject
	private TchQstnService tchQstnService;

	@GetMapping("/qstn")
	public String qstnList(Model model, @RequestParam("sbjctCd") String sbjctCd) {
		model.addAttribute("sbjctCd", sbjctCd);
		model.addAttribute("temp_title", "질문 답변");
		return "tch/com/class/qstnList";
	}

    // 전체 리스트 출력
    @ResponseBody
    @GetMapping(value = "/qstn/qstnlist/all", produces = "application/json;charset=utf-8")
    public List<QstnVO> qstnListAll(
    		@RequestParam("sbjctCd") String sbjctCd) {
		// 해당 질문 정보와 해당 질문을 한 학생의 프로필을 출력
    	List<QstnVO> qstnList = tchQstnService.selectQstnList(sbjctCd);
    	log.info("전체 리스트 출력 컨트롤러");
    	log.info("qstnList"+qstnList);
    	return qstnList;
    }

    // 미답변 리스트 출력
    @ResponseBody
    @GetMapping(value = "/qstn/qstnlist/ansno", produces = "application/json;charset=utf-8")
    public List<QstnVO> qstnListAnsNo(
    		@RequestParam("sbjctCd") String sbjctCd) {
    	// 해당 질문 정보와 해당 질문을 한 학생의 프로필을 출력
    	List<QstnVO> qstnList = tchQstnService.selectQstnListAnsNo(sbjctCd);
    	log.info("미답변 리스트 출력 컨트롤러");
    	log.info("qstnList"+qstnList);
    	return qstnList;
    }

    // 답변 완료 리스트 출력
    @ResponseBody
    @GetMapping(value = "/qstn/qstnlist/ansyes", produces = "application/json;charset=utf-8")
    public List<QstnVO> qstnListAnsYes(
    		@RequestParam("sbjctCd") String sbjctCd) {
    	// 해당 질문 정보와 해당 질문을 한 학생의 프로필을 출력
    	List<QstnVO> qstnList = tchQstnService.selectQstnListAnsYes(sbjctCd);
    	log.info("답변 완료 리스트  컨트롤러");
    	log.info("qstnList"+qstnList);
    	return qstnList;
    }

    // 질문답변 상세보기
	@GetMapping("/qstn/selectform")
	public String qstnDetail(
			Model model
			, @RequestParam("qstnNo") int qstnNo
			, @RequestParam("sbjctCd") String sbjctCd
			) {
		QstnVO qstnVO = tchQstnService.selectQstn(qstnNo);
		model.addAttribute("qstn", qstnVO);
		model.addAttribute("sbjctCd", sbjctCd);
		model.addAttribute("temp_title", "질문 보기");
		return "tch/com/class/qstn";
	}

	// 질문답변 등록
	@PostMapping("/qstn/ansinsert")
	@ResponseBody
	public QstnVO ansinsert(
			@RequestBody QstnVO qstnVO
			, Authentication auth) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		String userNo = userVO.getUserNo();
		qstnVO.setEmpNo(userNo);

		ServiceResult result = tchQstnService.insertAns(qstnVO);
		QstnVO qstn = tchQstnService.selectQstn(qstnVO.getQstnNo());
		return qstn;
	}

	// 수정 폼으로 이동
	@GetMapping("/qstn/updateform")
	public String ansUpdateForm(
			Model model
			, @RequestParam("qstnNo") int qstnNo
			, @RequestParam("sbjctCd") String sbjctCd
			) {
		QstnVO qstnVO = tchQstnService.selectQstn(qstnNo);
		model.addAttribute("qstn", qstnVO);
		model.addAttribute("sbjctCd", sbjctCd);
		model.addAttribute("temp_title", "질문 보기");
		return "tch/com/class/qstnUpdate";
	}

	// 질문답변 삭제
	@PostMapping("/qstn/ansdelete")
	@ResponseBody
	public QstnVO ansdelete(
			@RequestBody QstnVO qstnVO) {


		ServiceResult result = tchQstnService.deleteAns(qstnVO.getQstnNo());
		QstnVO qstn = tchQstnService.selectQstn(qstnVO.getQstnNo());
		return qstn;
	}



}
