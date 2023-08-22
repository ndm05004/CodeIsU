package team.tttt.pms.stu.mypage.service;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.stu.vo.StuVO;

public interface ModifyProfileService {

	public ServiceResult verifyPs(String userNo, String userPs);

	public StuVO readStuInfo(String userNo);

}
