package team.tttt.pms.stu.classroom.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.emp.vo.SbjctVO;
import team.tttt.pms.stu.vo.StuVO;

@Mapper
public interface ClassroomMainMapper {

	public List<SbjctVO> selectClassroomList(String userNo);

}
