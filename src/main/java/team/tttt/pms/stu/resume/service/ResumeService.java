package team.tttt.pms.stu.resume.service;

import java.util.List;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.stu.vo.ResumeVO;

public interface ResumeService {

	ServiceResult resumeInsert(ResumeVO resumeVO);

	ResumeVO resumeView(String resumeNo);

	List<ResumeVO> selectResumeList(String userNo);

	ServiceResult mainResSet(String userNo, String resumeNo);


}
