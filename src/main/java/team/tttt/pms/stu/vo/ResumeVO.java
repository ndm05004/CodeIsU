package team.tttt.pms.stu.vo;
import java.util.Date;
import java.util.List;

import lombok.Data;
import team.tttt.pms.common.vo.UserVO;

@Data
public class ResumeVO {

	private String resumeNo;
	private String stuNo;
	private String resumeNm;
	private String atchFileNo;
	private String highschNm;
	private String highschType;
	private String highschGrdtnYm;
	private String resumeIntroConn;
	private Date regDt;
	private String delYn;
	private String mainResumeYn;

	private UserVO userInfo;
	private List<ResAcbgInfoVO> acbgList;
	private List<ResCrtfctInfoVO> crtfctList;
	private List<ResCareerInfoVO> careerList;
	private List<ResTechInfoVO> techList;

	public void setHighschGrdtnYm(String highschGrdtnYm) {
		if(highschGrdtnYm.length() > 6) {
			this.highschGrdtnYm = highschGrdtnYm.replace("-", "");
		} else {
			this.highschGrdtnYm = highschGrdtnYm.substring(0, 4) + "-" + highschGrdtnYm.substring(4, 6);
		}

	}
}
