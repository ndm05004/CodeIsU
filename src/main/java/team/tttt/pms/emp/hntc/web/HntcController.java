package team.tttt.pms.emp.hntc.web;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.emp.hntc.service.HntcService;
import team.tttt.pms.emp.vo.HntcVO;
import team.tttt.pms.project.vo.PaginationInfoVO;

@Slf4j
@Controller
@RequestMapping("/emp/hntc")
public class HntcController {
	@Inject
	private HntcService empService;


	@GetMapping("/hntcForm")
	public String empForm() {
		log.info("empForm()...실행");
		return "emp/com/hntc/hntc/hntcForm";
	}

	@ResponseBody
	@GetMapping("/hntcList")
	public List<HntcVO> hntcList(){
		log.info("hntcList()...실행");

		List<HntcVO> hntcList = empService.hntcList();

		return hntcList;
	}

	@RequestMapping("/hntcBoard")
	public String hntcBoard(@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model){

		PaginationInfoVO<HntcVO> pagingVO = new PaginationInfoVO<HntcVO>();

		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}

		pagingVO.setCurrentPage(currentPage);


		int totalRecord = empService.selectBoardCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);


		List<HntcVO> hntcList = empService.selectHntc(pagingVO);
		pagingVO.setDataList(hntcList);
		model.addAttribute("pagingVO", pagingVO);

		return "emp/com/hntc/hntc/hntcBoard";
	}


	@GetMapping("/hntcDetail")
	public String hntcDetail(String bono, Model model) {
		log.info("hntcDetail()...실행");

		HntcVO hntcVO = empService.detailHntc(bono);
		empService.hntcCheckNoUp(bono);

		model.addAttribute("hntcVO", hntcVO);
		return "emp/com/hntc/hntc/hntcDetail";
	}

	@GetMapping("/mainHntcDetail")
	public String mainHntcDetail(String bono, Model model) {
		log.info("mainHntcDetail()...실행");

		log.info("bonobono : " + bono);

		empService.hntcCheckNoUp2(bono);
		HntcVO hntcVO = empService.detailHntc2(bono);

		model.addAttribute("hntcVO", hntcVO);
		return "emp/com/hntc/hntc/hntcDetail";
	}

	@GetMapping("/dscsnBoard")
	public String dscsnBoard() {
		log.info("dscsnBoard()...실행");
		return "emp/com/hntc/hntc/hntcdscsnBoard";
	}

	@PostMapping("/hntcInsert")
	public String hntcInsert(
			Authentication auth,
			HntcVO hntcVo, Model model) {
		log.info("hntcInsert()...실행");
		String goPage = "";

		CustomUser mVO = (CustomUser) auth.getPrincipal();
		String writer = mVO.getUsername();
		//log.info("writer " + writer);

		hntcVo.setEmpNo(writer);
		int result = empService.hntcInsert(hntcVo);

		if(result == 1) {
			goPage = "redirect:/emp/hntc/hntcBoard";
		}else {
			goPage = "emp/com/hntc/hntc/hntcForm";
		}
		return goPage;
	}

	@GetMapping("/hntcUpdateForm")
	public String hntcUpdateForm(String bono, Model model) {
		log.info("hntcUpdateForm()...실행");
		HntcVO hntcVO = empService.detailHntc(bono);

		model.addAttribute("hntcVO", hntcVO);
		model.addAttribute("status", "u");
		return "emp/com/hntc/hntc/hntcForm";
	}

	@PostMapping("/hntcUpdate")
	public String hntcUpdate(HntcVO hntcVO, Model model) {
		log.info("hntcUpdate()...실행");
		String goPage = "";

		int result = empService.updateHntc(hntcVO);

		if(result == 1) {
			goPage = "redirect:/emp/hntc/hntcDetail?bono="+hntcVO.getHntcNo();
		}else {
			model.addAttribute("hntcVO", hntcVO);
			model.addAttribute("status", "u");
			return "emp/com/hntc/hntc/hntcForm";
		}

		return goPage;
	}

	@GetMapping("/hntcDel")
	public String hntcDel(String bono,Model model) {
		log.info("hntcDel()...실행");
		String goPage = "";

		int result = empService.hntcDel(bono);

		if(result == 1) {
			goPage = "redirect:/emp/hntc/hntcBoard";
		}else {
			goPage = "redirect:/emp/hntc/hntcDetail?bono="+bono;
		}
		return goPage;
	}


}
