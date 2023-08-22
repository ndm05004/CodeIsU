package team.tttt.pms.emp.sbjct.service;

import java.util.List;

import team.tttt.pms.emp.vo.EmpVO;
import team.tttt.pms.emp.vo.SbjctVO;
import team.tttt.pms.emp.vo.SvlfVO;
import team.tttt.pms.stu.vo.StuVO;

public interface SbjctService {

	public List<SvlfVO> svlfNmList();
	public List<EmpVO> empNmList();
	public List<SbjctVO> sbjctList();
	public int sbjctInsert(SbjctVO sbjctVO);
	public SvlfVO svlfTime(String svlfNo);
	public SbjctVO sbjctInfo(String sbjCd);
	public List<SbjctVO> sbjctListInfo(SbjctVO sbjctVO);
	public int sbjctUpdate(SbjctVO sbjctVO);
	public int sbjctDel(String sbjctCd);
	public List<SbjctVO> scduInfo(SbjctVO sbjctVO);
	public List<SbjctVO> sbjctListInfo2(SbjctVO sbjctVO);
	public List<SbjctVO> scduInfo2(SbjctVO sbjctVO);
	public List<StuVO> sbjctStuList(String sbjctCd);
	public List<SvlfVO> svlfList();
	public List<SbjctVO> resbjctlist(SbjctVO sbjctVO);

}
