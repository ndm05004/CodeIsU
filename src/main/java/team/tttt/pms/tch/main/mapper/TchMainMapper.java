package team.tttt.pms.tch.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.stu.vo.QstnVO;
import team.tttt.pms.tch.vo.TchVO;

@Mapper
public interface TchMainMapper {

	public List<TchVO> selectClassList(String userNo);

	public List<QstnVO> selectQntnAnsNoList(String userNo);

	public List<QstnVO> selectAsmtList(String userNo);

}
