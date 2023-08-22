package team.tttt.pms.emp.kalleave.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.emp.vo.AttdVO;
import team.tttt.pms.stu.vo.AttdanVO;

@Mapper
public interface KalleaveMapper {

	public List<AttdanVO> attdanAllList();
	public List<AttdanVO> attdanapproval();
	public List<AttdanVO> attdanunapproved();
	public int approvalUpdate(AttdanVO attdanVO);
	public int selectattd(AttdVO attdVO);
	public int inattd(AttdVO attdVO);
	public int upattd(AttdVO attdVO);
	public int inoutattd(AttdVO attdVO);
	public int upinoutattd(AttdVO attdVO);
}
