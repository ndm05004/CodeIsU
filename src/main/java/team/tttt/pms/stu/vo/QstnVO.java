package team.tttt.pms.stu.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class QstnVO {
	private String sbjctCd;
    private int qstnNo;
    private String qstnTtl;
    private String qstnCn;
    private String qstnDt;
    private String qstnAns;
    private String qstnAnsDt;
    private String empNo;
    private String stuNo;
    private String userNm;
    private String stuNm;
    private String empNm;

    // 프로필 경로
    private String stuProfile;
    private String empProfile;
}
