package team.tttt.pms.tch.classroom.web;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
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
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.utils.FileUploadUtils;
import team.tttt.pms.common.vo.AtchFileVO;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.tch.classroom.service.TchAsmtService;
import team.tttt.pms.tch.vo.AsmtVO;
import team.tttt.pms.tch.vo.QstDtlVO;
import team.tttt.pms.tch.vo.QstVO;
import team.tttt.pms.tch.vo.SbmsnResultVO;
import team.tttt.pms.tch.vo.SbmsnVO;

@Slf4j
@Controller
@RequestMapping("/tch/class")
public class TchAsmtController {

	@Inject
	private TchAsmtService tchAsmtService;


	@GetMapping("/asmt")
	public String asmtMain(@RequestParam("sbjctCd") String sbjctCd, Model model) {
		model.addAttribute("sbjctCd", sbjctCd);
		model.addAttribute("temp_title", "과제");
		return "tch/com/class/asmtList";
	}

	@GetMapping("/asmt/asmtList")
	@ResponseBody
	public List<AsmtVO> asmtList(@RequestParam("sbjctCd") String sbjctCd) {
		List<AsmtVO> asmtList = tchAsmtService.selectAsmtList(sbjctCd); // 과제 리스트
		return asmtList;
	}

	// 과제 등록 폼
	@GetMapping("/asmt/asmtform")
	public String asmtForm(@RequestParam("sbjctCd") String sbjctCd, Model model) {
		model.addAttribute("sbjctCd", sbjctCd);
		model.addAttribute("updateCd", 'N');
		model.addAttribute("temp_title", "과제 등록");
		return "tch/com/class/asmtform";
	}

	// 과제 등록
	@PostMapping(value = "/asmt",produces = "application/json;charset=utf-8")
	@ResponseBody
	public String insertAsmt(
			AsmtVO asmtVO
			, Authentication auth
			, HttpServletRequest request) throws IOException {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		String userNo = userVO.getUserNo();
		asmtVO.setEmpNo(userNo);

		// 공통과제 등록
		ServiceResult insertAsmtresult = tchAsmtService.insertAsmt(asmtVO);
		List<QstVO> qstList = asmtVO.getQstList();

		for(int i=0; i<qstList.size(); i++) {
			// 문제 등록
			QstVO qstVO = qstList.get(i);
			List<MultipartFile> fileList = qstVO.getFileList();

			String realPath = request.getSession().getServletContext().getRealPath("");
			String setPath = "static/resources/bbs/storage/";

			List<AtchFileVO> fileVOList = new ArrayList<AtchFileVO>();
			String tbNm = "TB_QST"; // 테이블명

			if(fileList != null) {
				for(int k=0; k<qstVO.getFileList().size(); k++) {
					log.info("파일 사이즈 : " + qstVO.getFileList().size());
					fileVOList.add(
							FileUploadUtils.uploadfile(userNo, realPath, setPath, qstVO.getFileList().get(k), tbNm));
				}
			}
			qstVO.setAsmtNo(asmtVO.getAsmtNo());
			ServiceResult insertQstResult = tchAsmtService.insertQst(qstVO, fileVOList);


			if(qstVO.getQstDtlList() != null) {

				for(int j=0; j<qstVO.getQstDtlList().size(); j++) {
					QstDtlVO qstDtlVO = qstVO.getQstDtlList().get(j);
					qstDtlVO.setQstNo(qstVO.getQstNo());
					ServiceResult insertQstDtlResult = tchAsmtService.insertQstDtl(qstDtlVO);
				}
			}
		}
		return asmtVO.getSbjctCd();
	}

	// 과제 삭제
	// @RequestBody 이건 JSON 형식을 보내줄때만 작성
	@PostMapping(value = "/asmt/delete",produces = "application/json;charset=utf-8")
	@ResponseBody
	public ServiceResult deleteAsmt(@RequestBody AsmtVO asmtVo) {
		log.info("asmtNo 체킁" +asmtVo);
		ServiceResult result = tchAsmtService.deleteAsmt(asmtVo.getAsmtNo());
		return result;
	}

	// 과제 상세보기
	@GetMapping("/asmt/asmtSelectForm")
	public String updateAsmtForm(
			@RequestParam("sbjctCd") String sbjctCd
			, @RequestParam("asmtNo") int asmtNo
			, Model model) {
		//log.info("asmtNo" + asmtNo);
		model.addAttribute("temp_title", "과제 상세보기");
		AsmtVO asmtVO = tchAsmtService.selectAsmt(asmtNo);
		List<AtchFileVO> atchFileList = tchAsmtService.selectAtchFileList(asmtNo);
		model.addAttribute("sbjctCd", sbjctCd);
		model.addAttribute("asmtVO", asmtVO);
		model.addAttribute("atchFileList", atchFileList);
		return "tch/com/class/asmt";
	}


	// 제출된 과제 보기
	@GetMapping("/asmt/sbmsn")
	public String sbmsnResultList(
			@RequestParam("asmtNo") int asmtNo
			,@RequestParam("sbjctCd") String sbjctCd
			, Model model) {
		log.info("체킁" + asmtNo);
		List<SbmsnResultVO> sbmsnUserList = tchAsmtService.selectSbmsnList(asmtNo);
		model.addAttribute("sbmsnUserList", sbmsnUserList);
		model.addAttribute("asmtNo", asmtNo);
		model.addAttribute("sbjctCd", sbjctCd);
		model.addAttribute("temp_title", "과제 제출함");
		return "tch/com/class/sbmsn";
	}

	// 선택한 학생의 시험지
	@PostMapping(value = "/asmt/sbmsn",produces = "application/json;charset=utf-8")
	@ResponseBody
	public Map<String, Object> sbmsnResult(@RequestBody SbmsnResultVO sbmsnResultVO) {
		String stuNo = sbmsnResultVO.getStuNo();
		int asmtNo = sbmsnResultVO.getAsmtNo();
		log.info("sbmsnResult 체킁 stuNo:" + stuNo);
		log.info("sbmsnResult 체킁 asmtNo:" + asmtNo);

		List<SbmsnVO> sbmsnList = tchAsmtService.selectSbmsnResultList(stuNo,asmtNo);
		AsmtVO asmtVO = tchAsmtService.selectAsmt(asmtNo);
		List<AtchFileVO> atchFileList = tchAsmtService.selectAtchFileList(asmtNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sbmsnList", sbmsnList);
		map.put("asmtVO", asmtVO);
		map.put("atchFileList", atchFileList);
		return map;
	}

}
