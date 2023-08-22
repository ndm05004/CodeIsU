package team.tttt.pms.stu.notice.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.emp.vo.HntcVO;
import team.tttt.pms.project.vo.PaginationInfoVO;
import team.tttt.pms.stu.notice.mapper.StuNoticeMapper;
import team.tttt.pms.stu.notice.service.StuNoticeService;

@Service
public class StuNoticeServiceImpl implements StuNoticeService{
	@Inject
	private StuNoticeMapper stuNoticeMapper;

	@Override
	public int selectBoardCount(PaginationInfoVO<HntcVO> pagingVO) {
		return stuNoticeMapper.selectBoardCount(pagingVO);
	}

	@Override
	public List<HntcVO> selectHntc(PaginationInfoVO<HntcVO> pagingVO) {
		return stuNoticeMapper.selectHntc(pagingVO);
	}

	@Override
	public HntcVO detailNotice(String hntcNo) {
		return stuNoticeMapper.detailNotice(hntcNo);
	}

	@Override
	public void hntcCheckNoUp(String hntcNo) {
		stuNoticeMapper.hntcCheckNoUp(hntcNo);
	}

}
