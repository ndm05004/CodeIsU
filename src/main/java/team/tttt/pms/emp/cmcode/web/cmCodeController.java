package team.tttt.pms.emp.cmcode.web;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.vo.CmCdVO;
import team.tttt.pms.emp.cmcode.service.CmCodeService;
import team.tttt.pms.emp.vo.cmTypeVO;

@Slf4j
@Controller
@RequestMapping("/emp/cmcode")
public class cmCodeController {

	@Inject
	private CmCodeService cmCodeService;

	@GetMapping("")
	public String cmcodemain(Model model) {
		log.info("cmcodemain()...실행");

		List<cmTypeVO> cmtyList = new ArrayList<cmTypeVO>();
		cmtyList = cmCodeService.cmtyList();

		log.info(""+cmtyList);

		model.addAttribute("cmtyList", cmtyList);

		return "emp/com/cmcode/cmcodemain";
	}

	@ResponseBody
	@GetMapping("/codelist")
	public List<CmCdVO> codelist(String cdTypeId){
		log.info("codelist()...실행");

		List<CmCdVO> codeList = new ArrayList<CmCdVO>();

		codeList = cmCodeService.codeList(cdTypeId);


		if(codeList.size() == 0) {
			CmCdVO cmcdVO = new CmCdVO();
			cmcdVO.setCdTypeId(cdTypeId);
			cmcdVO.setCdVl(0);

			codeList.add(cmcdVO);
			return codeList;
		}

		/*
		 * 코드 그룹에 코드가 하나도 없을 경우 0으로 나오면서 jsp부분에서 버그 발생 해결해야함
		 * 0번쨰에 id만 추가해주던지, 그냥 list 길이가 0이며 아이디를 전달해주는 방식 생각했었음
		 * if(codeList.size() == 0) { codeList. }
		 */

		return codeList;
	}

	@ResponseBody
	@PostMapping(value="/codeTypeInsert", produces = "application/json;charset=utf-8")
	public String codeTypeInsert(@RequestBody cmTypeVO cmtypeVO) {
		log.info("codeTypeInsert()...실행");
		log.info("cmtypeVO"+cmtypeVO);
		String result = "";

		List<cmTypeVO> cmtyList = new ArrayList<cmTypeVO>();
		cmtyList = cmCodeService.cmtyList();

		String cdtyId = cmtypeVO.getCdTypeId();
		String cdtyName = cmtypeVO.getCdTypeNm();

		for(int i=0; i<cmtyList.size(); i++) {
			String id = cmtyList.get(i).getCdTypeId();
			if(cdtyId.equals(id)) {
				result = "아이디";
				return result;
			}
		}

		for(int i=0; i<cmtyList.size(); i++) {
			String name = cmtyList.get(i).getCdTypeNm();

			if(cdtyName.equals(name)) {
				result = "이름";
				return result;
			}
		}

		int check =  cmCodeService.codeTypeInsert(cmtypeVO);

		if(check == 1) {
			result = "성공";
		}else {
			result = "실패";
		}

		return result;
	}

	@ResponseBody
	@PostMapping(value="/codeTypeUpdate", produces = "application/json;charset=utf-8")
	public String codeTypeUpdate(@RequestBody cmTypeVO cmtypeVO) {
		log.info("codeTypeUpdate()...실행");
		String result = "";

		List<cmTypeVO> cmtyList = new ArrayList<cmTypeVO>();
		String codeTypeId = cmtypeVO.getCdTypeId();
		String cmName = cmtypeVO.getCdTypeNm();

		cmtyList = cmCodeService.noMecodeTypeList(codeTypeId);

		for(int i=0; i<cmtyList.size(); i++) {
			String name = cmtyList.get(i).getCdTypeNm();

			if(cmName.equals(name)) {
				result = "이름";
				return result;
			}
		}

		int check =  cmCodeService.codeTypeUpdate(cmtypeVO);

		if(check == 1) {
			result = "성공";
		}else {
			result = "실패";
		}

		return result;
	}

	@ResponseBody
	@PostMapping(value="/codeInsert", produces = "application/json;charset=utf-8")
	public String codeInsert(@RequestBody CmCdVO codeVO) {
		log.info("codeInsert()...실행");
		String result = "";

		List<CmCdVO> cdList = new ArrayList<CmCdVO>();

		String codeTypeId = codeVO.getCdTypeId();
		String codeName = codeVO.getCdNm();

		cdList = cmCodeService.codeList(codeTypeId);

		for(int i=0; i<cdList.size(); i++) {
			String name = cdList.get(i).getCdNm();

			if(codeName.equals(name)) {
				result = "중복";
				return result;
			}
		}

		int check = cmCodeService.codeInsert(codeVO);

		if(check == 1) {
			result = "성공";
		}else {
			result = "실패";
		}

		return result;
	}

	@ResponseBody
	@PostMapping(value="/noneCodeInsert", produces = "application/json;charset=utf-8")
	public String noneCodeInsert(@RequestBody CmCdVO codeVO) {
		log.info("noneCodeInsert()...실행");
		String result = "";

		List<CmCdVO> cdList = new ArrayList<CmCdVO>();

		String codeTypeId = codeVO.getCdTypeId();
		String codeName = codeVO.getCdNm();

		cdList = cmCodeService.codeList(codeTypeId);

		for(int i=0; i<cdList.size(); i++) {
			String name = cdList.get(i).getCdNm();

			if(codeName.equals(name)) {
				result = "중복";
				return result;
			}
		}

		int check = cmCodeService.noneCodeInsert(codeVO);

		if(check == 1) {
			result = "성공";
		}else {
			result = "실패";
		}

		return result;
	}

	@ResponseBody
	@PostMapping(value="/codeUpdate", produces = "application/json;charset=utf-8")
	public String codeUpdate(@RequestBody CmCdVO codeVO) {
		log.info("codeUpdate()...실행");
		String result = "";

		List<CmCdVO> cdList = new ArrayList<CmCdVO>();

		String codeTypeId = codeVO.getCdTypeId();
		String codeName = codeVO.getCdNm();
		int codeVl = codeVO.getCdVl();

		CmCdVO cmcdVO = new CmCdVO();
		cmcdVO.setCdTypeId(codeTypeId);
		cmcdVO.setCdVl(codeVl);

		cdList = cmCodeService.noMeCodeList(cmcdVO);

		for(int i=0; i<cdList.size(); i++) {
			String name = cdList.get(i).getCdNm();

			if(codeName.equals(name)) {
				result = "중복";
				return result;
			}
		}

		int check = cmCodeService.codeUpdate(codeVO);

		if(check == 1) {
			result = "성공";
		}else {
			result = "실패";
		}

		return result;
	}

	@ResponseBody
	@GetMapping("/cmcdList")
	public List<cmTypeVO> cmcdList(){
		log.info("cmcdList()...실행");
		List<cmTypeVO> cmTypeList = new ArrayList<cmTypeVO>();

		cmTypeList = cmCodeService.cmtyList();

		return cmTypeList;
	}
}
