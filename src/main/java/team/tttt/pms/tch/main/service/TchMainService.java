package team.tttt.pms.tch.main.service;

import java.util.List;

import team.tttt.pms.stu.vo.QstnVO;
import team.tttt.pms.tch.vo.TchVO;

public interface TchMainService {

	public List<TchVO> selectClassList(String userNo);

	public List<QstnVO> selectQntnAnsNoList(String userNo);

	public List<QstnVO> selectAsmtList(String userNo);

}
