package team.tttt.pms.stu.hakup.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.stu.vo.AttdanVO;
import team.tttt.pms.stu.vo.StuVO;

@Mapper
public interface AttdanMapper {

	public StuVO selectStu(String userNo);

	public int insertAttdan(AttdanVO attdanVO);

	public List<AttdanVO> selectAttdanList(String stuNo);

	public int deleteAttdan(int attdanNo);

}
