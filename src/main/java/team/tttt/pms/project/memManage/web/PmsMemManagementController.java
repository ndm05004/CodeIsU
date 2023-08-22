package team.tttt.pms.project.memManage.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.project.memManage.service.MemManagementService;
import team.tttt.pms.project.vo.MemJoinAplyVO;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.ProjVO;

@Slf4j
@Controller
@RequestMapping("/pms")
public class PmsMemManagementController {

    @Inject
    private MemManagementService memService;


/*
    @GetMapping(value="/memlist")
    public String memberManagementList(Model model) {

    	SecurityContext sc = SecurityContextHolder.getContext();

    	CustomUser loginUser = (CustomUser)sc.getAuthentication().getPrincipal();
    	log.debug("user: {}" ,loginUser);

    	//loginUser에서 직책 불러오기
        String jttlCD = memService.plCheck(loginUser.getUsername());

        // 문자열 비교 주의!!!
        if(jttlCD.equals("P001-1")) {
		     return "/pms/com/memManagement";
        }else{
   	     	return "/emp/com/main";
        }
    }

*/


    //멤버관리 페이지
	@GetMapping(value="/manage")
	public String memberManagementList(Authentication auth, String projNo, Model model, HttpSession session) {
        CustomUser mVO = (CustomUser) auth.getPrincipal();
        UserVO userVO = mVO.getMember();
        String userNo = userVO.getUserNo();

        Map<String, String> mjMap = new HashMap<String, String>();
        mjMap.put("userNo", userNo);
        mjMap.put("projNo", projNo);

	    session.setAttribute("userVO" ,userVO);
	    session.setAttribute("projNo" ,projNo);
        MemManagementVO memVO = memService.getMemJbttlCd(mjMap);


        model.addAttribute("memVO",memVO);
        model.addAttribute("userNo", userNo);
        model.addAttribute("projNo",projNo);
        model.addAttribute("userVO",userVO);

		return "pms/com/memManagement";
	}

	//프로젝트 멤버리스트
    @ResponseBody
    @PostMapping(value="/mem",produces = "application/json;charset=utf-8")
    public List<MemManagementVO> memList(@RequestBody String projNo) {

        List<MemManagementVO> memList = memService.memList(projNo);
        return memList;
    }

    //멤버 직책 수정
    @ResponseBody
    @PostMapping(value="/memupdate",produces = "application/json;charset=utf-8")
    public String positionModify(MemManagementVO vo) {


        String goPage = "";

        ServiceResult result = memService.positionModify(vo);

        if (result.equals(ServiceResult.OK)) {
            goPage = "성공";
        } else {
            goPage = "실패";
        }
        return goPage;
    }


    //가입신청 멤버 리스트
    @ResponseBody
    @PostMapping(value="/memjoinaply",produces = "application/json;charset=utf-8")
    public List<MemJoinAplyVO> memJoinAplyList(String projNo, Model model) {
        List<MemJoinAplyVO> memJoinList = memService.memJoinAplyList(projNo);
        return memJoinList;
    }


    //가입신청 멤버 상세보기
    @ResponseBody
    @PostMapping(value="/memjoindetail",produces = "application/json;charset=utf-8")
    public MemJoinAplyVO memjoinDetail(@RequestBody Map<String, String> map) {
    	log.info("joinVO"+ map.get("stuNo"));

    	MemJoinAplyVO vo = new MemJoinAplyVO();


    	vo = memService.memJoinDetail(map);

    	log.info(vo.getAplyCn());
    	log.info(vo.getAplyTech());

    	return vo;

    }

    //승인 클릭시 멤버리스트 추가
    @ResponseBody
    @PostMapping(value="/meminsert",produces = "application/json;charset=utf-8")
    public String memInsert(@RequestBody MemManagementVO memVO) {
    	log.info(memVO.getStuNo());
    	log.info("projNo:::::: " , memVO.getProjNo());


    	ServiceResult result = memService.memInsert(memVO);

    	String goPage ="";

    	if (result.equals(ServiceResult.OK)) {
            goPage = "성공";
        } else {
            goPage = "실패";
        }
        return goPage;
    }

    //승인시 가입신청 리스트에서 삭제
    @ResponseBody
    @PostMapping(value="/memdel",produces = "application/json;charset=utf-8")
    public String memDel(@RequestBody MemManagementVO memVO) {
    	log.info("getStuNo : ", memVO.getStuNo());
    	log.info("getJbttlCd : ", memVO.getJbttlCd());
    	log.info("getTeamJoinDt : ", memVO.getTeamJoinDt());
    	log.info("getProjNo : ", memVO.getProjNo());

    	ServiceResult result = memService.memDel(memVO);

    	String goPage ="";

    	if (result.equals(ServiceResult.OK)) {
    		goPage = "성공";
    	} else {
    		goPage = "실패";
    	}
    	return goPage;
    }


     //프로젝트 상세 내용 보이기
	 @ResponseBody
	 @PostMapping(value="/projstatus",produces ="application/json;charset=utf-8")
	 public ProjVO projStatus(@RequestBody ProjVO projVO) {

		 ProjVO vo = new ProjVO();
		 vo =  memService.projStatus(projVO);

		 return vo;
	 }


	 //프로젝트 상세 내용 수정
	 @ResponseBody
	 @PostMapping(value="/projupdate",produces ="application/json;charset=utf-8")
	 public ProjVO projUpdate(@RequestBody ProjVO projVO) {

		 ProjVO vo = new ProjVO();
		 vo =  memService.projUpdate(projVO);

		 return vo;
	 }

	 //프로젝트 삭제
	 @ResponseBody
	 @PostMapping(value="/projdelete",produces ="application/json;charset=utf-8")
		public String projDelete(@RequestBody ProjVO projVO) {
		 String goPage ="";
		 ServiceResult result = memService.projDelete(projVO.getProjNo());
		 if (result.equals(ServiceResult.OK)) {
			goPage = "성공";
		 } else {
	 		goPage = "실패";
		 }
		   return goPage;
		 }

	 //프로젝트 멤버 삭제
	 @ResponseBody
	 @PostMapping(value="/projMemDel",produces = "application/json;charset=utf-8")
	 public String projMemDel(@RequestBody MemManagementVO memVO) {
	 	log.info(memVO.getStuNo());
	 	log.info(memVO.getJbttlCd());
	 	log.info(memVO.getTeamJoinDt());
	 	log.info(memVO.getProjNo());

	 	ServiceResult result = memService.projMemDel(memVO);

	 	String goPage ="";

	 	if (result.equals(ServiceResult.OK)) {
	 		goPage = "성공";
	 	} else {
	 		goPage = "실패";
	 	}
	 	return goPage;
	 }


	 //프로젝트 가입신청자 삭제
	 @ResponseBody
	 @PostMapping(value="/aplydel",produces = "application/json;charset=utf-8")
	 public String aplyDel(@RequestBody MemJoinAplyVO aplyVO) {

	 	ServiceResult result = memService.aplyDel(aplyVO.getProjNo());

	 	String goPage ="";

	 	if (result.equals(ServiceResult.OK)) {
	 		goPage = "성공";
	 	} else {
	 		goPage = "실패";
	 	}
	 	return goPage;
	 }


	 //프로젝트 상세 내용 수정
	 @ResponseBody
	 @PostMapping(value="/proj/conupdate",produces = "application/json;charset=utf-8")
	 public String projConUpdate(@RequestBody ProjVO projVO) {


		 ServiceResult result = memService.projConUpdate(projVO);
		 log.info("projVO.getProjNm(): "+ projVO.getProjNm());
		 log.info("projVO.getProjExpln(): "+ projVO.getProjExpln());
		 log.info("projVO.getProjSttsCd(): "+ projVO.getProjSttsCd());

		 String goPage ="";

		 if (result.equals(ServiceResult.OK)) {
			 goPage = "성공";
		 } else {
			 goPage = "실패";
		 }
		 return goPage;
	 }


}
