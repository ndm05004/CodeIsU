package team.tttt.pms.emp.stulist.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.emp.vo.SvlfVO;
import team.tttt.pms.stu.vo.StuVO;

public interface StuListService {

	List<StuVO> getStuListAll();

	List<SvlfVO> getSvlfAll();

	ServiceResult insertStuOne(StuVO stuVO);

	Map<String, Object> excelUpload(File destFile);

}
