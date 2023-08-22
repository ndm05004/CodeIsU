package team.tttt.pms.common.utils.cmFile.web;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.utils.cmFile.service.CommonFileService;

@Controller
@Slf4j
@RequestMapping("/cmFile")
public class CommonFileController {

	@Inject
	private CommonFileService service;


	
	
	
}
