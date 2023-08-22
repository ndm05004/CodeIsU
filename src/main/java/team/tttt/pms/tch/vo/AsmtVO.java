package team.tttt.pms.tch.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AsmtVO {
    // 공통과제
    private int asmtNo;			// 과제번호
    private String asmtTtl;			// 제목
    private String asmtExpln;		// 설명
    private String asmtDdln;		// 제출기한
    private String empNo;			// 직원번호
    private String asmtDt;			// 과제생성일
    private String sbjctCd;			// 과목코드


    private List<QstVO> qstList;


    private int stuAllCnt;			// 과제를 풀어야하는 학생수 - 전체 학생
    private int stuSbmsnCnt;		// 과제를 푼 학생

    // 삭제된 asmtNo 번호
    private List deleteqstNoList;

    // 제출 완료. -> 제출 완료시 Y, 완료 삭제시 N 여부
    private char qstSbmsnYn;


}
