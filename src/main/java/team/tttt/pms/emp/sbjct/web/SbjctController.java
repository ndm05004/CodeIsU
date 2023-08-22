package team.tttt.pms.emp.sbjct.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.emp.sbjct.service.SbjctService;
import team.tttt.pms.emp.vo.EmpVO;
import team.tttt.pms.emp.vo.SbjctVO;
import team.tttt.pms.emp.vo.SvlfVO;
import team.tttt.pms.stu.vo.StuVO;

@Slf4j
@Controller
@RequestMapping("/emp/sbjct")
public class SbjctController {

	@Inject
	private SbjctService sbjctService;

	@GetMapping("/sbjctList")
	public String sbjctList(Model model) {
		log.info("sbjctList()...실행");

		List<SbjctVO> sbjctList = new ArrayList<SbjctVO>();
		List<SvlfVO> svlfList = new ArrayList<SvlfVO>();
		List<EmpVO> empList = new ArrayList<EmpVO>();

		sbjctList = sbjctService.sbjctList();
		svlfList = sbjctService.svlfNmList();
		empList = sbjctService.empNmList();

		model.addAttribute("sbjctList", sbjctList);
		model.addAttribute("svlfNmList", svlfList);
		model.addAttribute("empNmList", empList);

		return "emp/com/class/sbjct/sbjctList";
	}

	@ResponseBody
	@GetMapping("/resbjctlist")
	public List<SbjctVO> resbjctlist(String selectval, String menuval){
		log.info("resbjctlist()...실행");

		SbjctVO sbjctVO = new SbjctVO();
		sbjctVO.setSelectVal(selectval);
		sbjctVO.setMenuVal(menuval);

		List<SbjctVO> svlflist = sbjctService.resbjctlist(sbjctVO);

		return svlflist;
	}

	@ResponseBody
	@GetMapping("/svlfList")
	public List<SvlfVO> svlfList(){
		log.info("svlfList()...실행");

		List<SvlfVO> svlflist = sbjctService.svlfList();

		return svlflist;
	}


	@ResponseBody
	@GetMapping("/svlfTime")
	public SvlfVO svlfTime(String svlfNo){
		log.info("svlfTime()...실행");

		SvlfVO svlfVO = sbjctService.svlfTime(svlfNo);
		return svlfVO;
	}

	@ResponseBody
	@GetMapping("/sbjctInfo")
	public SbjctVO sbjctInfo(String sbjctCd) {
		log.info("sbjctInfo()...실행");

		SbjctVO sbjctVO = sbjctService.sbjctInfo(sbjctCd);

		return sbjctVO;
	}

	@ResponseBody
	@GetMapping("/sbjctStuList")
	public List<StuVO> sbjctStuList(String sbjctCd) {
		log.info("sbjctInfo()...실행");

		List<StuVO> stuList = sbjctService.sbjctStuList(sbjctCd);

		return stuList;
	}


	@ResponseBody
	@GetMapping("/sbjcttimeinfo")
	public List<SbjctVO> sbjcttimeinfo(String svlfNo, String scduHr){
		log.info("sbjcttimeinfo()...실행");
		List<SbjctVO> sbjctTimeInfo = new ArrayList<SbjctVO>();
		SbjctVO sbjctVO = new SbjctVO();
		sbjctVO.setSvlfNo(svlfNo);
		sbjctVO.setScduHr(scduHr);

		log.info("svlNo는"+svlfNo);
		log.info("scdHr"+scduHr);

		//sql로 2를 보낼 수 있기는 한데 쓰지 않음
		//vo에 넣어서 보낼 것
		sbjctTimeInfo = sbjctService.sbjctListInfo(sbjctVO);

		return sbjctTimeInfo;
	}

	@ResponseBody
	@GetMapping("/sbjcttimeinfo2")
	public List<SbjctVO> sbjcttimeinfo2(String svlfNo, String sbjctCd, String scduHr){
		log.info("sbjcttimeinfo()...실행");
		List<SbjctVO> sbjctTimeInfo = new ArrayList<SbjctVO>();
		SbjctVO sbjctVO = new SbjctVO();
		sbjctVO.setSvlfNo(svlfNo);
		sbjctVO.setSbjctCd(sbjctCd);
		sbjctVO.setScduHr(scduHr);

		sbjctTimeInfo = sbjctService.sbjctListInfo2(sbjctVO);

		return sbjctTimeInfo;
	}

	@ResponseBody
	@GetMapping("/scduinfo")
	public List<SbjctVO> scduinfo(String startDate, String endDate, String scduHr){
		log.info("scduinfo()...실행");
		List<SbjctVO> teachList = new ArrayList<SbjctVO>();

		SbjctVO sbjctVO = new SbjctVO();
		sbjctVO.setSbjctBgng(startDate);
		sbjctVO.setSbjctDdlb(endDate);
		sbjctVO.setScduHr(scduHr);

		log.info(startDate);
		log.info(endDate);

		teachList = sbjctService.scduInfo(sbjctVO);

		return teachList;
	}

	@ResponseBody
	@GetMapping("/scduinfo2")
	public List<SbjctVO> scduinfo2(String startDate, String endDate, String teachName){
		log.info("scduinfo()...실행");
		List<SbjctVO> teachList = new ArrayList<SbjctVO>();

		SbjctVO sbjctVO = new SbjctVO();
		sbjctVO.setSbjctBgng(startDate);
		sbjctVO.setSbjctDdlb(endDate);
		sbjctVO.setUserNm(teachName);

		log.info(startDate);
		log.info(endDate);
		log.info(teachName);

		teachList = sbjctService.scduInfo2(sbjctVO);
		log.info(""+teachList);

		return teachList;
	}


	@ResponseBody
	@PostMapping("/sbjctInsert")
	public String sbjctInsert(@RequestBody SbjctVO sbjctVO) {
		log.info("sbjctInsert()...실행");

		int result = sbjctService.sbjctInsert(sbjctVO);

		return "성공";
	}

	@ResponseBody
	@PostMapping("/sbjctUpdate")
	public String sbjctUpdate(@RequestBody SbjctVO sbjctVO) {
		log.info("sbjctUpdate()...실행");
		String answer = "";

		int result = sbjctService.sbjctUpdate(sbjctVO);

		if(result == 1) {
			answer = "성공";
		}else {
			answer = "실패";
		}

		return answer;
	}

	/*
	 * @GetMapping("/sbjctDetail") public String sbjctDetail(Model model, String
	 * sbjCd) { log.info("sbjctDetail()...실행"); List<EmpVO> empList = new
	 * ArrayList<EmpVO>();
	 *
	 * SbjctVO sbjctVO = sbjctService.sbjctInfo(sbjCd); empList =
	 * sbjctService.empNmList();
	 *
	 * model.addAttribute("empNmList", empList); model.addAttribute("sbjctVO",
	 * sbjctVO);
	 *
	 * return "emp/com/class/sbjct/sbjctInfo"; }
	 */

	@GetMapping("/sbjctDel")
	public String sbjctDel(String sbjctCd) {

		int result = sbjctService.sbjctDel(sbjctCd);

		return "redirect:/emp/sbjct/sbjctList";
	}
}
