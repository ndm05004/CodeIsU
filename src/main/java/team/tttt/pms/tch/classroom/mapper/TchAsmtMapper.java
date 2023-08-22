package team.tttt.pms.tch.classroom.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import team.tttt.pms.common.vo.AtchFileVO;
import team.tttt.pms.tch.vo.AsmtVO;
import team.tttt.pms.tch.vo.QstDtlVO;
import team.tttt.pms.tch.vo.QstVO;
import team.tttt.pms.tch.vo.SbmsnResultVO;
import team.tttt.pms.tch.vo.SbmsnVO;

@Mapper
public interface TchAsmtMapper {

	public int insertAsmt(AsmtVO asmtVO);

	public int insertQst(QstVO qstVO);

	public int insertQstDtl(QstDtlVO qstDtlVO);

	public List<AsmtVO> selectAsmtList(String sbjctCd);

	public int deleteAsmt(int asmtNo);

	public AsmtVO selectAsmt(int asmtNo);

	public List<AtchFileVO> selectAtchFileList(int asmtNo);

	public List<SbmsnResultVO> selectSbmsnList(int asmtNo);

	public List<SbmsnVO> selectSbmsnResultList(@Param("userNo") String userNo, @Param("asmtNo") int asmtNo);


}
