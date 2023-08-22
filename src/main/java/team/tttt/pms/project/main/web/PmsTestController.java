package team.tttt.pms.project.main.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/pms")
public class PmsTestController {

	@RequestMapping(value = "/test", method=RequestMethod.GET)
	public String tempTest() {
		return "pms/com/test";
	}

}
