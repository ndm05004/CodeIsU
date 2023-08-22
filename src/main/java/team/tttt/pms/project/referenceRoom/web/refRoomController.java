package team.tttt.pms.project.referenceRoom.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/pms")
public class refRoomController {


	@GetMapping(value="/refroom")
	public String refRoom(Model model) {
		return "pms/com/referenceRoom";
	}
}
