package team.tttt.pms.project.memManage.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import team.tttt.pms.project.vo.MemJoinAplyVO;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.ProjVO;

@Mapper
public interface MemManagementMapper {

	public List<MemManagementVO> memList(String projNo);

	public int positionModify(MemManagementVO vo);

	public List<MemJoinAplyVO> memJoinAplyList(String projNo);

	public MemJoinAplyVO memJoinDetail(Map<String, String> map);

	public int memInsert(MemManagementVO memVO);

	public int memDel(MemManagementVO memVO);

	public ProjVO projStatus(ProjVO projVO);

	public ProjVO projUpdate(ProjVO projVO);

	public int projDelete(String projNo);

	public int projMemDel(String projNo);

	public int aplyDel(String projNo);

	public String plCheck(String userName);

	public int projConUpdate(ProjVO projVO);

	public int projMemCount(String projNo);

	public MemManagementVO getMemJbttlCd(Map<String, String> mjMap);





}
