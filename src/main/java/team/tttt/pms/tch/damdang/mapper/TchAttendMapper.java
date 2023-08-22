package team.tttt.pms.tch.damdang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import team.tttt.pms.emp.vo.AttdVO;

@Mapper
public interface TchAttendMapper {

	public List<AttdVO> selectAttdList(@Param("userNo") String userNo, @Param("attdDt") String attdDt);
}
