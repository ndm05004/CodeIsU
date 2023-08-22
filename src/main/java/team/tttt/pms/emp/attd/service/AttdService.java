package team.tttt.pms.emp.attd.service;

import java.util.List;

import team.tttt.pms.emp.vo.AttdVO;
import team.tttt.pms.emp.vo.SvlfVO;

public interface AttdService {

	public List<SvlfVO> findSvlfList(String dateInfo);
	public List<AttdVO> stuList(AttdVO attdVO);
	public int attdStatusUp(AttdVO attdVO);
}
