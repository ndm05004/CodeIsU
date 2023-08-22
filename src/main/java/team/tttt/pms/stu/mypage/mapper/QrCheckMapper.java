package team.tttt.pms.stu.mypage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.emp.vo.AttdVO;

@Mapper
public interface QrCheckMapper {

	public int insertToken(@Param("uuidToken") String uuidToken);

	public AttdVO selectAttdVO(AttdVO findAttdVO);

	public void insertAttd(@Param("stuNo")String userNo, @Param("attdDt")String todayDate);



}
