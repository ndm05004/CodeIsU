package team.tttt.pms.emp.attd.web;

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
import team.tttt.pms.emp.attd.service.AttdService;
import team.tttt.pms.emp.schedule.service.ScheduleService;
import team.tttt.pms.emp.vo.AttdVO;
import team.tttt.pms.emp.vo.SvlfVO;

@Slf4j
@Controller
@RequestMapping("/emp/stuman")
public class AttdController {

	@Inject
	private AttdService attdService;

	@GetMapping("/attend")
	public String attend(Model model) {
		model.addAttribute("temp_title", "출결 관리");
		log.info("attend()...실행");


		return "emp/com/stumanage/attd/attdMain";
	}

	@ResponseBody
	@GetMapping("/startAttdTable")
	public List<SvlfVO> startAttdTable(String dateInfo){
		log.info("startAttdTable()...실행");


		log.info("date"+dateInfo);
		List<SvlfVO> svlfList = new ArrayList<SvlfVO>();

		svlfList = attdService.findSvlfList(dateInfo);

		return svlfList;
	}

	@ResponseBody
	@GetMapping("/stuList")
	public List<AttdVO> stuList(AttdVO attdVO){
		log.info("stuList()...실행");

		List<AttdVO> stuList = new ArrayList<AttdVO>();

		stuList = attdService.stuList(attdVO);

		log.info("학생 정보 : " + stuList);

		return stuList;
	}

	@ResponseBody
	@PostMapping(value = "/attdStatus", produces = "application/json;charset=utf-8")
	public String attdStatus(@RequestBody AttdVO attdVO) {
		log.info("attdStatus...()실행");
		String result = "";

		int check = attdService.attdStatusUp(attdVO);

		if(check == 1) {
			result = "성공";
		}else {
			result = "실패";
		}

		return result;
	}
}
