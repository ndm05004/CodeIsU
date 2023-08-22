package team.tttt.pms.tch.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SbmsnVO {
	private int qstSbmsnNo;
	private String qstSbmsnAns;
	private String qstSbmsnDt;
	private String stuNo;
	private String sbjctCd;
	private int asmtNo;
	private int qstNo;
	private char qstSbmsnYn;

	private List<QstAnswerVO> qstAnswerList;
}
