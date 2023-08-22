package team.tttt.pms.stu.notice.web;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.emp.vo.HntcVO;
import team.tttt.pms.project.vo.PaginationInfoVO;
import team.tttt.pms.stu.notice.service.StuNoticeService;

@Controller
@Slf4j
@RequestMapping("/stu")
public class StuNoticeController {
    @Inject
    private StuNoticeService stuNoticeService;

    @GetMapping("/notice")
    public String notice(
    		@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model
			) {
    	PaginationInfoVO<HntcVO> pagingVO = new PaginationInfoVO<HntcVO>();

		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}

		pagingVO.setCurrentPage(currentPage);


		int totalRecord = stuNoticeService.selectBoardCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);


		List<HntcVO> hntcList = stuNoticeService.selectHntc(pagingVO);
		pagingVO.setDataList(hntcList);
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("temp_title", "공지사항");
        return "stu/com/notice/noticeList";
    }

	@GetMapping("/notice/detail")
	public String hntcDetail(String hntcNo, Model model) {
		log.info("hntcDetail()...실행");

		HntcVO noticeVO = stuNoticeService.detailNotice(hntcNo);
		stuNoticeService.hntcCheckNoUp(hntcNo);

		model.addAttribute("hntcVO", noticeVO);
		return "stu/com/notice/noticeDetail";
	}
}
