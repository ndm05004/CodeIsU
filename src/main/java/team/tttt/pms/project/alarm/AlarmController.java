package team.tttt.pms.project.alarm;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.project.Issue.service.PmsIssueService;
import team.tttt.pms.project.alarm.service.AlarmService;
import team.tttt.pms.project.vo.AlarmVO;
import team.tttt.pms.project.vo.IssueVO;
import team.tttt.pms.project.vo.ProjVO;

@Controller
@Slf4j
@RequestMapping("/pms/project")
public class AlarmController {

	@Inject
	private PmsIssueService service;

	@Inject
	private AlarmService alarmService;

	@ResponseBody
	@PostMapping("/userno")
	public UserVO getAlarm(Authentication auth) {

		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();

		log.info("로그인 정보 : " + userVO.getUserNo()); log.info("로그인 정보 : " + userVO);


		/* List<String> ProList = service.getProjNo(userVO.getUserNo()); */
		return userVO;
	}


	@ResponseBody
	@PostMapping(value="/alarm/userNoList" ,produces ="application/json;charset=utf-8")
	public List<UserVO> selectUserNoList(@RequestBody ProjVO projVO) {
		log.info("projVO.getProjNo() : "+ projVO.getProjNo());
		List<UserVO> userNoList = service.selectUserNoList(projVO.getProjNo());
		log.info("userNoList: " + userNoList);
		return userNoList;
	}

	@ResponseBody
	@GetMapping(value="/alarmlist", produces = "application/json;charset=utf-8")
	public List<AlarmVO> alarmList(String projNo) {
		log.debug("pno가져와지나 :", projNo);

		List<AlarmVO> vo = alarmService.alarmList(projNo);

		return vo;


	}

}
