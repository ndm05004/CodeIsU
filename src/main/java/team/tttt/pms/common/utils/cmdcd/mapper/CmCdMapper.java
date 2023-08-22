package team.tttt.pms.common.utils.cmdcd.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.common.vo.CmCdVO;

@Mapper
public interface CmCdMapper {

	List<CmCdVO> selectCode(String cdTypeId);

	List<CmCdVO> readCMCdoe(String cdTypeId);

}
