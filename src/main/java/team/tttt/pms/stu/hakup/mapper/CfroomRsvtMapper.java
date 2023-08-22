package team.tttt.pms.stu.hakup.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import team.tttt.pms.common.vo.CmCdVO;
import team.tttt.pms.stu.vo.CfroomRsvtVO;
import team.tttt.pms.stu.vo.MettingRoomVO;

@Mapper
public interface CfroomRsvtMapper {
	public List<CfroomRsvtVO> selectCfroomRsvtList(String rsvtDt);

	public int insertCfroomRsvt(CfroomRsvtVO cfroomRsvtVO);

	public List<MettingRoomVO> selectMettingRoomList();

	public int deleteCfroom(CfroomRsvtVO cfroomRsvtVO);

}
