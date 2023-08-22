package team.tttt.pms.project.memManage.service;

import java.util.List;
import java.util.Map;

import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.project.vo.MemJoinAplyVO;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.ProjVO;

public interface MemManagementService {

	public List<MemManagementVO> memList(String projNo);

	public ServiceResult positionModify(MemManagementVO vo);

	public List<MemJoinAplyVO> memJoinAplyList(String projNo);

	public MemJoinAplyVO memJoinDetail(Map<String, String> map);

	public ServiceResult memInsert(MemManagementVO memVO);

	public ServiceResult memDel(MemManagementVO memVO);

	public ProjVO projStatus(ProjVO projVO);

	public ProjVO projUpdate(ProjVO projVO);

	public ServiceResult projMemDel(MemManagementVO memVO);

	public ServiceResult projDelete(String projNo);

	public ServiceResult aplyDel(String projNo);

	public String plCheck(String userName);

	public ServiceResult projConUpdate(ProjVO projVO);

	public ServiceResult projMemCount(String projNo);

	public MemManagementVO getMemJbttlCd(Map<String, String> mjMap);








}
