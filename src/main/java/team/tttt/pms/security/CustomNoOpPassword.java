package team.tttt.pms.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;

public class CustomNoOpPassword implements PasswordEncoder {

	private static final Logger log = LoggerFactory.getLogger(CustomNoOpPassword.class);

	@Override
	public String encode(CharSequence rawPassword) {
		log.info("before encode : " + rawPassword);
		return rawPassword.toString();
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		log.info("matches : " + rawPassword + " ::: " + encodedPassword);
		return rawPassword.toString().equals(encodedPassword);
	}

}
