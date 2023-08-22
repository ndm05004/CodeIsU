package team.tttt.pms.stu.hakup.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.emp.vo.DscsnVO;
import team.tttt.pms.emp.vo.EmpVO;

@Mapper
public interface StuConsulMapper {

	public int insertConsul(DscsnVO dscsnVO);

	public List<DscsnVO> selectConsulNoList(String stuNo);

	public List<DscsnVO> selectConsulApprovList(String stuNo);

	public List<DscsnVO> selectConsulUnApprovList(String stuNo);

	public int deleteDscsn(int dscsnNo);

	public List<EmpVO> selectEmpList(String stuNo);

}
