package team.tttt.pms.project.main.service;

import java.util.List;

import team.tttt.pms.project.vo.MemJoinAplyVO;
import team.tttt.pms.project.vo.ProjVO;

public interface MainService {


	public List<ProjVO> pList(String stuNo);

	public List<MemJoinAplyVO> aplyList(String stuNo);





}
