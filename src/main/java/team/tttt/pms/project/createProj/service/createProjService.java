package team.tttt.pms.project.createProj.service;

import java.util.List;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.project.vo.MemJoinAplyVO;
import team.tttt.pms.project.vo.ProjVO;


public interface createProjService {

	public List<ProjVO> projList(ProjVO vo);

	public ServiceResult insertProj(ProjVO projVO);

	public ServiceResult insertAply(MemJoinAplyVO aplyVO);

	public ProjVO detail(String projNo);

	public List<ProjVO> aplyYn(String stuNo);




}
