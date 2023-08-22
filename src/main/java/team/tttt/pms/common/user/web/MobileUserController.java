package team.tttt.pms.common.user.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MobileUserController {

	/* 모바일 로그인 화면 */
	@RequestMapping(value = "/m")
	public String mobileLogin() {

		return "common/user/login_mobile";
	}
}
