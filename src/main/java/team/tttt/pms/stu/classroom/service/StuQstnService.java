package team.tttt.pms.stu.classroom.service;

import java.util.List;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.stu.vo.QstnVO;
import team.tttt.pms.tch.vo.TchVO;

public interface StuQstnService {

	public List<QstnVO> selectQstnList(QstnVO qstnVO);

	public ServiceResult insertQstn(QstnVO qstnVO);

	public QstnVO selectQstn(int qstnNo);

	public TchVO selectTch(String sbjctCd);

	public ServiceResult updateQstn(QstnVO qstnVO);

	public ServiceResult deleteQstn(int qstnNo);


}
