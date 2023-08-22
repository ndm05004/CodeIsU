package team.tttt.pms.common.user.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import team.tttt.pms.common.vo.SmsVO;
import team.tttt.pms.common.vo.UserRoleVO;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.stu.vo.StuVO;

@Mapper
public interface UserMapper {
	public int signupUser(UserVO userVO);
	public int singupPs(UserVO userVO);


	public UserVO read(String userNo); // sec 용 리드



	public HashMap<String, Object> phoneCheck(Map<String, String> phoneInfo);
	public int insertSms(SmsVO smsVO);
	public String selectNum(SmsVO replyNum);
	public Map<String, String> readSvlfNm(@Param("userNm") String userNm, @Param("userPhone") String userPhone);


	public String findId(Map<String, String> findInfo);
	public Map<String, String> findPs(Map<String, String> findInfo);

	/* 회원정보 변경 */
	public int updateTempPw(@Param("userNo") String string, @Param("tempPw") String tempPw);
	public StuVO readStuInfo(String userNo); // 회원정보 변경 불러오기



}
