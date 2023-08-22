package team.tttt.pms.emp.main.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/emp")
public class EmpMainController {

	@GetMapping("/main")
	public String empMain(Model model) {
		model.addAttribute("temp_title", "행정 대시보드");
		return "emp/com/main";
	}

	@GetMapping("/main/m")
	public String emptest() {
		log.info("empMain()...실행");
		return "emp/com/main";
	}


}
