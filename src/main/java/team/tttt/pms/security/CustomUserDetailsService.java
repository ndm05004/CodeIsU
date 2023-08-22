package team.tttt.pms.security;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import team.tttt.pms.common.user.mapper.UserMapper;
import team.tttt.pms.common.vo.CustomUser;
import team.tttt.pms.common.vo.UserVO;

public class CustomUserDetailsService implements UserDetailsService{

	private static final Logger log = LoggerFactory.getLogger(CustomUserDetailsService.class);

//	@Inject
//	private BCryptPasswordEncoder pe;

	@Inject
	private UserMapper userMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		String password = "pwd1";
//		log.info("#### 인코딩된 비밀번호를 확인합니다 ####: " + pe.encode(password));
//		log.info("#### 인코딩된 비밀번호를 확인합니다 ####: " + pe.encode(password));
//		log.info("#### 인코딩된 비밀번호를 확인합니다 ####: " + pe.encode(password));


		log.info("load User by username : " + username);

		// userName은 사용자명이 아니라 사용자 아이디를 의미한다.
		// member를 가지고 최종 리턴에서 넘겨야할 UserDetails를 만들어준다.

		UserVO user;

		try {
			user = userMapper.read(username);
			log.info("query by member mapper : " + user);
			return user == null ? null : new CustomUser(user);
		} catch (Exception e) {
			new UsernameNotFoundException("user with username 로긴안댐"+username);
		}
		return null;
	}



}
