package team.tttt.pms.stu.vo;

import lombok.Data;

@Data
public class ResCrtfctInfoVO {
	private String crtfctNo;
	private String resumeNo;
	private String crtfctNm;
	private String issuInstNm;
	private String crtfctDt;



	public void setCrtfctDt(String crtfctDt) {
		if(crtfctDt.length() > 8) {
			this.crtfctDt = crtfctDt.replace("-", "");
		} else {
			this.crtfctDt = crtfctDt.substring(0, 4) + "-" + crtfctDt.substring(4, 6)+ "-" + crtfctDt.substring(6, 8);
		}
	}

}
