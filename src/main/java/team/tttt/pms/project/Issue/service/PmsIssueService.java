package team.tttt.pms.project.Issue.service;

import java.util.List;
import java.util.Map;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.project.vo.AlarmVO;
import team.tttt.pms.project.vo.CmntVO;
import team.tttt.pms.project.vo.IssueVO;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.PaginationInfoVO;
import team.tttt.pms.project.vo.ProjVO;

public interface PmsIssueService {

	public int selectBoardCount(PaginationInfoVO<IssueVO> pagingVO);

	public List<IssueVO> getIssueList(PaginationInfoVO<IssueVO> pagingVO);

	public ServiceResult insertIssue(IssueVO issueVO);

	public ServiceResult update(IssueVO issueVO);

	public ServiceResult del(IssueVO issueVO);

	public ServiceResult insertComment(CmntVO cmntVO);

	public CmntVO detailComment(String cmntNo);

	public ServiceResult updateCommnet(CmntVO cmntVO);

	public ServiceResult deleteCommnet(CmntVO cmntNo);

	public List<CmntVO> cmntDetail(CmntVO cmntVO);

	public List<UserVO> selectUserNoList(String projNo);

	public MemManagementVO getMemJbttlCd(Map<String, String> mjMap);

	public IssueVO Detail(IssueVO issueVO);

	public ProjVO getProjNm(String projNo);



}

