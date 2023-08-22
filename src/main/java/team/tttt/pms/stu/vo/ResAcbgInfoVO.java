package team.tttt.pms.stu.vo;

import lombok.Data;

@Data
public class ResAcbgInfoVO {
	private String acbgNo;
	private String resumeNo;
	private String schlSeCd;
	private String schlNm;
	private String departNm;
	private String mtcltnYm;
	private String grdtnYm;
	private String grdtnState;
	private String schlCredit;

	private String userCredit;
	private String baseCredit;




	public void setSchlCredit(String schlCredit) {
		this.schlCredit = schlCredit;
		String[] credit = this.schlCredit.split("/");
		this.userCredit = credit[0];
		this.baseCredit = credit[1];
	}


	// 날짜형식 변경
	public void setMtcltnYm(String mtcltnYm) {

		if(mtcltnYm.length() > 6) {
			this.mtcltnYm = mtcltnYm.replace("-", "");
		} else {
			this.mtcltnYm = mtcltnYm.substring(0, 4) + "-" + mtcltnYm.substring(4, 6);
		}
	}

	public void setGrdtnYm(String grdtnYm) {
		if(grdtnYm.length() > 6) {
			this.grdtnYm = grdtnYm.replace("-", "");
		} else {
			this.grdtnYm = grdtnYm.substring(0, 4) + "-" + grdtnYm.substring(4, 6);
		}
	}



}
