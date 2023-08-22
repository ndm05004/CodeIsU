package team.tttt.pms.stu.hakup.service;

import java.util.List;
import java.util.Map;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.emp.vo.DscsnVO;
import team.tttt.pms.emp.vo.EmpVO;

public interface StuConsulService {

	public List<EmpVO> selectEmpList(String stuNo);

	public ServiceResult insertConsul(DscsnVO dscsnVO);

	public Map<String,Object> selectConsulMap(String stuNo);

	public ServiceResult deleteDscsn(int dscsnNo);

}
