package team.tttt.pms.tch.classroom.service;

import java.util.List;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.stu.vo.QstnVO;

public interface TchQstnService {

	public List<QstnVO> selectQstnList(String sbjctCd);

	public List<QstnVO> selectQstnListAnsNo(String sbjctCd);

	public List<QstnVO> selectQstnListAnsYes(String sbjctCd);

	public QstnVO selectQstn(int qstnNo);

	public ServiceResult insertAns(QstnVO qstnVO);

	public ServiceResult deleteAns(int qstnNo);

}
