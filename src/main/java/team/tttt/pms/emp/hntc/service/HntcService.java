package team.tttt.pms.emp.hntc.service;

import java.util.List;

import team.tttt.pms.emp.vo.HntcVO;
import team.tttt.pms.project.vo.PaginationInfoVO;

public interface HntcService {

	public int hntcInsert(HntcVO hntcVo);
	public List<HntcVO> selectHntc(PaginationInfoVO<HntcVO> pagingVO);
	public HntcVO detailHntc(String boNo);
	public int hntcDel(String boNo);
	public int updateHntc(HntcVO hntcVO);
	public void hntcCheckNoUp(String bono);
	public int selectBoardCount(PaginationInfoVO<HntcVO> pagingVO);
	public List<HntcVO> hntcList();
	public HntcVO detailHntc2(String bono);
	public void hntcCheckNoUp2(String bono);

}
