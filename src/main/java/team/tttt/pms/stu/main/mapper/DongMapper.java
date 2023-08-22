package team.tttt.pms.stu.main.mapper;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.emp.vo.AttdVO;

@Mapper
public interface DongMapper {

	public AttdVO userCheck(AttdVO dataVO);
	public int insertAttd(AttdVO attdVO);
	public int inClass(AttdVO attdVO);
	public int outClass(AttdVO attdVO);
	public AttdVO searchAttd(AttdVO attdVO);
	public void attdOk(AttdVO attdVO);
	public void attdFail(AttdVO attdVO);
	public int inClassLate(AttdVO attdVO);
}
