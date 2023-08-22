package team.tttt.pms.stu.resume.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.stu.vo.ResAcbgInfoVO;
import team.tttt.pms.stu.vo.ResCareerInfoVO;
import team.tttt.pms.stu.vo.ResCrtfctInfoVO;
import team.tttt.pms.stu.vo.ResTechInfoVO;
import team.tttt.pms.stu.vo.ResumeVO;

@Mapper
public interface ResumeMapper {

	public int tbResumeInsert(ResumeVO resumeVO);

	public int tbAcbgInsert(ResAcbgInfoVO resAcbgInfoVO);

	public int tbCrtfctInsert(ResCrtfctInfoVO crtfctInfoVO);

	public int tbCareerInsert(ResCareerInfoVO careerInfoVO);

	public int tbTechInsert(ResTechInfoVO techInfoVO);

	// Resume 불러오기
	public ResumeVO selectResume(String resumeNo);
	public UserVO getUserInfo(String stuNo);
	public List<ResAcbgInfoVO> selectAcbgList(String resumeNo);
	public List<ResCrtfctInfoVO> selectCrtfctList(String resumeNo);
	public List<ResCareerInfoVO> selectCareerList(String resumeNo);
	public List<ResTechInfoVO> selectTechList(String resumeNo);

	// 본인 이력서리스트 조회
	public List<ResumeVO> selectResumeList(String userNo);

	// 대표이력서 설정 (모두 N -> 셀렉트만 Y);
	public int updateAllResMainN(String userNo);
	public int updateSelectResMainY(String resumeNo);




}
