package team.tttt.pms.project.myProjects.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.project.vo.ProjVO;

@Mapper
public interface myProjectsMapper {

	public List<ProjVO> myProjList(ProjVO vo);

	public List<ProjVO> ready(String stuNo);

	public int delMyProj(ProjVO projVO);


}
