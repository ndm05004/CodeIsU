package team.tttt.pms.tch.damdang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.stu.vo.StuVO;

@Mapper
public interface TchStuListMapper {

	public List<StuVO> selectStuList(String userNo);

}
