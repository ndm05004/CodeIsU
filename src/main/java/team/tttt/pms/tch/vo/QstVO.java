package team.tttt.pms.tch.vo;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import team.tttt.pms.common.vo.AtchFileVO;

@Getter
@Setter
@ToString
public class QstVO {
	private int qstNo;
	private String qstCn;
	private String atchFileNo;
	private String qstCode;
	private int asmtNo;
	private String qstAns;
	private char qstYn;
	private List<MultipartFile> fileList;
	private List<AtchFileVO> atchFileList;
	private List<QstDtlVO> qstDtlList;

	// atchFileNo의 변경여부
	// 학생 문제를 풀었으면 Y, 문제를 풀지 않았으면 null
	private char qstSbmsnYn;
}
