package team.tttt.pms.tch.classroom.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.tch.vo.TchVO;

@Mapper
public interface ClassMainMapper {
	public List<TchVO> selectClassList(String userNo);
	public List<TchVO> selectLastClassList(String userNo);
}
