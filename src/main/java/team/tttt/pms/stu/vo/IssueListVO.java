package team.tttt.pms.stu.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import team.tttt.pms.project.vo.AlarmVO;
import team.tttt.pms.project.vo.CmntVO;
import team.tttt.pms.project.vo.MemManagementVO;

@Getter
@Setter
@ToString
public class IssueListVO {
	private String issueNo;
	private String issueCn;
	private String issueSttsCd;
	private String issueTtl;
	private String issueCd;
	private String issueRegDt;
	private String stuNo;
	private String projNo;
	private int rnum;
	private String userNm;
	private String issueAsg;
	private List<CmntVO> cmntVoList;
	private List<MemManagementVO> manageVoList;
	private List<AlarmVO> alarmVoList;
}
