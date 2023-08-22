package team.tttt.pms.stu.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.emp.vo.SbjctVO;
import team.tttt.pms.stu.vo.IssueListVO;
import team.tttt.pms.stu.vo.ProjListVO;
import team.tttt.pms.stu.vo.StorageListVO;
import team.tttt.pms.tch.vo.AsmtVO;

@Mapper
public interface StuMainMapper {

	public List<ProjListVO> projList(String stuNo);

	public List<StorageListVO> storageList(String stuNo);

	public List<IssueListVO> issueList(String stuNo);

	public List<SbjctVO> selectTimetableList(String stuNo);

	public List<AsmtVO> selectAsmtList(String stuNo);




}
