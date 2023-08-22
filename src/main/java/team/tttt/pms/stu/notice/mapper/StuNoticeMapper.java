package team.tttt.pms.stu.notice.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.emp.vo.HntcVO;
import team.tttt.pms.project.vo.PaginationInfoVO;

@Mapper
public interface StuNoticeMapper {

	public int selectBoardCount(PaginationInfoVO<HntcVO> pagingVO);

	public List<HntcVO> selectHntc(PaginationInfoVO<HntcVO> pagingVO);

	public HntcVO detailNotice(String hntcNo);

	public void hntcCheckNoUp(String hntcNo);
}
