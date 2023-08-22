package team.tttt.pms.stu.hakup.service;

import java.util.List;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.CmCdVO;
import team.tttt.pms.stu.vo.CfroomRsvtVO;
import team.tttt.pms.stu.vo.MettingRoomVO;

public interface CfroomRsvtService {
	public ServiceResult insertCfroomRsvt(CfroomRsvtVO cfroomRsvtVO);

	public List<CfroomRsvtVO> selectCfroomRsvtList(String rsvtDt);

	public List<MettingRoomVO> selectMettingRoomList();

	public ServiceResult deleteCfroom(CfroomRsvtVO cfroomRsvtVO);
}
