package team.tttt.pms.common.vo;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class CustomUser extends User {

	private UserVO user;

	public CustomUser(String username , String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	public CustomUser(UserVO user) {
		super(user.getUserNo(), user.getUserPswd(),
				user.getAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getRoleCd())).collect(Collectors.toList()));
		this.user = user;
	}

	public UserVO getMember() {
		return user;
	}

	public void setMember(UserVO user) {
		this.user = user;
	}
}
