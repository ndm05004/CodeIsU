package team.tttt.pms.project.Issue.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.project.Issue.mapper.PmsIssueMapper;
import team.tttt.pms.project.Issue.service.PmsIssueService;
import team.tttt.pms.project.vo.AlarmVO;
import team.tttt.pms.project.vo.CmntVO;
import team.tttt.pms.project.vo.IssueVO;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.PaginationInfoVO;
import team.tttt.pms.project.vo.ProjVO;

@Service
public class PmsIssueServiceImpl implements PmsIssueService {

	@Inject
	private PmsIssueMapper mapper;

	@Override
	public int selectBoardCount(PaginationInfoVO<IssueVO> pagingVO) {
		return mapper.selectBoardCount(pagingVO);
	}

	@Override
	public List<IssueVO> getIssueList(PaginationInfoVO<IssueVO> pagingVO) {
		// TODO Auto-generated method stub
		return mapper.getIssueList(pagingVO);
	}

	@Override
	public ServiceResult insertIssue(IssueVO issueVO) {

		int cnt = mapper.insertIssue(issueVO);

		/*
		 * AlarmVO alarmVO = new AlarmVO(); alarmVO.setStuNo(issueVO.getStuNo());
		 * alarmVO.setProjNo(issueVO.getProjNo());
		 * alarmVO.setIssueTtl(issueVO.getIssueCn());
		 * alarmVO.setIssueCd(issueVO.getIssueCd());
		 *
		 * cnt += mapper.insertAlarm(alarmVO);
		 */
		if(cnt > 0) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAILED;
		}
	}

	@Override
	public ServiceResult update(IssueVO issueVO) {
		int cnt = mapper.update(issueVO);

		if(cnt > 0) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAILED;
		}

	}

	@Override
	public ServiceResult del(IssueVO issueVO) {
		int cnt = mapper.del(issueVO);

		if(cnt > 0 ) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAILED;
		}

	}

	@Override
	public ServiceResult insertComment(CmntVO cmntVO) {

		int cnt = mapper.insertComment(cmntVO);

		if(cnt > 0 ) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAILED;
		}

	}

	@Override
	public CmntVO detailComment(String cmntNo) {
		return mapper.detailComment(cmntNo);
	}

	@Override
	public ServiceResult updateCommnet(CmntVO cmntVO) {
		int cnt = mapper.updateCommnet(cmntVO);

		if(cnt > 0) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAILED;
		}
	}

	@Override
	public ServiceResult deleteCommnet(CmntVO cmntNo) {

		int cnt = mapper.deleteCommnet(cmntNo);

		if(cnt > 0) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAILED;
		}
	}

	@Override
	public List<CmntVO> cmntDetail(CmntVO cmntVO) {
		return mapper.cmntDetail(cmntVO);
	}

	@Override
	public List<UserVO> selectUserNoList(String projNo) {
		// TODO Auto-generated method stub
		return mapper.selectUserNoList(projNo);
	}

	@Override
	public MemManagementVO getMemJbttlCd(Map<String, String> mjMap) {
		return mapper.getMemJbttlCd(mjMap);
	}

	@Override
	public IssueVO Detail(IssueVO issueVO) {
		return mapper.Detail(issueVO);
	}

	@Override
	public ProjVO getProjNm(String projNo) {
		return mapper.getProjNm(projNo);
	}

	/*
	 * @Override public List<AlarmVO> alarmList(String pNo) { return
	 * mapper.alarmList(pNo); }
	 */

}