package team.tttt.pms.emp.vo;

import org.springframework.stereotype.Service;

import lombok.Getter;
import lombok.ToString;

@Getter
@Service
@ToString
public class RejectVO {

    private int dscsnNo;
	private String rejectCn;
}
