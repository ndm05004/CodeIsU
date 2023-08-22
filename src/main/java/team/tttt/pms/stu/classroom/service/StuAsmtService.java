package team.tttt.pms.stu.classroom.service;

import java.util.List;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.AtchFileVO;
import team.tttt.pms.tch.vo.AsmtVO;
import team.tttt.pms.tch.vo.QstAnswerVO;
import team.tttt.pms.tch.vo.SbmsnVO;

public interface StuAsmtService {

	public List<AsmtVO> selectAsmtList(String sbjctCd, String userNo);

	public AsmtVO selectAmst(int asmtNo);

	public List<AtchFileVO> selectAtchFileList(int asmtNo);

	public ServiceResult insertSbmsn(List<QstAnswerVO> astAnswerList, String userNo, String sbjctCd);

	public List<SbmsnVO> selectSbmsnList(String userNo, int asmtNo);

}
