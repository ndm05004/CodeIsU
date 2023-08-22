package team.tttt.pms.project.createProj.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.project.vo.MemJoinAplyVO;
import team.tttt.pms.project.vo.ProjVO;

@Mapper
public interface CreateProjMapper {

	public List<ProjVO> projList(ProjVO vo);

	public int insertProj(ProjVO projVO);

	public int insertAply(MemJoinAplyVO aplyVO);

	public int insertPL(String stuNo);

	public ProjVO detail(String projNo);

	public List<ProjVO> aplyYn(String stuNo);



}
