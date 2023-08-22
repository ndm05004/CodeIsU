package team.tttt.pms.stu.classroom.service.impl;

import java.util.List;

import javax.inject.Inject;
import javax.net.ssl.SSLEngineResult.Status;

import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.vo.AtchFileVO;
import team.tttt.pms.stu.classroom.mapper.StuAsmtMapper;
import team.tttt.pms.stu.classroom.service.StuAsmtService;
import team.tttt.pms.tch.vo.AsmtVO;
import team.tttt.pms.tch.vo.QstAnswerVO;
import team.tttt.pms.tch.vo.SbmsnVO;

@Service
@Slf4j
public class StuAsmtServiceImpl implements StuAsmtService{
	@Inject
	private StuAsmtMapper stuAsmtMapper;

	@Override
	public List<AsmtVO> selectAsmtList(String sbjctCd, String userNo) {
		return stuAsmtMapper.selectAsmtList(sbjctCd, userNo);
	}

	@Override
	public AsmtVO selectAmst(int asmtNo) {
		return stuAsmtMapper.selectAmst(asmtNo);
	}

	@Override
	public List<AtchFileVO> selectAtchFileList(int asmtNo) {
		return stuAsmtMapper.selectAtchFileList(asmtNo);
	}

	@Override
	public ServiceResult insertSbmsn(List<QstAnswerVO> astAnswerList, String userNo, String sbjctCd) {
		ServiceResult result;
		int status = 0;

		for (QstAnswerVO qstAnswerVO : astAnswerList) {
			SbmsnVO sbmsnVO = new SbmsnVO();
			String qstSbmsnAns = qstAnswerVO.getQstSbmsnAns();
			if(qstSbmsnAns == null) {
				qstSbmsnAns = "";
			}
			sbmsnVO.setQstSbmsnAns(qstSbmsnAns);
			sbmsnVO.setQstNo(qstAnswerVO.getQstNo());
			sbmsnVO.setSbjctCd(sbjctCd);
			sbmsnVO.setStuNo(userNo);

			int insertNum = stuAsmtMapper.insertSbmsn(sbmsnVO);
			if(insertNum > 0) {
				status++;
			}
		}
		if(status > 0) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAILED;
		}

	}

	@Override
	public List<SbmsnVO> selectSbmsnList(String userNo, int asmtNo) {
		return stuAsmtMapper.selectSbmsnList(userNo, asmtNo);
	}

}
