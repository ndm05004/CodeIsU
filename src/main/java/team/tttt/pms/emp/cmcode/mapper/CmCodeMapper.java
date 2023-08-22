package team.tttt.pms.emp.cmcode.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.common.vo.CmCdVO;
import team.tttt.pms.emp.vo.cmTypeVO;

@Mapper
public interface CmCodeMapper {

	public List<cmTypeVO> cmtyList();
	public List<CmCdVO> codeList(String cdTypeId);
	public int codeTypeInsert(cmTypeVO cmtypeVO);
	public int codeTypeUpdate(cmTypeVO cmtypeVO);
	public int codeInsert(CmCdVO codeVO);
	public int codeUpdate(CmCdVO codeVO);
	public int noneCodeInsert(CmCdVO codeVO);
	public List<cmTypeVO> noMecodeTypeList(String codeTypeId);
	public List<CmCdVO> noMeCodeList(CmCdVO cmcdVO);

}
