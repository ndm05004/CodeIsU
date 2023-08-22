package team.tttt.pms.stu.mypage.service;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.emp.vo.AttdVO;

public interface QrCheckService {

	public ServiceResult insertToken(String uuidToken);

	public AttdVO selectAttdVO(String userNo);



}
