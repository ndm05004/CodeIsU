package team.tttt.pms.stu.mypage.service.impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.user.mapper.UserMapper;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.stu.mypage.service.ModifyProfileService;
import team.tttt.pms.stu.vo.StuVO;

@Service
public class ModifyProfileServiceImpl implements ModifyProfileService{

	@Inject
	UserMapper mapper;

//	@Inject
//	private BCryptPasswordEncoder pe;

	@Override
	public ServiceResult verifyPs(String userNo, String userPs) {
		UserVO userVO = mapper.read(userNo);
		ServiceResult result = ServiceResult.FAILED;


		// 암호 암호화시 걸어줍니다.
//        if (true == pe.matches(userPs, userVO.getUserPswd())) {}
		if (userVO.getUserPswd().equals(userPs)) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.NOTEXIST;
		}
		return result;
	}

	@Override
	public StuVO readStuInfo(String userNo) {
		return mapper.readStuInfo(userNo);
	}


}
