package team.tttt.pms.stu.hakup.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.inject.Inject;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.utils.cmdcd.service.CmCdService;
import team.tttt.pms.common.vo.CmCdVO;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.stu.hakup.service.CfroomRsvtService;
import team.tttt.pms.stu.vo.CfroomRsvtVO;
import team.tttt.pms.stu.vo.MettingRoomVO;

@Slf4j
@Controller
@RequestMapping("/stu/hak")
public class CfroomRsvtController {
	@Inject
    private CfroomRsvtService cfroomRsvtService;

	@Inject
	private CmCdService service;

	@GetMapping("/cfroom")
	public String cfroomRsvt(Model model) {

		model.addAttribute("temp_title", "회의실 예약");

		return "stu/com/hakup/cfroom/cfroomrsvt";
	}

	@ResponseBody
	@PostMapping("/cfroom")
	public ServiceResult cfroomRsvtInsert(@RequestBody CfroomRsvtVO cfroomRsvtVO, Authentication auth) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		String userName = userVO.getUserNo();
		cfroomRsvtVO.setStuNo(userName);
		ServiceResult result = cfroomRsvtService.insertCfroomRsvt(cfroomRsvtVO);

		return result;
	}

	// 날짜를 선택할 때
	@ResponseBody
	@GetMapping(value="/cfroom/selectdt",produces = "application/json;charset=utf-8")
	public Map<String, Object> cfroomSelectDt(
			@RequestParam("rsvtDt") String rsvtDt
			, Authentication auth) {
		List<CfroomRsvtVO> cfroomRestList = cfroomRsvtService.selectCfroomRsvtList(rsvtDt);
		List<MettingRoomVO> mettingRoomList = cfroomRsvtService.selectMettingRoomList();

		CustomUser mVO = (CustomUser) auth.getPrincipal();
		UserVO userVO = mVO.getMember();
		String userNo = userVO.getUserNo();

		Map<String, Object> retMap = new HashMap<String, Object>();


		retMap.put("mettingRoomList", mettingRoomList);
		retMap.put("cfroomRestList", cfroomRestList);
		retMap.put("userNo", userNo);
		return retMap;
	}

	@ResponseBody
	@PostMapping(value ="/cfroom/delete",produces = "application/json;charset=utf-8")
	public ServiceResult cfroomDelete(@RequestBody CfroomRsvtVO cfroomRsvtVO) {
		ServiceResult result = cfroomRsvtService.deleteCfroom(cfroomRsvtVO);
		return result;
	}

}
