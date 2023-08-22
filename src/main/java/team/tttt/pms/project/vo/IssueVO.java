package team.tttt.pms.project.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class IssueVO {
	private String issueNo;
	private String issueCn;
	private String issueSttsCd;
	private String issueTtl;
	private String issueCd;
	private String issueRegDt;
	private String stuNo;
	private String projNo;
	private String projNm;
	private int rnum;
	private String userNm;
	private String issueAsg;
	private List<CmntVO> cmntVoList;
	private List<MemManagementVO> manageVoList;
	private List<AlarmVO> alarmVoList;
}
