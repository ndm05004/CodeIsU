<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<link
  rel="stylesheet"
  href="http://cdn.dhtmlx.com/gantt/edge/dhtmlxgantt.css"
  type="text/css"
/>
<script src="https://docs.dhtmlx.com/gantt/codebase/dhtmlxgantt.js?v=6.1.7"></script>
<script src="${pageContext.request.contextPath}/common/sw/js/GanttChartJs.js"></script>

<style>
  .rowPriority {
    border: 2px solid #56726a;
    color: #56726a;
    background: #56726a;
  }

  .rowPriority .gantt_task_progress {
    background: #404f51;
  }

  .middle {
    border: 2px solid #465b8a;
    color: #465b8a;
    background: #465b8a;
  }

  .middle .gantt_task_progress {
    background: #2d3a5b;
  }

  .high {
    border: 2px solid #d48834;
    color: #d48834;
    background: #d48834;
  }

  .high .gantt_task_progress {
    background: #9d561e;
  }

  .emergency {
    border: 2px solid #d71923;
    color: #d71923;
    background: #d71923;
  }

  .emergency .gantt_task_progress {
    background: #8e0b16;
  }

  .weekend {
    background: #f4f7f4 !important;
  }
  .circle {
    width: 20px;
    height: 20px;
    border-radius: 50%;
  }
  .card .card-header {
    padding: 0.32rem;
  }
</style>

<div>
  <div class="card mt-3 mb-3">
    <div style="height: 40px">
      <div class="d-flex align-items-center me-2 mt-2">
        <div class="d-flex align-items-center">
          <div class="circle ms-1" style="background-color: #d71923"></div>
          <p class="mb-0 me-3 ms-1 text-xs">긴급</p>
        </div>
        <div class="d-flex align-items-center">
          <div class="circle" style="background-color: #d48834"></div>
          <p class="mb-0 me-3 ms-1 text-xs">높음</p>
        </div>
        <div class="d-flex align-items-center">
          <div class="circle" style="background-color: #465b8a"></div>
          <p class="mb-0 me-3 ms-1 text-xs">보통</p>
        </div>
        <div class="d-flex align-items-center">
          <div class="circle" style="background-color: #56726a"></div>
          <p class="mb-0 me-3 ms-1 text-xs">낮음</p>
        </div>
      </div>
    </div>
  </div>

  <div class="card">
    <div class="card-body">
      <div id="taskGantt" style="width: 100%; height: 580px"></div>
    </div>
  </div>
</div>

<script type="text/javascript">
  projNo = "${projNo}";
  const header = "${_csrf.headerName}";
  const token = "${_csrf.token}";

  const ganttChartData = (projNo) => {
    $.ajax({
      url: "/pms/project/ganttTask",
      data: {
        projNo: projNo,
      },
      type: "get",
      dataType: "json",
      success: function (res) {
        console.log("원본 데이터 ", res);

        let ganttData = [];

        ganttData = convertData(res);
        ganttLink = convertLink(res);
        console.log("간트차트 링크 ", ganttLink);

        // 간트차트 api 시작

        gantt.config.xml_date = "%Y-%m-%d %H:%i";
        gantt.i18n.setLocale("kr");

        gantt.config.columns = [
          {
            name: "text",
            label: "일감 명",
            tree: true,
            resize: true,
            min_width: 160,
            open: true,
          },
          {
            name: "start_date",
            label: "시작일",
            align: "center",
            resize: true,
          },
          { name: "duration", label: "D-Day", align: "center", resize: true },
          {
            name: "priority",
            label: "우선순위",
            align: "center",
            template: function (obj) {
              if (obj.priority == 1) {
                return "낮음";
              }
              if (obj.priority == 2) {
                return "보통";
              }
              if (obj.priority == 3) {
                return "높음";
              }
              return "긴급";
            },
          },
        ];

        gantt.templates.task_class = function (start, end, task) {
          switch (task.priority) {
            case "1":
              return "rowPriority";
              break;
            case "2":
              return "middle";
              break;
            case "3":
              return "high";
              break;
            case "4":
              return "emergency";
              break;
          }
        };

        gantt.init("taskGantt");

        gantt.parse({
          data: ganttData,
          links: ganttLink,
        });
      },
    });
  };

  const convertData = (res) => {
    let ganttData = [];

    // 프로젝트 날짜 계산

    console.log("res : ", res);
    let projBgngDt;
    let projDdlnDt;

    if (res.length > 0) {
      projBgngDt = Date.parse(res[0].projBgngDt);
      projDdlnDt = Date.parse(res[0].projDdlnDt);

      let duration = projDdlnDt - projBgngDt;
      duration = Math.ceil(duration / (1000 * 60 * 60 * 24));

      let start_date = res[0].projBgngDt + " 00:00";
      // 프로젝트 날짜 계산 끝

      let projSttr = res[0].projSttr / 100;

      convertDatas = {
        id: res[0].projNo,
        text: res[0].projNm,
        start_date: start_date,
        duration: duration,
        progress: projSttr,
        open: true,
      };

      ganttData.push(convertDatas);

      for (let i = 0; i < res.length; i++) {
        // 남은일, 시작일 계산
        let taskBengDt = Date.parse(res[i].taskBengDt);
        let taskDdlnDt = Date.parse(res[i].taskDdlnDt);

        let duration = taskDdlnDt - taskBengDt;

        duration = Math.ceil(duration / (1000 * 60 * 60 * 24));
        let start_date = res[i].taskBengDt + " 00:00";

        if (res[i].upperTask === null) {
          res[i].upperTask = 0;
        }
        // 끝

        // 진행율 계산
        taskSttr = res[i].taskSttr / 100;

        // 우선순위 계산
        let taskStts;
        if (res[i].taskPriority == "낮음") {
          taskStts = "1";
        } else if (res[i].taskPriority == "보통") {
          taskStts = "2";
        } else if (res[i].taskPriority == "높음") {
          taskStts = "3";
        } else if (res[i].taskPriority == "긴급") {
          taskStts = "4";
        }

        convertDatas = {
          id: res[i].taskNo,
          text: res[i].taskTitle,
          start_date: start_date,
          duration: duration,
          parent: res[i].upperTask,
          progress: taskSttr,
          open: true,
          priority: taskStts,
        };

        ganttData.push(convertDatas);
      }
      console.log("간트차트 형식 데이터", ganttData);
    }

    return ganttData;
  };

  const convertLink = (res) => {
    let ganttLinks = [];
    let cnt =0;

    for (let i = 0; i < res.length; i++) {
      for (let j = 0; j < res.length; j++) {
        if (res[j].taskNo == res[i].upperTask) {
          let ganttLink = {
            id: cnt,
            source: res[i].upperTask,
            target: res[i].taskNo,
            type: "1",
          };
          cnt= cnt+1;

          ganttLinks.push(ganttLink);
        }
      }
    }
    return ganttLinks;
  };

  ganttChartData(projNo);





  gantt.attachEvent("onAfterTaskDrag", function (id, mode) {
	  var task = gantt.getTask(id);
	  if (mode == gantt.config.drag_mode.progress) {
	    var pr = Math.floor(task.progress * 100 * 10) / 10;
	    gantt.message(task.text + " is now " + pr + "% completed!");
	    console.log("간트 차트 onAfterTaskDrag if task", task);
	    console.log("간트 차트 onAfterTaskDrag if task.text", task.text);
	    console.log("간트 차트 onAfterTaskDrag if pr", pr);
	  } else {
	    var convert = gantt.date.date_to_str("%H:%i, %F %j");
	    var startDate = convert(task.start_date);
	    var endDate = convert(task.end_date);
	    var taskNo = task.id;

	    const convertedStartDate = convertToCustomFormat(startDate);
	    const convertedEndDate = convertToCustomFormat(endDate);

	    const data = {
	      taskNo: taskNo,
	      taskBengDt: convertedStartDate,
	      taskDdlnDt: convertedEndDate,

	    };

	    console.log("task : : : " ,task)
	    console.log("data : : : " ,data)

	    $.ajax({
	      url: "/pms/project/ganttTaskUpdate",
	      data: JSON.stringify(data),
	      type: "put",
	      contentType: "application/json;charset=utf-8",
	      dataType: "text",

	      beforeSend: function (xhr) {
	        xhr.setRequestHeader(header, token);
	      },
	      success: function (res) {

	        console.log("res : : : ", res)

	        Swal.fire({
	          icon: "success",
	          title: "수정되었습니다.",
	          showConfirmButton: false,
	          timer: 1500,
	        });
	      },
	      error: function (request) {
	        console.log("code: " + request.status);
	      },
	    });

	      }
	    });






</script>
<script src="https://cdn.ravenjs.com/3.10.0/raven.min.js"></script>