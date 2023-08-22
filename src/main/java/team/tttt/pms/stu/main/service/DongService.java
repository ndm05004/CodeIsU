package team.tttt.pms.stu.main.service;

import team.tttt.pms.emp.vo.AttdVO;

public interface DongService {

	public AttdVO userCheck(AttdVO dataVO);
	public int insertAttd(AttdVO attdVO);
	public int inClass(AttdVO attdVO);
	public int outClass(AttdVO attdVO);
	public AttdVO searchAttd(AttdVO attdVO);
	public void attdOk(AttdVO attdVO);
	public void attdFail(AttdVO attdVO);
	public int inClassLate(AttdVO attdVO);
}
