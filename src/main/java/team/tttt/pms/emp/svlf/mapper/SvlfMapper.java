package team.tttt.pms.emp.svlf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.common.vo.CmCdVO;
import team.tttt.pms.emp.vo.EmpVO;
import team.tttt.pms.emp.vo.LectureRoomVO;
import team.tttt.pms.emp.vo.SvlfVO;

@Mapper
public interface SvlfMapper {

	public List<EmpVO> checkDepartCd();
	public int svlfInsert(SvlfVO svlfVO);
	public List<SvlfVO> svlfList();
	public void lectureRoomUpdate(String classCode);
	public SvlfVO svlfInfo(String svlfNo);
	public int svlfDel(String svlfNo);
	public void lectureRoomUpdate2(String classCode);
	public List<LectureRoomVO> lectureRoomList();
	public int svlfUPdate(SvlfVO svlfVO);
	public List<SvlfVO> noSvlfList();
	public List<LectureRoomVO> roomList(SvlfVO svlfVO);
	public List<EmpVO> teachList(SvlfVO svlfVO);

}
