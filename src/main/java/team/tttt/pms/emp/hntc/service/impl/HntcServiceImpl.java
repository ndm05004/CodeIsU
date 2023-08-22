package team.tttt.pms.emp.hntc.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.emp.hntc.mapper.HntcMapper;
import team.tttt.pms.emp.hntc.service.HntcService;
import team.tttt.pms.emp.vo.HntcVO;
import team.tttt.pms.project.vo.PaginationInfoVO;

@Service
public class HntcServiceImpl implements HntcService {

	@Inject
	private HntcMapper hntcMapper;

	@Override
	public int hntcInsert(HntcVO hntcVo) {
		return hntcMapper.hntcInsert(hntcVo);
	}

	@Override
	public HntcVO detailHntc(String boNo) {
		return hntcMapper.detailHntc(boNo);
	}

	@Override
	public int hntcDel(String boNo) {
		return hntcMapper.hntcDel(boNo);
	}

	@Override
	public int updateHntc(HntcVO hntcVO) {
		return hntcMapper.updateHntc(hntcVO);
	}

	@Override
	public void hntcCheckNoUp(String bono) {
		hntcMapper.hntcCheckNoUp(bono);
	}

	@Override
	public List<HntcVO> selectHntc(PaginationInfoVO<HntcVO> pagingVO) {
		return hntcMapper.selectHntc(pagingVO);
	}

	@Override
	public int selectBoardCount(PaginationInfoVO<HntcVO> pagingVO) {
		return hntcMapper.selectBoardCount(pagingVO);
	}

	@Override
	public List<HntcVO> hntcList() {
		return hntcMapper.hntcList();
	}

	@Override
	public HntcVO detailHntc2(String bono) {
		return hntcMapper.detailHntc2(bono);
	}

	@Override
	public void hntcCheckNoUp2(String bono) {
		hntcMapper.hntcCheckNoUp2(bono);

	}

}
