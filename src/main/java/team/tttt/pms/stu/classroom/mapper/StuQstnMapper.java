package team.tttt.pms.stu.classroom.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.stu.vo.QstnVO;
import team.tttt.pms.tch.vo.TchVO;

@Mapper
public interface StuQstnMapper {
    public int insertQstn(QstnVO qstnVO);

	public List<QstnVO> selectQstnList(QstnVO qstnVO);

	public QstnVO selectQstn(int qstnNo);

	public TchVO selectTch(String sbjctCd);

	public int updateQstn(QstnVO qstnVO);

	public int deleteQstn(int qstnNo);
}
