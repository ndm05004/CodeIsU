package team.tttt.pms.project.Issue.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.project.vo.AlarmVO;
import team.tttt.pms.project.vo.CmntVO;
import team.tttt.pms.project.vo.IssueVO;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.PaginationInfoVO;
import team.tttt.pms.project.vo.ProjVO;

@Mapper
public interface PmsIssueMapper {

	public int selectBoardCount(PaginationInfoVO<IssueVO> pagingVO);

	public List<IssueVO> getIssueList(PaginationInfoVO<IssueVO> pagingVO);

	public int insertIssue(IssueVO issueVO);

	public int update(IssueVO issueVO);

	public int del(IssueVO issueVO);

	public int insertComment(CmntVO cmntVO);

	public CmntVO detailComment(String cmntNo);

	public int updateCommnet(CmntVO cmntVO);

	public int deleteCommnet(CmntVO cmntNo);

	public List<CmntVO> cmntDetail(CmntVO cmntVO);

	public int insertAlarm(AlarmVO alarmVO);

	public List<UserVO> selectUserNoList(String projNo);

	public MemManagementVO getMemJbttlCd(Map<String, String> mjMap);

	public IssueVO Detail(IssueVO issueVO);

	public ProjVO getProjNm(String projNo);

	public List<AlarmVO> alarmList(String pNo);


}
