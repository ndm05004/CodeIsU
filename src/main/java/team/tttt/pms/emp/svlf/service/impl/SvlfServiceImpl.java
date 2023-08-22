package team.tttt.pms.emp.svlf.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.common.vo.CmCdVO;
import team.tttt.pms.emp.svlf.mapper.SvlfMapper;
import team.tttt.pms.emp.svlf.service.SvlfService;
import team.tttt.pms.emp.vo.EmpVO;
import team.tttt.pms.emp.vo.LectureRoomVO;
import team.tttt.pms.emp.vo.SvlfVO;

@Service
public class SvlfServiceImpl implements SvlfService {

	@Inject
	private SvlfMapper svlfMapper;

	@Override
	public List<EmpVO> checkDepartCd() {
		return svlfMapper.checkDepartCd();
	}

	@Override
	public int svlfInsert(SvlfVO svlfVO) {
		return svlfMapper.svlfInsert(svlfVO);
	}

	@Override
	public List<SvlfVO> svlfList() {
		return svlfMapper.svlfList();
	}

	@Override
	public void lectureRoomUpdate(String classCode) {
		svlfMapper.lectureRoomUpdate(classCode);
	}

	@Override
	public SvlfVO svlfInfo(String svlfNo) {
		return svlfMapper.svlfInfo(svlfNo);
	}

	@Override
	public int svlfDel(String svlfNo) {
		return svlfMapper.svlfDel(svlfNo);
	}

	@Override
	public void lectureRoomUpdate2(String classCode) {
		svlfMapper.lectureRoomUpdate2(classCode);

	}

	@Override
	public List<LectureRoomVO> lectureRoomList() {
		return svlfMapper.lectureRoomList();
	}

	@Override
	public int svlfUPdate(SvlfVO svlfVO) {
		return svlfMapper.svlfUPdate(svlfVO);
	}

	@Override
	public List<SvlfVO> noSvlfList() {
		return svlfMapper.noSvlfList();
	}

	@Override
	public List<LectureRoomVO> roomList(SvlfVO svlfVO) {
		return svlfMapper.roomList(svlfVO);
	}

	@Override
	public List<EmpVO> teachList(SvlfVO svlfVO) {
		return svlfMapper.teachList(svlfVO);
	}

}
