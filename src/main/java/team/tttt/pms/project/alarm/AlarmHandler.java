package team.tttt.pms.project.alarm;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.project.alarm.service.AlarmService;
import team.tttt.pms.project.vo.AlarmVO;

@Slf4j

public class AlarmHandler extends TextWebSocketHandler {



	@Inject
	private AlarmService alarmService;


	private static List<WebSocketSession> list = new ArrayList<WebSocketSession>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("## 누군가 접속", session);
		list.add(session);

	}


	//JSP에서 메세지 받을 때.
	//handleTextMessage :
	//WebSocket 클라이언트로부터 메시지를 수신할 때 호출
	//수신된 메시지를 처리하고, 해당 메시지에 대한 응답으로 필요한 작업을 수행

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

		log.debug("message.getPayload():::", message.getPayload());

		String[] msgData = message.getPayload().split(",");   //getPayload : TextMessage 객체의 페이로드를 문자열 형태로 가져올 수 있음

		log.debug("length: " + msgData.length);
		for(int i=0; i < msgData.length; i++) {
			log.debug("length!!!!!!!!!!!!!" + i + "  : " + msgData[i] );
		}



		log.debug("ck:" + msgData + "ck:");
		if(msgData[0].equals("신규 이슈")) {
			log.debug("이슈 등록");
			for (WebSocketSession webSocketSession : list) {
				webSocketSession.sendMessage(new TextMessage("신규 이슈,"+msgData[1]+","+msgData[2]+","
															+msgData[3]+","+msgData[4]+","+msgData[5]+","+msgData[6]+","+msgData[7]+","+msgData[8]));
			}
		}else if(msgData[0].equals("새로운 일감")) {
			log.debug("일감 등록");
			for (WebSocketSession webSocketSession : list) {
				webSocketSession.sendMessage(new TextMessage("새로운 일감,"+msgData[1]+","+msgData[2]+","+msgData[3]+","
															+msgData[4]+","+msgData[5]+","+msgData[6]+","+msgData[7]+","+msgData[8]));
			}
		}else if(msgData[0].equals("지원서")) {
			log.debug("지원서");
			for (WebSocketSession webSocketSession : list) {
				webSocketSession.sendMessage(new TextMessage("프로젝트 지원 신청서,"+msgData[1]+","+msgData[2]+","+msgData[3]+","
						+msgData[4]+","+msgData[5]+","+msgData[6]+","+msgData[7]+","+msgData[8]));
			}
		}else {
			log.debug("알림 없을 때");
			for (WebSocketSession webSocketSession : list) {
				webSocketSession.sendMessage(new TextMessage("새로운 알림이 없습니다."));
			}

		}



		AlarmVO aVO = new AlarmVO();
		aVO.setStuNo(msgData[7]);
		aVO.setAlarmCn(msgData[8]);
		aVO.setAlarmCd(msgData[0]);
		aVO.setAlarmDt(msgData[5]);
		aVO.setProjNo(msgData[1]);
		aVO.setUserNm(msgData[2]);

		alarmService.saveAlarm(aVO); // 알림 메시지 저장
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("## 누군가 떠남", session);
		list.remove(session);
	}


}
