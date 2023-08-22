package team.tttt.pms.stu.hakup.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.stu.hakup.mapper.CfroomRsvtMapper;
import team.tttt.pms.stu.hakup.service.CfroomRsvtService;
import team.tttt.pms.stu.vo.CfroomRsvtVO;
import team.tttt.pms.stu.vo.MettingRoomVO;

@Service
public class CfroomRsvtServiceImpl implements CfroomRsvtService {

	@Inject
	private CfroomRsvtMapper cfroomRsvtMapper;

	@Override
	public ServiceResult insertCfroomRsvt(CfroomRsvtVO cfroomRsvtVO) {
		int status = cfroomRsvtMapper.insertCfroomRsvt(cfroomRsvtVO);
		ServiceResult result;
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public List<CfroomRsvtVO> selectCfroomRsvtList(String rsvtDt) {
		return cfroomRsvtMapper.selectCfroomRsvtList(rsvtDt);
	}

	@Override
	public List<MettingRoomVO> selectMettingRoomList() {
		return cfroomRsvtMapper.selectMettingRoomList();
	}

	@Override
	public ServiceResult deleteCfroom(CfroomRsvtVO cfroomRsvtVO) {
		int status = cfroomRsvtMapper.deleteCfroom(cfroomRsvtVO);
		ServiceResult result;
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return null;
	}

}
