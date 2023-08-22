package team.tttt.pms.stu.hakup.service;

import java.util.List;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.emp.vo.AttdVO;
import team.tttt.pms.stu.vo.AttdanVO;
import team.tttt.pms.stu.vo.StuVO;

public interface AttdanService {

	public StuVO selectStu(String userNo);

	public ServiceResult insertAttdan(AttdanVO attdanVO);

	public List<AttdanVO> selectAttdanList(String stuNo);

	public ServiceResult deleteAttdan(int attdanNo);

}
