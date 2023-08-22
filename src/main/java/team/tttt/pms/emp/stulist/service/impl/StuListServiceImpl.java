package team.tttt.pms.emp.stulist.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.ObjectMapper;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.utils.ExcelUtils;
import team.tttt.pms.common.vo.UserVO;
import team.tttt.pms.emp.stulist.mapper.StuListMapper;
import team.tttt.pms.emp.stulist.service.StuListService;
import team.tttt.pms.emp.vo.SvlfVO;
import team.tttt.pms.stu.vo.StuVO;

@EnableAspectJAutoProxy
@Service
public class StuListServiceImpl implements StuListService {

	@Inject
	StuListMapper stuListMapper;

	@Override
	public List<StuVO> getStuListAll() {
		return stuListMapper.getStuListAll();
	}

	@Override
	public List<SvlfVO> getSvlfAll() {
		return stuListMapper.getSvlfAll();
	}

	@Transactional
	@Override
	public ServiceResult insertStuOne(StuVO stuVO) {

		ServiceResult result = ServiceResult.FAILED;

		int cnt = stuListMapper.insertStuOne(stuVO);
		if (cnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}


	/* 원생 엑셀POI 일괄 업로드 */
	@Override
	public Map<String, Object> excelUpload(File destFile) {
		ObjectMapper mapper = new ObjectMapper();

		// 엑셀파일을 Map객체의 List로 변환하여 가져옵니다.
        List<Map<String, String>> excelContent  = ExcelUtils.readExcel(destFile.getAbsolutePath());

        /* Map으로 구성된 List의 객체를 VO의 List의 형태로 변경합니다. */
        List<StuVO> stuList = new ArrayList<StuVO>();
        for (Map<String, String> map : excelContent) {
        	stuList.add(mapper.convertValue(map, StuVO.class));
		}

        int successCnt = 0;
        for (StuVO stuVO : stuList) {
			int cnt = 0;
			if(stuVO.getUserGender().equals("남")) { // 엑셀로 입력된 성별  DB에 맞게 수정
				stuVO.setUserGender("M"); } else { 	stuVO.setUserGender("F");
			}

			cnt = stuListMapper.insertStuOne(stuVO);
			if(cnt > 0) {
				stuVO.setInsertSuccess("Y");
				successCnt++;
			} else {
				stuVO.setInsertSuccess("N");
			}

		}

        Map<String, Object> resMap = new HashMap<String, Object>();
        resMap.put("stuList", stuList);
        resMap.put("successCnt", successCnt);
        resMap.put("failedCnt", stuList.size()-successCnt);
        /* DB에 Insert 합니다. */

		return resMap;

	}

}
