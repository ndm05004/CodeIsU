package team.tttt.pms.emp.attd.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.emp.vo.AttdVO;
import team.tttt.pms.emp.vo.SvlfVO;

@Mapper
public interface AttdMapper {

	public List<SvlfVO> findSvlfList(String dateInfo);
	public List<AttdVO> stuList(AttdVO attdVO);
	public int attdStatusUp(AttdVO attdVO);
}
