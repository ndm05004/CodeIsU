package team.tttt.pms.tch.classroom.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.common.utils.cmFile.mapper.CommonFileMapper;
import team.tttt.pms.common.vo.AtchFileVO;
import team.tttt.pms.tch.classroom.mapper.TchAsmtMapper;
import team.tttt.pms.tch.classroom.service.TchAsmtService;
import team.tttt.pms.tch.vo.AsmtVO;
import team.tttt.pms.tch.vo.QstDtlVO;
import team.tttt.pms.tch.vo.QstVO;
import team.tttt.pms.tch.vo.SbmsnResultVO;
import team.tttt.pms.tch.vo.SbmsnVO;

@Service
@Slf4j
public class TchAsmtServiceImpl implements TchAsmtService {
	@Inject
	private TchAsmtMapper tchAsmtMapper;

	@Inject
	private CommonFileMapper fileMapper;

	@Override
	public ServiceResult insertAsmt(AsmtVO asmtVO) {
		ServiceResult result;
		int status = tchAsmtMapper.insertAsmt(asmtVO);
		if(status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	@Transactional
	public ServiceResult insertQst(QstVO qstVO, List<AtchFileVO> fileVOList) {
		int status = 0;
		int status2 = 0;

		status = tchAsmtMapper.insertQst(qstVO); // 게시글 업로드
		for(int i=0; i<fileVOList.size(); i++) {
			log.info("서비스 파일 리스트 길이 : " + fileVOList.size());
			status2 += fileMapper.fileUpload(fileVOList.get(i)); // 파일 업로드
		}

		if(status>0 && status2==fileVOList.size()) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAILED;
		}
	}

	@Override
	public ServiceResult insertQstDtl(QstDtlVO qstDtlVO) {
		int status = tchAsmtMapper.insertQstDtl(qstDtlVO);
		if(status>0) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAILED;
		}
	}

	@Override
	public List<AsmtVO> selectAsmtList(String sbjctCd) {
		return tchAsmtMapper.selectAsmtList(sbjctCd);
	}

	@Override
	public ServiceResult deleteAsmt(int asmtNo) {
		int status = tchAsmtMapper.deleteAsmt(asmtNo);
		if(status> 0) {
			return ServiceResult.OK;
		} else {
			return ServiceResult.FAILED;
		}
	}

	@Override
	public AsmtVO selectAsmt(int asmtNo) {
		return tchAsmtMapper.selectAsmt(asmtNo);
	}

	@Override
	public List<AtchFileVO> selectAtchFileList(int asmtNo) {
		return tchAsmtMapper.selectAtchFileList(asmtNo);
	}

	@Override
	public List<SbmsnResultVO> selectSbmsnList(int asmtNo) {
		return tchAsmtMapper.selectSbmsnList(asmtNo);
	}

	@Override
	public List<SbmsnVO> selectSbmsnResultList(String userNo, int asmtNo) {
		return tchAsmtMapper.selectSbmsnResultList(userNo, asmtNo);
	}

//	@Override
//	public ServiceResult updateAsmt(AsmtVO asmtVO) {
//		return tchAsmtMapper.updateAsmt(asmtVO);
//	}

//	@Override
//	public ServiceResult updateQst(QstVO qstVO, List<AtchFileVO> fileVOList) {
//		// 이미 등록됐던 문제중 해당 문제가 없어지면 해당 문제의 yn을 N으로 변경
//		int qstNo = qstVO.getQstNo();
//		if (qstNo == 0) {
//
//		}
//		if(qstVO)
//		// 이미 등록됐던 문제중 파일 정보가 들어가 있으면 파일을 삭제하고 인서트
//		return null;
//	}
}
