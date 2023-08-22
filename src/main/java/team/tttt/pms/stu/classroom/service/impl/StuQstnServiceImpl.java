package team.tttt.pms.stu.classroom.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.stu.classroom.mapper.StuQstnMapper;
import team.tttt.pms.stu.classroom.service.StuQstnService;
import team.tttt.pms.stu.vo.QstnVO;
import team.tttt.pms.tch.vo.TchVO;

@Service
public class StuQstnServiceImpl implements StuQstnService {
    @Inject
    private StuQstnMapper stuQstnMapper;

    // 질문게시판 등록
	@Override
	public ServiceResult insertQstn(QstnVO qstnVO) {
        int status = stuQstnMapper.insertQstn(qstnVO);
        if(status > 0) {
        	return ServiceResult.OK;
        } else {
        	return ServiceResult.FAILED;
        }
	}

	// 질문게시판 조회
	@Override
	public List<QstnVO> selectQstnList(QstnVO qstnVO) {
		List<QstnVO> qstnList = stuQstnMapper.selectQstnList(qstnVO);
		return qstnList;
	}

	@Override
	public QstnVO selectQstn(int qstnNo) {
		return stuQstnMapper.selectQstn(qstnNo);
	}

	@Override
	public TchVO selectTch(String sbjctCd) {
		return stuQstnMapper.selectTch(sbjctCd);
	}

	@Override
	public ServiceResult updateQstn(QstnVO qstnVO) {
		int status = stuQstnMapper.updateQstn(qstnVO);
        if(status > 0) {
        	return ServiceResult.OK;
        } else {
        	return ServiceResult.FAILED;
        }
	}

	@Override
	public ServiceResult deleteQstn(int qstnNo) {
		int status = stuQstnMapper.deleteQstn(qstnNo);
        if(status > 0) {
        	return ServiceResult.OK;
        } else {
        	return ServiceResult.FAILED;
        }
	}

}
