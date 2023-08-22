package team.tttt.pms.security;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class CustomLoginFailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {

		if (exception instanceof AuthenticationServiceException) {
			request.setAttribute("failMsg", "사용자 정보가 존재하지 않습니다.");

		} else if(exception instanceof BadCredentialsException) {
			request.setAttribute("failMsg", "아이디 또는 비밀번호가 틀립니다.");
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/common/user/login.jsp");
		dispatcher.forward(request, response);
	}

}
