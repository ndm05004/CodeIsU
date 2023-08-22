package team.tttt.pms.project.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.project.vo.MemJoinAplyVO;
import team.tttt.pms.project.vo.ProjVO;

@Mapper
public interface MainMapper {

	public List<ProjVO> pList(String stuNo);

	public List<MemJoinAplyVO> aplyList(String stuNo);

}
