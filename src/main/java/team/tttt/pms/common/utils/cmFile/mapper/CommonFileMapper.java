package team.tttt.pms.common.utils.cmFile.mapper;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.common.vo.AtchFileVO;

@Mapper
public interface CommonFileMapper {

	int fileUpload(AtchFileVO atchFileVO);

	int fileDelete(String atchFileNo);

	int fileUUpload(AtchFileVO atchFileVO);

	int fileUDelete(String atchFileSeq);

}
