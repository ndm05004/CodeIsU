package team.tttt.pms.project.chatting;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.websocket.server.ServerEndpoint;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.project.vo.ChattingVO;
import team.tttt.pms.stu.vo.StuVO;

@Slf4j
public class WebSocketHandler extends TextWebSocketHandler {

	private Map<String, List<WebSocketSession>> userSessions = new HashMap<>();


	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		UserVO chatmember = (UserVO) session.getAttributes().get("userVO");
		String projNo = (String) session.getAttributes().get("projNo");

		List<WebSocketSession> sessionList = userSessions.get(projNo);

	    if (sessionList == null) {
	        sessionList = new ArrayList<>();
	        userSessions.put(projNo, sessionList);
	    }
		sessionList.add(session);

		userSessions.put(projNo, sessionList);


	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("handleTextmessage: " + session + " : " + message);

		//protocol: RoomNum, 보내는id, 내용
		String msg = message.getPayload();

		// 데이터 바인딩, requestbody같은 느낌
		ObjectMapper objectMapper = new ObjectMapper();
		ChattingVO chatContent = objectMapper.readValue(message.getPayload(), ChattingVO.class);

		log.info("chatContent : : : "+chatContent);

		Gson gson = new Gson();
		TextMessage sendMsg = new TextMessage(gson.toJson(chatContent));

		String projNo = chatContent.getProjNo();

		List<WebSocketSession> chatList =  userSessions.get(projNo);

		log.info("chatList : : : "+chatList);

        // 세션이 닫힌 경우 제거
        if (chatList != null) {
            chatList.removeIf(s -> !s.isOpen());
        }

		for (WebSocketSession webSocketSession : chatList) {

			log.info("webSocketSession : : : "+webSocketSession);
			webSocketSession.sendMessage(sendMsg);
		}

	}



	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		//sessions.remove(session);
		System.out.println("afterHandleTextmessage: " + session + " : " + status);

        for (List<WebSocketSession> chatList : userSessions.values()) {
            chatList.removeIf(s -> !s.isOpen());
        }

	}




}
