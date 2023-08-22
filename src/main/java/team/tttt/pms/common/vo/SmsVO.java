package team.tttt.pms.common.vo;

import java.util.Date;

import lombok.Data;

@Data
public class SmsVO {
	private String smsNo;
	private String smsCn;
	private String smsRcvr;
	private Date sndngDt;
	private String userNm;
}
