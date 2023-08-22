package team.tttt.pms.emp.schedule.web;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.emp.schedule.service.ScheduleService;
import team.tttt.pms.emp.vo.SbjctVO;
import team.tttt.pms.emp.vo.SvlfVO;

@Slf4j
@Controller
@RequestMapping("/emp/class")
public class scheduleController {

	@Inject
	private ScheduleService scheduleService;

	@GetMapping("/schedule")
	public String scheduleMain() {
		log.info("scheduleMain()...실행");

		return "emp/com/class/schedule/scheduleMain";
	}

	@ResponseBody
	@GetMapping("/svlfList")
	public List<SvlfVO> svlfList(){
		log.info(("svlfList()...실행"));

		List<SvlfVO> svlfList = new ArrayList<SvlfVO>();

		svlfList = scheduleService.svlfAllList();

		return svlfList;
	}

	@ResponseBody
	@GetMapping("/sbjctInfo")
	public List<SbjctVO> sbjctInfo(String svlfNo){
		log.info(("sbjctInfo()...실행"));

		List<SbjctVO> sbjctInfoList = new ArrayList<SbjctVO>();

		sbjctInfoList = scheduleService.sbjctInfoList(svlfNo);

		return sbjctInfoList;
	}
}
