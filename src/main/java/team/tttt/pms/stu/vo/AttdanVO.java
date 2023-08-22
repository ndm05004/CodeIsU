package team.tttt.pms.stu.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AttdanVO {
    private int attdanNo;
    private String stuNo;
    private String attdanDt;
    private String attdanBgng;
    private String attdanDdlb;
    private String attdanCd;
    private String attdanApproval;
    private String attdanWriteDt;
    private String attdanCn;

    private String userNm;
    private String cdNm;
}
