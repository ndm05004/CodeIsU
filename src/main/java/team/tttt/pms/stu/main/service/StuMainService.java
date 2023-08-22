package team.tttt.pms.stu.main.service;

import java.util.List;

import team.tttt.pms.emp.vo.SbjctVO;
import team.tttt.pms.project.vo.StorageVO;
import team.tttt.pms.stu.vo.IssueListVO;
import team.tttt.pms.stu.vo.ProjListVO;
import team.tttt.pms.stu.vo.StorageListVO;
import team.tttt.pms.tch.vo.AsmtVO;


public interface StuMainService {

	public List<ProjListVO> projList(String stuNo);

	public List<StorageListVO> storageList(String stuNo);

	public List<IssueListVO> issueList(String stuNo);

	public List<SbjctVO> selectTimetableList(String stuNo);

	public List<AsmtVO> selectAsmtList(String stuNo);




}
