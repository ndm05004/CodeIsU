package team.tttt.pms.stu.vo;

import lombok.Data;

@Data
public class ResCareerInfoVO {
	private String careerNo;
	private String resumeNo;
	private String coNm;
	private String jncmpYm;
	private String rsgntnYm;
	private String deptNm;
	private String jbgdNm;
	private String hdofYn;


	public void setJncmpYm(String jncmpYm) {
		if(jncmpYm.length() > 6) {
			this.jncmpYm = jncmpYm.replace("-", "");
		} else {
			this.jncmpYm = jncmpYm.substring(0, 4) + "-" + jncmpYm.substring(4, 6);
		}
	}

	public void setRsgntnYm(String rsgntnYm) {
		if(rsgntnYm.length() > 6) {
			this.rsgntnYm = rsgntnYm.replace("-", "");
		} else {
			this.rsgntnYm = rsgntnYm.substring(0, 4) + "-" + rsgntnYm.substring(4, 6);
		}
	}


}
