package team.tttt.pms.project.Issue.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.project.Issue.service.PmsIssueService;
import team.tttt.pms.project.alarm.AlarmHandler;
import team.tttt.pms.project.vo.CmntVO;
import team.tttt.pms.project.vo.IssueVO;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.PaginationInfoVO;
import team.tttt.pms.project.vo.ProjVO;

@RequestMapping("/pms/project")
@Slf4j
@Controller
public class PmsIssueController {

	@Inject
	private PmsIssueService service;

	@GetMapping("/issue")
	public String getStorageList(Authentication auth, String projNo, Model model, HttpSession session) {
		CustomUser mVO = (CustomUser) auth.getPrincipal();
        UserVO userVO = mVO.getMember();
        String userNo = userVO.getUserNo();

        Map<String, String> mjMap = new HashMap<String, String>();
        mjMap.put("userNo", userNo);
        mjMap.put("projNo", projNo);


        MemManagementVO memVO = service.getMemJbttlCd(mjMap);

        ProjVO pVO = service.getProjNm(projNo);
        String projNm = pVO.getProjNm();

        model.addAttribute("memVO",memVO);
        model.addAttribute("userNo", userNo);
        model.addAttribute("projNo",projNo);
        model.addAttribute("userVO",userVO);
        model.addAttribute("projNm",projNm);

		return "pms/com/issue";
	}

	@GetMapping("/issueList")
	@ResponseBody
	public Map<String, Object> storageList(PaginationInfoVO<IssueVO> vo) {

		PaginationInfoVO<IssueVO> pagingVO = new PaginationInfoVO<IssueVO>();

		Map<String, Object> issueList = new HashMap<String, Object>();

		if(StringUtils.isNotBlank(vo.getSearchWord())) {
			pagingVO.setSearchType(vo.getSearchType());
			pagingVO.setSearchWord(vo.getSearchWord());
			issueList.put("searchType", vo.getSearchType());
			issueList.put("searchWord", vo.getSearchWord());
		}

		pagingVO.setCurrentPage(vo.getCurrentPage());

		pagingVO.setProjNo(vo.getProjNo());

		int totalRecord = service.selectBoardCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);

		List<IssueVO> dataList = service.getIssueList(pagingVO);

		pagingVO.setDataList(dataList);

		issueList.put("pagingVO", pagingVO);

		return issueList;
	}

	//이슈 생성
	@ResponseBody
	@PostMapping(value="/insertissue",produces ="application/json;charset=utf-8")
	public String insertIssue(@RequestBody IssueVO issueVO) {
		log.info("issueVO.getStuNo() : " + issueVO.getStuNo());

    	ServiceResult result = service.insertIssue(issueVO);

    	String goPage ="";

    	if (result.equals(ServiceResult.OK)) {
            goPage = "성공";
        } else {
            goPage = "실패";
        }
        return goPage;
	}


	@ResponseBody
	@GetMapping(value="/detail",produces ="application/json;charset=utf-8")
	public IssueVO Detail(IssueVO issueVO) {

		System.out.println(issueVO+ "----public IssueVO Detail(String issueNo) ");

		IssueVO vo = new IssueVO();
		vo = service.Detail(issueVO);
		log.info("vooooooooooooooooooooo",vo);
		return vo;
	}


	@ResponseBody
	@GetMapping(value="/cmntdetail",produces ="application/json;charset=utf-8")
	public List<CmntVO> cmntDetail(CmntVO cmntVO) {

		List<CmntVO> vo = new ArrayList<CmntVO>();
		vo = service.cmntDetail(cmntVO);

		log.info("vooooooooooooooooooooo",vo);
		return vo;
	}

	@ResponseBody
	@PostMapping(value="/update",produces ="application/json;charset=utf-8")
	public String update(@RequestBody IssueVO issueVO) {

    	ServiceResult result = service.update(issueVO);

    	String goPage ="";

    	if (result.equals(ServiceResult.OK)) {
            goPage = "성공";
        } else {
            goPage = "실패";
        }
        return goPage;
	}


	@ResponseBody
	@PostMapping(value="/del",produces ="application/json;charset=utf-8")
	public String del(@RequestBody IssueVO issueVO) {

		ServiceResult result = service.del(issueVO);

		String goPage = "";

		if(result.equals(ServiceResult.OK)) {
			goPage = "성공";
		} else {
			goPage = "실패";
		}
        return goPage;
	}

	@ResponseBody
	@PostMapping(value="/insertcomment",produces ="application/json;charset=utf-8")
	public String insertComment(@RequestBody CmntVO cmntVO) {

		ServiceResult result = service.insertComment(cmntVO);

		String goPage = "";

		if(result.equals(ServiceResult.OK)) {
			goPage = "성공";
		} else {
			goPage = "실패";
		}
		return goPage;
	}

	@ResponseBody
	@GetMapping(value="/detailcommnet",produces ="application/json;charset=utf-8")
	public CmntVO detailComment(String cmntNo) {

		System.out.println("----public CmntVO detailComment(String cmntNo) " + cmntNo);

		CmntVO vo = new CmntVO();
		vo = service.detailComment(cmntNo);
		log.info("detailComment VO : ",vo);
		return vo;
	}

	@ResponseBody
	@PostMapping(value="/updatecomment", produces ="text/plain;charset=utf-8")
	public String updateCommnet(@RequestBody CmntVO cmntVO) {
		log.info("public String updateCommnet(@RequestBody CmntVO cmntVO) : " + cmntVO );
    	ServiceResult result = service.updateCommnet(cmntVO);

    	String goPage ="";

    	if (result.equals(ServiceResult.OK)) {
            goPage = "성공";
        } else {
            goPage = "실패";
        }
        return goPage;
	}

	@ResponseBody
	@PostMapping(value="/delcomment", produces ="text/plain;charset=utf-8")
	public String deleteCommnet(@RequestBody CmntVO cmntNo) {
		log.info("ublic String deleteCommnet(@RequestBody CmntVO cmntNo) : " + cmntNo );

		ServiceResult result = service.deleteCommnet(cmntNo);

		String goPage ="";

		if (result.equals(ServiceResult.OK)) {
			goPage = "성공";
		} else {
			goPage = "실패";
		}
		return goPage;
	}




}
