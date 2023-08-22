package team.tttt.pms.stu.resume.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.stu.resume.mapper.ResumeMapper;
import team.tttt.pms.stu.resume.service.ResumeService;
import team.tttt.pms.stu.vo.ResAcbgInfoVO;
import team.tttt.pms.stu.vo.ResCareerInfoVO;
import team.tttt.pms.stu.vo.ResCrtfctInfoVO;
import team.tttt.pms.stu.vo.ResTechInfoVO;
import team.tttt.pms.stu.vo.ResumeVO;

@Service
@EnableAspectJAutoProxy
public class ResumeServiceImpl implements ResumeService{

	@Inject
	private ResumeMapper mapper;

	@Override
	@Transactional
	public ServiceResult resumeInsert(ResumeVO resumeVO) {

		int cnt = mapper.tbResumeInsert(resumeVO);

		{
			List<ResAcbgInfoVO> acbgList = resumeVO.getAcbgList();
			int seqNo = 1;
			for (ResAcbgInfoVO resAcbgInfoVO : acbgList) {
				if(!(resAcbgInfoVO.getGrdtnYm() == null)) {
					resAcbgInfoVO.setResumeNo(resumeVO.getResumeNo());
					resAcbgInfoVO.setAcbgNo(seqNo+"");
					int cntAcbg = mapper.tbAcbgInsert(resAcbgInfoVO);
					seqNo++;
				}
			}
		}

		{
			List<ResCrtfctInfoVO> crtfctList = resumeVO.getCrtfctList();
			int seqNo = 1;
			for (ResCrtfctInfoVO crtfctInfoVO : crtfctList) {
				if(!(crtfctInfoVO.getCrtfctNm() == null)) {
					crtfctInfoVO.setResumeNo(resumeVO.getResumeNo());
					crtfctInfoVO.setCrtfctNo(seqNo+"");
					int cntAcbg = mapper.tbCrtfctInsert(crtfctInfoVO);
					seqNo++;
				}
			}
		}

		{
			List<ResCareerInfoVO> careerList = resumeVO.getCareerList();
			int seqNo = 1;
			for (ResCareerInfoVO careerInfoVO : careerList) {
				if(!(careerInfoVO.getDeptNm() == null)) {
					careerInfoVO.setResumeNo(resumeVO.getResumeNo());
					careerInfoVO.setCareerNo(seqNo+"");
					int cntAcbg = mapper.tbCareerInsert(careerInfoVO);
					seqNo++;
				}
			}
		}

		{
			List<ResTechInfoVO> techList= resumeVO.getTechList();
			int seqNo = 1;
			for (ResTechInfoVO techInfoVO : techList) {
				if(!(techInfoVO.getTechNm() == null)) {
					techInfoVO.setResumeNo(resumeVO.getResumeNo());
					techInfoVO.setTechNo(seqNo+"");
					int cntAcbg = mapper.tbTechInsert(techInfoVO);
					seqNo++;
				}
			}
		}


		ServiceResult result = ServiceResult.FAILED;

		if(cnt>0) {
			result = ServiceResult.OK;
		}

		return result;
	}

	@Override
	public ResumeVO resumeView(String resumeNo) {

		ResumeVO resumeVO = mapper.selectResume(resumeNo);

		List<ResAcbgInfoVO> acbgList = mapper.selectAcbgList(resumeNo);
		List<ResCrtfctInfoVO> crtfctList  = mapper.selectCrtfctList(resumeNo);
		List<ResCareerInfoVO> careerList  = mapper.selectCareerList(resumeNo);
		List<ResTechInfoVO> techList  = mapper.selectTechList(resumeNo);

		UserVO userInfo = mapper.getUserInfo(resumeVO.getStuNo());

		resumeVO.setUserInfo(userInfo);
		resumeVO.setAcbgList(acbgList);
		resumeVO.setCrtfctList(crtfctList);
		resumeVO.setCareerList(careerList);
		resumeVO.setTechList(techList);

		return resumeVO;
	}

	@Override
	public List<ResumeVO> selectResumeList(String userNo) {

		return mapper.selectResumeList(userNo);
	}

	@Override
	public ServiceResult mainResSet(String userNo, String resumeNo) {

		int cntAllN = mapper.updateAllResMainN(userNo);
		int cntMainY = mapper.updateSelectResMainY(resumeNo);

		if(cntAllN > 0 && cntMainY == 1) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAILED;
		}

	}


}
