package team.tttt.pms.project.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CmntVO {
	private String cmntNo;
	private String cmntCn;
	private String cmntBengDt;
	private String issueNo;
	private String stuNo;
	private String projNo;
	private String userNm;
	private String jbttlCd;
	private List<MemManagementVO> manageVoList;
}
