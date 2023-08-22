package team.tttt.pms.emp.dscsn.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.emp.vo.ConsulReservationVO;
import team.tttt.pms.emp.vo.ConsultingRoomVO;
import team.tttt.pms.emp.vo.DscsnVO;
import team.tttt.pms.emp.vo.RejectVO;

@Mapper
public interface DscsnMapper {

	public List<DscsnVO> dscsnNoList(String userNo);
	public List<DscsnVO> dscsnApprovList(String userNo);
	public List<DscsnVO> dscsnUnApprovList(String userNo);
	public List<ConsultingRoomVO> consulList(ConsulReservationVO consulReservationVO);
	public int insertReservation(ConsulReservationVO consulReservationVO);
	public void approvalUpdate(DscsnVO dscsnVO);
	public int insertReject(RejectVO rejectVO);
	public void unApprovalUpdate(int dscsnNo);
	public List<DscsnVO> myDscsnList(String stuName);
	public int resultInsert(DscsnVO dscsnVO);
	public String selectResult(int no);
	public List<DscsnVO> allapprolist();
	public List<DscsnVO> dscsnClearList(String userNo);
	public String selectResume(String stuName);
	public int noapprovdscsn(String userNo);
	public int todaydscsn(String userNo);
	public int tomorrowdscsn(String userNo);
}
