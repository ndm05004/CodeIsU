package team.tttt.pms.emp.dscsn.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.emp.dscsn.mapper.DscsnMapper;
import team.tttt.pms.emp.dscsn.service.DscsnService;
import team.tttt.pms.emp.vo.ConsulReservationVO;
import team.tttt.pms.emp.vo.ConsultingRoomVO;
import team.tttt.pms.emp.vo.DscsnVO;
import team.tttt.pms.emp.vo.RejectVO;

@Service
public class DscsnServiceImpl implements DscsnService {

	@Inject
	private DscsnMapper dscsnMapper;

	@Override
	public List<DscsnVO> dscsnNoList(String userNo) {
		return dscsnMapper.dscsnNoList(userNo);
	}

	@Override
	public List<DscsnVO> dscsnApprovList(String userNo) {
		return dscsnMapper.dscsnApprovList(userNo);
	}

	@Override
	public List<DscsnVO> dscsnUnApprovList(String userNo) {
		return dscsnMapper.dscsnUnApprovList(userNo);
	}

	@Override
	public List<ConsultingRoomVO> consulList(ConsulReservationVO consulReservationVO) {
		return dscsnMapper.consulList(consulReservationVO);
	}

	@Override
	public int insertReservation(ConsulReservationVO consulReservationVO) {
		return dscsnMapper.insertReservation(consulReservationVO);
	}

	@Override
	public void approvalUpdate(DscsnVO dscsnVO) {
		dscsnMapper.approvalUpdate(dscsnVO);
	}

	@Override
	public int insertReject(RejectVO rejectVO) {
		return dscsnMapper.insertReject(rejectVO);
	}

	@Override
	public void unApprovalUpdate(int dscsnNo) {
		dscsnMapper.unApprovalUpdate(dscsnNo);
	}

	@Override
	public List<DscsnVO> myDscsnList(String stuName) {
		return dscsnMapper.myDscsnList(stuName);
	}

	@Override
	public int resultInsert(DscsnVO dscsnVO) {
		return dscsnMapper.resultInsert(dscsnVO);
	}

	@Override
	public String selectResult(int no) {
		return dscsnMapper.selectResult(no);
	}

	@Override
	public List<DscsnVO> allapprolist() {
		return dscsnMapper.allapprolist();
	}

	@Override
	public List<DscsnVO> dscsnClearList(String userNo) {
		return dscsnMapper.dscsnClearList(userNo);
	}

	@Override
	public String selectResume(String stuName) {
		return dscsnMapper.selectResume(stuName);
	}

	@Override
	public int noapprovdscsn(String userNo) {
		return dscsnMapper.noapprovdscsn(userNo);
	}

	@Override
	public int todaydscsn(String userNo) {
		return dscsnMapper.todaydscsn(userNo);
	}

	@Override
	public int tomorrowdscsn(String userNo) {
		return dscsnMapper.tomorrowdscsn(userNo);
	}

}
