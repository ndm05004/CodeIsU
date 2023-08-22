package team.tttt.pms.common.user.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

import org.springframework.context.annotation.EnableAspectJAutoProxy;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.SmsVO;
import team.tttt.pms.common.vo.UserVO;


public interface UserService {

	public ServiceResult signupUser(UserVO userVO) throws IOException, SQLException;

	public ServiceResult phoneCheck(Map<String, String> phoneInfo);

	public ServiceResult sendMessage(String string);

	public ServiceResult matchNum(SmsVO replyNum);

	public Map<String, String> readSvlfNm(String userNm, String userPhone);

	public Map<String, String> findId(Map<String, String> findInfo);

	public ServiceResult findPs(Map<String, String> findInfo);




}
