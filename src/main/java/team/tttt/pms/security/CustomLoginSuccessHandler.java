package team.tttt.pms.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

	private static final Logger log = LoggerFactory.getLogger(SavedRequestAwareAuthenticationSuccessHandler.class);

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {
		User customUser = (User) authentication.getPrincipal();
		log.info("[로그인 성공] " + customUser.getUsername() + "로그인!");
		log.info("password : " + customUser.getPassword());

        List<String> roleNames = new ArrayList<>();
        authentication.getAuthorities().forEach(authority ->{
            roleNames.add(authority.getAuthority());
        });
        log.info("권한 : " + roleNames);

        String uri = "";
		// Security가 요청을 가로챈 경우 사용자가 원래 요청했던 URI 정보를 저장한 객체
		RequestCache requestCache = new HttpSessionRequestCache();
		SavedRequest savedRequest = requestCache.getRequest(request, response);

		// 있을 경우 URI 등 정보를 가져와서 사용
		if (savedRequest != null) {
			uri = savedRequest.getRedirectUrl();
			requestCache.removeRequest(request, response);

			response.sendRedirect(uri);


			// 세션 Attribute 확인
			Enumeration<String> list = request.getSession().getAttributeNames();
			while (list.hasMoreElements()) {
				System.out.println(list.nextElement());
			}
			return;
		}



		String userAgent = request.getHeader("User-Agent").toUpperCase();
		System.out.println(userAgent);
		log.info(userAgent);





        if(roleNames.contains("S01")) {
    		if(userAgent.contains("ANDROID") || userAgent.contains("TABLET") || userAgent.contains("IPAD") || userAgent.contains("MOBILE") || userAgent.contains("IPHONE")) {
    			response.sendRedirect("/stu/qrattd"); // 모바일을 식별하여 qr체크페이지로 이동시켜줌
    		} else {
    			response.sendRedirect("/stu/main");
    		}

        } else if(roleNames.contains("E11")) {
            response.sendRedirect("/emp/main");
        } else if(roleNames.contains("E12")) {
        	response.sendRedirect("/tch/main");
        }

        return;

	}


}
