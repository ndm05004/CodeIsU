package team.tttt.pms.tch.classroom.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.stu.vo.QstnVO;
import team.tttt.pms.tch.classroom.mapper.TchQstnMapper;
import team.tttt.pms.tch.classroom.service.TchQstnService;

@Service
public class TchQstnServiceImpl implements TchQstnService{
	@Inject
	private TchQstnMapper tchQstnMapper;

	@Override
	public List<QstnVO> selectQstnList(String sbjctCd) {
		return tchQstnMapper.selectQstnList(sbjctCd);
	}

	@Override
	public List<QstnVO> selectQstnListAnsNo(String sbjctCd) {
		return tchQstnMapper.selectQstnListAnsNo(sbjctCd);
	}

	@Override
	public List<QstnVO> selectQstnListAnsYes(String sbjctCd) {
		return tchQstnMapper.selectQstnListAnsYes(sbjctCd);
	}

	@Override
	public QstnVO selectQstn(int qstnNo) {
		return tchQstnMapper.selectQstn(qstnNo);
	}

	@Override
	public ServiceResult insertAns(QstnVO qstnVO) {
		int status = tchQstnMapper.insertAns(qstnVO);
		if(status > 0) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAILED;
		}
	}

	@Override
	public ServiceResult deleteAns(int qstnNo) {
		int status = tchQstnMapper.deleteAns(qstnNo);
		if(status > 0) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAILED;
		}
	}

}
