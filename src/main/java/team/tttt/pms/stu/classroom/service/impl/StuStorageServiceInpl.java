package team.tttt.pms.stu.classroom.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;

import team.tttt.pms.common.vo.AtchFileVO;
import team.tttt.pms.stu.classroom.mapper.StuStorageMapper;
import team.tttt.pms.stu.classroom.service.StuStorageService;

@Controller
public class StuStorageServiceInpl implements StuStorageService{
	@Inject
	private StuStorageMapper stuStorageMapper;

	@Override
	public List<AtchFileVO> selectStorageList(String sbjctCd) {
		return stuStorageMapper.selectStorageList(sbjctCd);
	}

}
