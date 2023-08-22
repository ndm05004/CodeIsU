package team.tttt.pms.stu.notice.service;

import java.util.List;

import team.tttt.pms.emp.vo.HntcVO;
import team.tttt.pms.project.vo.PaginationInfoVO;

public interface StuNoticeService {

	public int selectBoardCount(PaginationInfoVO<HntcVO> pagingVO);

	public List<HntcVO> selectHntc(PaginationInfoVO<HntcVO> pagingVO);

	public HntcVO detailNotice(String hntcNo);

	public void hntcCheckNoUp(String hntcNo);
}
