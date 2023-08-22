package team.tttt.pms.stu.hakup.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.stu.hakup.mapper.AttdanMapper;
import team.tttt.pms.stu.hakup.mapper.CfroomRsvtMapper;
import team.tttt.pms.stu.hakup.service.AttdanService;
import team.tttt.pms.stu.vo.AttdanVO;
import team.tttt.pms.stu.vo.StuVO;

@Service
public class AttdanServiceImpl implements AttdanService{
	@Inject
	private AttdanMapper attdanMapper;

	@Override
	public StuVO selectStu(String userNo) {
		return attdanMapper.selectStu(userNo);
	}

	@Override
	public ServiceResult insertAttdan(AttdanVO attdanVO) {
		int status = attdanMapper.insertAttdan(attdanVO);
		ServiceResult result;
		if(status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public List<AttdanVO> selectAttdanList(String stuNo) {
		return attdanMapper.selectAttdanList(stuNo);
	}

	@Override
	public ServiceResult deleteAttdan(int attdanNo) {
		int status = attdanMapper.deleteAttdan(attdanNo);
		ServiceResult result;
		if(status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}
}
