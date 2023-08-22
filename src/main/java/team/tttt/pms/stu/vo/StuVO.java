package team.tttt.pms.stu.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import team.tttt.pms.emp.vo.LectureRoomVO;
import team.tttt.pms.emp.vo.SvlfVO;

@Getter
@Setter
@ToString
public class StuVO {
	private String stuNo;
	private String userNm;
	private String svlfNo;
	private String userEmlAddr;
	private String userPhoneno;
	private String userZip;
	private String userAddr;
	private String userDaddr;
	private Date regDt;
	private String fnshDt;
	private String fnshYn;
	private String abdYn;
	private Date joinDt;
	private String userProfile;
	private String userPrvcYn;
	private String userBrdt;
	private String userGender;
    private SvlfVO svlfVO;
    private LectureRoomVO lectureRoomVO;

    private String insertSuccess; // 엑셀 insert시 사용

    private String userPswd; // 회원정보 변경시 사용
}
