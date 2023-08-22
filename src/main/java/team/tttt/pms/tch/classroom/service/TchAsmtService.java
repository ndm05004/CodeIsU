package team.tttt.pms.tch.classroom.service;

import java.util.List;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.AtchFileVO;
import team.tttt.pms.tch.vo.AsmtVO;
import team.tttt.pms.tch.vo.QstDtlVO;
import team.tttt.pms.tch.vo.QstVO;
import team.tttt.pms.tch.vo.SbmsnResultVO;
import team.tttt.pms.tch.vo.SbmsnVO;

public interface TchAsmtService {

	public ServiceResult insertAsmt(AsmtVO asmtVO);

	public ServiceResult insertQst(QstVO qstVO, List<AtchFileVO> fileVOList);

	public ServiceResult insertQstDtl(QstDtlVO qstDtlVO);

	public List<AsmtVO> selectAsmtList(String sbjctCd);

	public ServiceResult deleteAsmt(int asmtNo);

	public AsmtVO selectAsmt(int asmtNo);

	public List<AtchFileVO> selectAtchFileList(int asmtNo);

	public List<SbmsnResultVO> selectSbmsnList(int asmtNo);

	public List<SbmsnVO> selectSbmsnResultList(String stuNo, int asmtNo);

//	public ServiceResult updateAsmt(AsmtVO asmtVO);

//	public ServiceResult updateQst(QstVO qstVO, List<AtchFileVO> fileVOList);

}
