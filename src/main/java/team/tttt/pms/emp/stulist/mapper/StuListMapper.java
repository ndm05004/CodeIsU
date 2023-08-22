package team.tttt.pms.emp.stulist.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.emp.vo.SvlfVO;
import team.tttt.pms.stu.vo.StuVO;

@Mapper
public interface StuListMapper {

	public List<StuVO> getStuListAll();

	public List<SvlfVO> getSvlfAll();

	public int insertStuOne(StuVO stuVO);

}
