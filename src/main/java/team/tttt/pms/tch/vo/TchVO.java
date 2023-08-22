package team.tttt.pms.tch.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TchVO {
	// 강의실
    private String lectureRoomCd; // 강의실 코드
    private String lectureRoomNm; // 강의실 이름

    // 수업
    private String sbjctCd;
    private String sbjctNm;
    private String sbjctBgng;
    private String sbjctDdlb;
    private String scduHr;        // 시간대
    private String empNo;         // 직원번호
    private String userNm;         // 직원번호
    private String svlfNo;        // 연수과정번호

    private String userProfile;
}
