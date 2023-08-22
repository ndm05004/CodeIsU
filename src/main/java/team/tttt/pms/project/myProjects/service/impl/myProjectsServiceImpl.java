package team.tttt.pms.project.myProjects.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.project.myProjects.mapper.myProjectsMapper;
import team.tttt.pms.project.myProjects.service.myProjectsService;
import team.tttt.pms.project.vo.ProjVO;

@Service
public class myProjectsServiceImpl implements myProjectsService{

	@Inject
	private myProjectsMapper myprojectsMapper;

	@Override
	public List<ProjVO> myProjList(ProjVO vo) {
		return myprojectsMapper.myProjList(vo);
	}

	@Override
	public List<ProjVO> ready(String stuNo) {
		return myprojectsMapper.ready(stuNo);
	}

	@Override
	public ServiceResult delMyProj(ProjVO projVO) {

		int cnt = myprojectsMapper.delMyProj(projVO);

		if(cnt > 0) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAILED;
		}

	}


}
