package team.tttt.pms.project.task.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import sun.security.krb5.internal.crypto.NullEType;
import team.tttt.pms.common.enums.ServiceResult;
import team.tttt.pms.project.task.mapper.ProjectTaskMapper;
import team.tttt.pms.project.task.service.ProjectTaskService;
import team.tttt.pms.project.vo.ASGVO;
import team.tttt.pms.project.vo.AlarmVO;
import team.tttt.pms.project.vo.MemManagementVO;
import team.tttt.pms.project.vo.ProjVO;
import team.tttt.pms.project.vo.TaskVO;

@EnableAspectJAutoProxy
@Service
public class ProjectTaskServiceImpl implements ProjectTaskService {

	@Inject
	private ProjectTaskMapper mapper;


	@Override
	public List<TaskVO> taskList(String projNo) {
		System.out.println("------------"+projNo+"----------services");
		return mapper.taskList(projNo);
	}

	@Override
	public TaskVO taskDetail(String taskNo) {

		return mapper.taskDetail(taskNo);
	}

	@Override
	public ServiceResult taskDelete(String taskNo) {

		int cnt = mapper.taskDelete(taskNo);

		if(cnt > 0){
			return ServiceResult.OK;

		}
		return ServiceResult.FAILED;
	}

	@Override
	public TaskVO getDetailTask(String taskNo) {
		return mapper.taskDetail(taskNo);
	}


	// 업무 수정부분
	@Override
	@Transactional
	public ServiceResult taskUpdate(TaskVO taskVO) {

		List<ASGVO> asgList = taskVO.getAsgList();

		int cnt =0;

		for (int i=0; i<asgList.size(); i++) {
			cnt += mapper.deleteTaskPic(asgList.get(i));
		}

		for (int i=0; i<asgList.size(); i++) {
			cnt += mapper.updateTaskPic(asgList.get(i));
		}

		if(taskVO.getTaskSttr() == 100 || taskVO.getTaskStts() == "P003-4") {
			taskVO.setTaskSttr(100);
			taskVO.setTaskStts("P003-4");
		}

		int cnt2 = mapper.taskUpdate(taskVO);
		if (cnt2==0) {
			throw new NullPointerException("update 결과값 0");
		}



		cnt += cnt2;

		if(cnt > 1){
			return ServiceResult.OK;
		}else {
			return ServiceResult.FAILED;
		}

	}

	@Override
	public List<TaskVO> upperTask(String projNo) {

		return mapper.upperTask(projNo);
	}

	@Override
	@Transactional
	public ServiceResult insertTask(TaskVO insertTask) {


		String upperTaskNo = insertTask.getUpperTask();
		System.out.println("upperTaskNo-------------   "+upperTaskNo);


		List<ASGVO> asgList = insertTask.getAsgList();


		/*
		 * AlarmVO alarmVO = new AlarmVO(); alarmVO.setStuNo(insertTask.getStuNo());
		 * alarmVO.setProjNo(insertTask.getProjNo());
		 * alarmVO.setTaskTitle(insertTask.getTaskTitle());
		 */
		int cnt=0;

		if(upperTaskNo.equals("-")) {
			cnt += mapper.insertUpperTask(insertTask);
			//cnt += mapper.insertAlarm(alarmVO);
		}else {
			cnt += mapper.insertLowerTask(insertTask);
			//cnt += mapper.insertAlarm(alarmVO);
		}

		for (int i=0; i<asgList.size(); i++) {
			cnt += mapper.insertTaskPic(asgList.get(i));
		}


		if(cnt > 1){
			return ServiceResult.OK;

		}
		return ServiceResult.FAILED;

	}

	@Override
	public MemManagementVO getMemJbttlCd(Map<String, String> mjMap) {
		return mapper.getMemJbttlCd(mjMap);
	}

	@Override
	public ProjVO getProjNm(String projNo) {
		return mapper.getProjNm(projNo);
	}




}

