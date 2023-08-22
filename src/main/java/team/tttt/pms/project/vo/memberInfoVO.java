package team.tttt.pms.project.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class memberInfoVO {
	private String	stuNo;
	private String	userNm;
	private String	userEmlAddr;
	private String	userPhoneno;
	private String	projNo;
	private String	teamJoinDt;
	private String	jbttlCd;
	private String	userBrdt;

	private String 	userProfile;
	private String 	userGender;
	private int 	complete;
	private int 	progress;
}
