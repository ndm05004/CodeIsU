package team.tttt.pms.emp.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EmpVO {

	private String empNo;
	private String userNm;
	private String userEmlAddr;
	private String userPhoneno;
	private String userZip;
	private String userAddr;
	private String userDaddr;
	private Date regDt;
	private Date joinDt;
	private Date delDt;
	private String departCd;
	private String userProfile;
	private char userPvrcYn;

}

/*
empNo
userNm
userEmlAddr
userPhoneno
userZip
userAddr
userDaddr
regDt
joinDt
delDt
departCd
userProfile
userPvrcYn*/