package team.tttt.pms.tch.classroom.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.stu.vo.QstnVO;

@Mapper
public interface TchQstnMapper {

	public List<QstnVO> selectQstnList(String sbjctCd);

	public List<QstnVO> selectQstnListAnsNo(String sbjctCd);

	public List<QstnVO> selectQstnListAnsYes(String sbjctCd);

	public QstnVO selectQstn(int qstnNo);

	public int insertAns(QstnVO qstnVO);

	public int deleteAns(int qstnNo);

}
