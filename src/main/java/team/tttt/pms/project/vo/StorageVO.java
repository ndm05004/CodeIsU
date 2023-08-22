package team.tttt.pms.project.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import team.tttt.pms.common.vo.AtchFileVO;

@Setter
@Getter
@ToString
public class StorageVO {

	private String 				strNo;
	private String 				strTitle;
	private String 				strCn;
	private String 				stuNo;
	private String				strRegDt;
	private String 				atchFileNo;
	private String 				projNo;
	private int					strViews;

	private List<MultipartFile> fileList;

	private int 				rnum;
	private String				userNm;

	private List<AtchFileVO> 	atchFileList;

	private String[]			atchFileSeq;
	private String[] 			noInsertItem;
}
