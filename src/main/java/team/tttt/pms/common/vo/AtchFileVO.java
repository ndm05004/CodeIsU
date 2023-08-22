package team.tttt.pms.common.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class AtchFileVO {

	private String 	atchFileNo;
	private String 	atchFileSeq;
	private String 	fileNm;
	private String 	fileExtn;
	private String 	fileRgtr;
	private String 	fileBengDt;
	private String 	filePath;
	private long 	fileSize;
	private String 	fileUpdRgtr;
	private String 	fileUpdDate;
    private String 	fileTbNm;
    private String 	fileThumb;

    private List<MultipartFile> fileList;
}
