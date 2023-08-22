package team.tttt.pms.stu.hakup.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.emp.vo.DscsnVO;
import team.tttt.pms.emp.vo.EmpVO;
import team.tttt.pms.stu.hakup.mapper.StuConsulMapper;
import team.tttt.pms.stu.hakup.service.StuConsulService;

@Service
public class StuConsulServiceImpl implements StuConsulService{
	@Inject
	private StuConsulMapper stuConsulMapper;

	@Override
	public List<EmpVO> selectEmpList(String stuNo) {
		return stuConsulMapper.selectEmpList(stuNo);
	}

	@Override
	public ServiceResult insertConsul(DscsnVO dscsnVO) {
		int status = stuConsulMapper.insertConsul(dscsnVO);
		if(status > 0) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAILED;
		}
	}

	@Override
	public Map<String, Object> selectConsulMap(String stuNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 미승인
		List<DscsnVO> consulNoList = stuConsulMapper.selectConsulNoList(stuNo);
		// 승인
		List<DscsnVO> consulApprovList = stuConsulMapper.selectConsulApprovList(stuNo);
		// 반려
		List<DscsnVO> consulUnApprovList = stuConsulMapper.selectConsulUnApprovList(stuNo);
		map.put("consulNoList", consulNoList);
		map.put("consulApprovList", consulApprovList);
		map.put("consulUnApprovList", consulUnApprovList);
		return map;
	}

	@Override
	public ServiceResult deleteDscsn(int dscsnNo) {
		int status = stuConsulMapper.deleteDscsn(dscsnNo);
		if(status > 0) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAILED;
		}
	}
}
