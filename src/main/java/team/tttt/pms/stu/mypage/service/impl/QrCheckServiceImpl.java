package team.tttt.pms.stu.mypage.service.impl;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.emp.vo.AttdVO;
import team.tttt.pms.stu.mypage.mapper.QrCheckMapper;
import team.tttt.pms.stu.mypage.service.QrCheckService;

@Service
@Slf4j
public class QrCheckServiceImpl implements QrCheckService {

	@Inject
	QrCheckMapper mapper;

	public ServiceResult insertToken(String uuidToken) {

		int cnt = mapper.insertToken(uuidToken);

		if(cnt == 1) {
			return ServiceResult.OK;
		} else {

			return ServiceResult.FAILED;
		}

	}

	@Override
	public AttdVO selectAttdVO(String userNo) {

		// 오늘 날짜를 가져옵니다.
		LocalDate today = LocalDate.now();

		// 원하는 형식으로 날짜를 문자열로 변환합니다.
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String todayDate = today.format(formatter);

		AttdVO findAttdVO = new AttdVO();
		findAttdVO.setAttdDt(todayDate);
		findAttdVO.setStuNo(userNo);

		AttdVO resAttdVO = mapper.selectAttdVO(findAttdVO);

		if(resAttdVO == null || resAttdVO.getAttdAbmiYmd() == null) {
			if(resAttdVO == null) {
				mapper.insertAttd(userNo, todayDate);
			}


			AttdVO returnAttdVO = new AttdVO();

			returnAttdVO.setAttdState("none");
			returnAttdVO.setAttdCd("미출결");
			returnAttdVO.setAttdAbmiYmd("-");
			returnAttdVO.setAttdLeaveYmd("-");
			returnAttdVO.setAttdCd("-");

			return returnAttdVO;
		} else {
			return resAttdVO;
		}

	}




}
