package team.tttt.pms.tch.classroom.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.common.vo.AtchFileVO;

@Mapper
public interface TchStorageMapper {

	public List<AtchFileVO> selectStorageList(String sbjctCd);

	public int insertStorage(AtchFileVO myAtchFile);

	public int deleteStorage(AtchFileVO atchFileVO);

}
