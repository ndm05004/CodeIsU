package team.tttt.pms.stu.classroom.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import team.tttt.pms.common.vo.AtchFileVO;
import team.tttt.pms.tch.vo.AsmtVO;
import team.tttt.pms.tch.vo.SbmsnVO;

@Mapper
public interface StuAsmtMapper {

	public List<AsmtVO> selectAsmtList(@Param("sbjctCd") String sbjctCd,@Param("userNo") String userNo);

	public AsmtVO selectAmst(int asmtNo);

	public List<AtchFileVO> selectAtchFileList(int asmtNo);

	public int insertSbmsn(SbmsnVO sbmsnVO);

	public List<SbmsnVO> selectSbmsnList(@Param("userNo") String userNo , @Param("asmtNo") int asmtNo);

}
