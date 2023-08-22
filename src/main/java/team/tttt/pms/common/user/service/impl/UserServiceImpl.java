package team.tttt.pms.common.user.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.user.mapper.UserMapper;
import team.tttt.pms.common.user.service.UserService;
import team.tttt.pms.common.vo.SmsVO;
import team.tttt.pms.common.vo.UserVO;

@Slf4j
@Service
@EnableAspectJAutoProxy
public class UserServiceImpl implements UserService {

	@Inject
	private UserMapper mapper;

	@Override
	@Transactional(rollbackFor = SQLException.class)
	public ServiceResult signupUser(UserVO userVO) throws IOException, SQLException {


		int cnt = mapper.signupUser(userVO);
		int cnt2 = mapper.singupPs(userVO);
		if (cnt == 1 && cnt2 == 1) {
			return ServiceResult.OK;
		} else {
			throw new SQLException("[회원가입 DB가 정상적으로 작동하지 않았습니다]");
		}

	}



	/*
	 * 명단에 유저 정보있는지 확인
	 */
	@Override
	public ServiceResult phoneCheck(Map<String, String> phoneInfo) {
		ServiceResult result = ServiceResult.FAILED;

		HashMap<String, Object> searchResult = mapper.phoneCheck(phoneInfo);

		if (searchResult == null) { // 명단에 없을때
			log.info("[회원가입명단체크] 회원가입대기명단에 없는 이름과 연락처 입니다.");
			return ServiceResult.NOTEXIST;
		} else if (searchResult.get("JOIN_DT") != null) {
			result = ServiceResult.EXIST;
		} else { // 회원정보가 있으나 가입일이 null(아직 미가입일때)
			result = ServiceResult.OK;
		}
		log.info("[회원가입명단체크] " + searchResult.get("USER_NM") + "님  가입가능 유무 " + result);

		return result;
	}

	@Override
	public ServiceResult sendMessage(String phoneNum) {
		ServiceResult result = ServiceResult.FAILED;

		DefaultMessageService messageService = NurigoApp.INSTANCE.initialize("NCSSQBGBL4GRLC0I",
				"CJPO9BY9DESTZPUOKLXFSLNL5SDAC1EL", "https://api.coolsms.co.kr");

		Message message = new Message();
		message.setFrom("01020007734");
		message.setTo(phoneNum);

		// 네자리 난수 생성
		String ranNum = String.valueOf((int) (Math.random() * 8999) + 1000);

		message.setText("[CodeIsU]본인확인을 위해 인증번호 [" + ranNum + "]를 입력해주세요.");

        SingleMessageSentResponse response = messageService.sendOne(new SingleMessageSendingRequest(message));
        System.out.println("[문자전송결과]" + response);

		log.info("[문자전송] " + phoneNum + " ::: " + ranNum + "전송됨");

        if(response.getStatusCode().equals("2000")) {
//		if (true) {
			SmsVO smsVO = new SmsVO();
			smsVO.setSmsRcvr(phoneNum);
			smsVO.setSmsCn(ranNum);
			int cnt = mapper.insertSms(smsVO);
			if (cnt == 1) {
				result = ServiceResult.OK;
			}
		}

		return result;
	}

	/*
	 * 사용자가 전송한 인증번호 일치 확인
	 */
	@Override
	public ServiceResult matchNum(SmsVO replyNum) {
		ServiceResult result = ServiceResult.FAILED;

		String severNum = mapper.selectNum(replyNum); // 사용자가 보낸 값과 연락처가 5분내 DB에 있는지 확인

		if (severNum == null) {
			result = ServiceResult.NOTEXIST;
		} else if (severNum.equals(replyNum.getSmsCn())) {
			result = ServiceResult.MATCH;
		}

		return result;
	}

	@Override
	public Map<String, String> readSvlfNm(String userNm, String userPhone) {

		return mapper.readSvlfNm(userNm, userPhone);
	}

	@Override
	public Map<String, String> findId(Map<String, String> findInfo) {

		String resultId = mapper.findId(findInfo);

		Map<String, String> result = new HashMap<String, String>();

		if (resultId != null) {
			result.put("id", resultId);
			result.put("state", ServiceResult.EXIST.name());
		} else {
			result.put("state", ServiceResult.NOTEXIST.name());
		}
		return result;
	}

	@Override
	public ServiceResult findPs(Map<String, String> findInfo) {
		ServiceResult result = ServiceResult.FAILED;
		// 이름과 연락처 가져옴
		Map<String, String> resultInfo = mapper.findPs(findInfo);

		if (resultInfo != null) {// 값이 있다면 임시 비밀번호 발송

			// 임시 비밀번호 생성(UUID이용)
			String tempPw = UUID.randomUUID().toString().replace("-", "");// -를 제거
			tempPw = tempPw.substring(0, 8);// tempPw를 앞에서부터 8자리 잘라줌

			int cnt = mapper.updateTempPw(findInfo.get("userNo"), tempPw);

			if (cnt == 1) {
				log.info(findInfo.get("userNo") + "사용자 임시비밀번호 DB업데이트 성공  : " + tempPw);

//			DefaultMessageService messageService = NurigoApp.INSTANCE.initialize("NCSSQBGBL4GRLC0I", "CJPO9BY9DESTZPUOKLXFSLNL5SDAC1EL", "https://api.coolsms.co.kr");
//
//	        Message message = new Message();
//	        message.setFrom("01020007734");
//	        message.setTo(resultInfo.get("USER_PHONENO"));
//
//	        message.setText("[CodeIsU]임시비밀번호는 [" + tempPw + "] 입니다.");
//		    SingleMessageSentResponse response = messageService.sendOne(new SingleMessageSendingRequest(message));
//		    System.out.println("[문자전송결과]" + response);

				log.info("[문자발송 성공] [CodeIsU]임시비밀번호는 [" + tempPw + "] 입니다.");
				result = ServiceResult.OK;
			}
		} else { // 사용자가 조회한 값 없음
			log.info("사용자가 조회한 값이 없습니다.");
		}

		return result;
	}

}
