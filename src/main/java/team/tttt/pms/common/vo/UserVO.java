package team.tttt.pms.common.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class UserVO {
	private String userNo;
	private String userPswd;
	private String enabled;
	private String userType;

	private List<UserRoleVO> authList;

	private String userNm;
	private String userBrdt;
	private String userGender;
	private String userEmlAddr;
	private String userPhoneno;
	private String userZip;
	private String userAddr;
	private String userDaddr;
	private String regDt;
	private String userProfile;
	private String userPrvcYn;

	private MultipartFile profileFile;

}

