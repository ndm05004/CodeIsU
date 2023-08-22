package team.tttt.pms.stu.classroom.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.common.vo.AtchFileVO;

@Mapper
public interface StuStorageMapper {

	public List<AtchFileVO> selectStorageList(String sbjctCd);

}
