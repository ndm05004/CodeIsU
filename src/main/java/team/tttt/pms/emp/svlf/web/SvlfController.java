package team.tttt.pms.emp.svlf.web;

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
import team.tttt.pms.emp.svlf.service.SvlfService;
import team.tttt.pms.emp.vo.EmpVO;
import team.tttt.pms.emp.vo.LectureRoomVO;
import team.tttt.pms.emp.vo.SvlfVO;

@Slf4j
@Controller
@RequestMapping("/emp/svlf")
public class SvlfController {

	@Inject
	private SvlfService svlfService;

	@GetMapping("/svlfList")
	public String svlfList(Model model) {
		log.info("svlfList()...실행");

		List<SvlfVO> svlfList = svlfService.svlfList();
		List<SvlfVO> noSvlfList = svlfService.noSvlfList();

		model.addAttribute("svlfList", svlfList);
		model.addAttribute("noSvlfList", noSvlfList);
		model.addAttribute("temp_title", "연수과정");

		return "emp/com/stumanage/svlf/svlfList";
	}

	@ResponseBody
	@GetMapping("/roomList")
	public List<LectureRoomVO> roomList(SvlfVO svlfVO){
		log.info("roomList()...실행");

		List<LectureRoomVO> roomList = svlfService.roomList(svlfVO);

		return roomList;
	}

	@ResponseBody
	@GetMapping("/teachList")
	public List<EmpVO> teachList(SvlfVO svlfVO){
		log.info("teachList()...실행");

		List<EmpVO> teachList = svlfService.teachList(svlfVO);

		return teachList;
	}

	@ResponseBody
	@PostMapping(value = "/svlfInsert", produces = "application/json;charset=utf-8")
	public String svlfInsert(@RequestBody SvlfVO svlfVO) {
		log.info("svlfInsert()...실행");
		String result = "";

		//log.info("svlfVO", svlfVO);

		int check = svlfService.svlfInsert(svlfVO);

		if(check == 1) {
			result = "성공";
		}else {
			result = "실패";
		}
		return result;
	}

	@ResponseBody
	@GetMapping("/svlfInfo")
	public SvlfVO svlfInfo(String no) {
		log.info("svlfInfo()...실행");

		SvlfVO svlfVO = svlfService.svlfInfo(no);

		return svlfVO;
	}

	@ResponseBody
	@GetMapping("/svlfmainlist")
	public List<SvlfVO> svlfmainlist(){
		log.info("svlfmainlist()...실행");

		List<SvlfVO> svlfList = svlfService.svlfList();

		return svlfList;
	}

	/*
	 * @GetMapping("/svlfForm") public String svlfForm(Model model) {
	 * log.info("svlfForm()...실행");
	 *
	 * List<LectureRoomVO> lectureRoomList = new ArrayList<LectureRoomVO>();
	 * List<EmpVO> tchList = new ArrayList<EmpVO>();
	 *
	 * lectureRoomList = svlfService.lectureRoomList(); tchList =
	 * svlfService.checkDepartCd();
	 *
	 * model.addAttribute("lectureRoomList", lectureRoomList);
	 * model.addAttribute("tchList", tchList);
	 *
	 * return "emp/com/stumanage/svlf/svlfForm"; }
	 */

	/*
	 * @GetMapping("/svlfDetail") public String svlfDetail(String svlfno, Model
	 * model) { log.info("svlfDetail()...실행"); String goPage = "";
	 *
	 * SvlfVO svlfVO = svlfService.svlfInfo(svlfno);
	 *
	 * if(svlfVO != null) { model.addAttribute("svlfVO", svlfVO); goPage =
	 * "emp/com/stumanage/svlf/svlfDetail"; }else { goPage =
	 * "redirect:/emp/svlf/svlfForm"; }
	 *
	 * return goPage; }
	 *
	 * @GetMapping("/svlfUpdateForm") public String svlfUpdateForm(String
	 * svlno,Model model) { log.info("svlfUpdateForm()...실행"); String goPage = "";
	 *
	 * SvlfVO svlfVO = svlfService.svlfInfo(svlno);
	 *
	 * if(svlfVO != null) { List<LectureRoomVO> lectureRoomList = new
	 * ArrayList<LectureRoomVO>(); List<EmpVO> tchList = new ArrayList<EmpVO>();
	 *
	 * lectureRoomList = svlfService.lectureRoomList(); tchList =
	 * svlfService.checkDepartCd();
	 *
	 * log.info("lectureRoomList", lectureRoomList);
	 * System.out.println(lectureRoomList.get(0));
	 *
	 * model.addAttribute("lectureRoomList", lectureRoomList);
	 * model.addAttribute("tchList", tchList); model.addAttribute("svlfVO", svlfVO);
	 * model.addAttribute("status", "u"); goPage =
	 * "emp/com/stumanage/svlf/svlfForm"; }else { goPage =
	 * "redirect:/emp/svlf/svlfDetail?svlfno="+svlno; }
	 *
	 * return goPage; }
	 *
	 * @PostMapping("/svlfUpdate") public String svlfUpdate(SvlfVO svlfVO, String
	 * bdforeClassCd) { log.info("svlfUpdate()...실행"); String goPage = "";
	 *
	 * svlfService.lectureRoomUpdate2(bdforeClassCd); int result =
	 * svlfService.svlfUPdate(svlfVO);
	 *
	 * if(result == 1) { String classCode = svlfVO.getLectureRoomCd();
	 * svlfService.lectureRoomUpdate(classCode);
	 *
	 * goPage = "redirect:/emp/svlf/svlfDetail?svlfno="+svlfVO.getSvlfNo(); }else {
	 * goPage = "redirdct:/emp/svlf/svlfUpdateForm?svlno="+svlfVO.getSvlfNo(); }
	 *
	 * return goPage; }
	 *
	 * @GetMapping("/svlfDel") public String svlfDel(String svlno) {
	 * log.info("svlfDel()...실행"); String goPage = "";
	 *
	 * SvlfVO svlfVO = svlfService.svlfInfo(svlno); int result =
	 * svlfService.svlfDel(svlno);
	 *
	 * if(result == 1) { String classCode = svlfVO.getLectureRoomCd();
	 * svlfService.lectureRoomUpdate2(classCode);
	 *
	 * goPage = "redirect:/emp/svlf/svlfList"; }else { goPage =
	 * "redirect:/emp/svlf/svlfDetail?svlfno="+svlno; }
	 *
	 * return goPage; }
	 */

}
