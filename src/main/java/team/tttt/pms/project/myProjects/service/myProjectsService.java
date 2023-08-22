package team.tttt.pms.project.myProjects.service;



import java.util.List;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.project.vo.ProjVO;

public interface myProjectsService {

	public List<ProjVO> myProjList(ProjVO vo);

	public List<ProjVO> ready(String stuNo);

	public ServiceResult delMyProj(ProjVO projVO);


}
