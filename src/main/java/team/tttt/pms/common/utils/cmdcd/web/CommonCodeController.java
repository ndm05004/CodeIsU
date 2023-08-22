package team.tttt.pms.common.utils.cmdcd.web;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import team.tttt.pms.common.utils.cmdcd.service.CmCdService;
import team.tttt.pms.common.vo.CmCdVO;

@Controller
@RequestMapping("/cmCd")
public class CommonCodeController {

	@Inject
	private CmCdService service;

	@ResponseBody
	@GetMapping("/selectCode")
	public List<CmCdVO> selectCode(String cdTypeId) {

		List<CmCdVO> cdList = service.selectCode(cdTypeId);
		System.out.println(cdList.get(0).getCdTypeNm()+"------getcdTypeNm");
		System.out.println(cdList.get(1).getCdCUseYn()+"------getcdTypeNm");
		return cdList;
	}

}
