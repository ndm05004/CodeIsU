package team.tttt.pms.project.vo;

import java.util.List;

import lombok.Data;

@Data
public class TaskVO {
	private String taskNo;
	private String taskTitle;
	private String taskPriority;
	private String taskBengDt;
	private String taskDdlnDt;
	private String taskRegDt;
	private String taskCn;
	private String projNo;
	private String taskStts;
	private String upperTask;
	private int    taskSttr;
	private String     projNm;
	private String projBgngDt;
	private String projDdlnDt;
	private int	   projSttr;
	private String stuNo;

	private List<ASGVO> asgList;

}
