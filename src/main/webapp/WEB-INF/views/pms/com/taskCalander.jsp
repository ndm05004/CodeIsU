<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
<script src="${pageContext.request.contextPath}/common/sw/js/PmsCalander.js"></script>
<script src="${pageContext.request.contextPath}/common/sw/js/CommonCode.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
  .task {
    border: 1px solid #e6e3e2;
  }
  .taskCn {
    border: 1px solid #e6e3e2;
  }

  p.task {
    background-color: #f4f2f2;
  }
  p.taskCn {
    background-color: #f4f2f2;
  }

  .msubBtn {
    background-color: #344767;
    color: white;
  }
  .mcanBtn {
    border: 1px solid #344767;
  }

  .circle {
    width: 20px;
    height: 20px;
    border-radius: 50%;
  }
  .fc .fc-button {
    line-height: 2 !important;
  }
  #fc-dom-1 {
    font-size: 1.5em !important;
  }
  .fc .fc-button {
    padding: 0em 0.3em !important;
    font-size: 0.9em !important;
  }

  .fc table {
    font-size: 0.8em !important;
  }
  :root {
    --fc-small-font-size: 0.85em !important;
  }

  label.necessary::after {
    content: "*";
    color: red;
    margin-left: 4px;
  }

  .controllProgress {
    display: flex;
    align-items: center;
  }

  .controllInput {
    flex: 1;
  }

  #progressPer {
    margin-left: 10px;
  }
</style>

<div>
  <div class="card mt-3 mb-3">
    <div style="height: 40px" class="">
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
    <div class="table-responsive">
      <div id="calendar"></div>
    </div>
  </div>
</div>
<!--모달-->
<div
  class="modal fade"
  id="taskModal"
  role="dialog"
  aria-labelledby="taskModal"
  aria-hidden="true"
>
  <div class="modal-dialog d-flex justify-content-center" role="document">
    <div class="modal-content" id="taskModalBody"></div>
  </div>
</div>

<script>
  projNo = "${projNo}";

  const header = "${_csrf.headerName}";
  const token = "${_csrf.token}";
  let sch;
  let calendar;
  let calendarEl;
  let removeEvent;
  let titleUpdate;

  let projBgngDt = "";
  let projDdlnDt = "";

  function getCalander(projNo) {
    console.log(projNo + " projNo");
    $.ajax({
      url: "/pms/project/taskListOut?${_csrf.parameterName}=${_csrf.token}",
      data: {
        projNo: projNo,
      },
      type: "POST",
      dataType: "json",
      success: function (res) {
        console.log("res : ", res);
        let projBgngDt;
        let projDdlnDt;

        if (res.length > 0) {
          projBgngDt = res[0].projBgngDt;
          projDdlnDt = res[0].projDdlnDt;
        } else {
          projBgngDt = 0;
          projDdlnDt = 0;
        }

        sch = convertDataToEvents(res);
        calendarEl = document.getElementById("calendar");
        calendar = new FullCalendar.Calendar(calendarEl, {
          aspectRatio: 1.35,
          expandRows: true,
          locale: "kr",
          initialView: "dayGridMonth",
          nowIndicator: true,
          dayMaxEvents: true,
          editable: true,
          selectable: true,
          selectMirror: true,
          buttonText: {
            today: "오늘",
            month: "월별",
            week: "주별",
            day: "일별",
            year: "년별",
          },
          events: sch,
          select: function (arg) {
            let endDate = new Date(arg.endStr);
            endDate.setDate(endDate.getDate() - 1);
            endDate = endDate.toISOString().split("T")[0];

            insertTask(projNo, arg.startStr, endDate, projBgngDt, projDdlnDt);
          },
          eventClick: function (arg) {
            taskNo = arg.event._def.extendedProps.taskNo;
            detailTask(taskNo);

            removeEvent = () => {
              arg.event.remove();
            };

            calendar.unselect();
          },

          eventDrop: function (arg) {
            const startDate = new Date(arg.event.start);
            startDate.setDate(startDate.getDate() + 1);
            const formattedStartDate = startDate.toISOString().split("T")[0];
            const endDate = new Date(arg.event.end);
            const formattedEndDate = endDate.toISOString().split("T")[0];

            taskNo = arg.event._def.extendedProps.taskNo;
            titleUpdate = arg;

            updateTask(
              taskNo,
              formattedStartDate,
              formattedEndDate,
              projBgngDt,
              projDdlnDt
            );

            console.log("업데이트 완료");
          },

          eventResize: function (arg) {
            var events = [];
            console.log(arg);

            const startDate = new Date(arg.event.start);

            startDate.setDate(startDate.getDate() + 1);

            const formattedStartDate = startDate.toISOString().split("T")[0];

            const endDate = new Date(arg.event.end);
            const formattedEndDate = endDate.toISOString().split("T")[0];

            taskNo = arg.event._def.extendedProps.taskNo;
            updateTask(
              taskNo,
              formattedStartDate,
              formattedEndDate,
              projBgngDt,
              projDdlnDt
            );
          },

          headerToolbar: {
            left: "prev,next",
            center: "title",
            right: "dayGridMonth,dayGridWeek,dayGridDay,dayGridYear",
          },
        });

        setTimeout(() => {
          calendar.render();
          calendar.setOption("aspectRatio", 1.5);
        }, 100);
      },
      error: function (xhr, status, error) {
        console.error(error);
      },
    });
  }
  getCalander(projNo);

  function convertDataToEvents(data) {
    let events = [];
    let backgroundColor;
    let borderColor = "white";

    for (var i = 0; i < data.length; i++) {
      if (data[i].taskPriority == "낮음") {
        backgroundColor = "#56726A";
      } else if (data[i].taskPriority == "보통") {
        backgroundColor = "#465B8A";
      } else if (data[i].taskPriority == "높음") {
        backgroundColor = "#D48834";
      } else if (data[i].taskPriority == "긴급") {
        backgroundColor = "#D71923";
      }
      let endDate = new Date(data[i].taskDdlnDt);
      endDate.setDate(endDate.getDate() + 1);
      endDate = endDate.toISOString().split("T")[0];

      let event = {
        title: data[i].taskTitle,
        start: data[i].taskBengDt,
        end: endDate,
        backgroundColor: backgroundColor,
        borderColor: borderColor,
        taskNo: data[i].taskNo,
      };
      events.push(event);
    }
    return events;
  }

  // 수정 저장 버튼  // 삭제버튼  // 일감 저장 버튼
  document.addEventListener("click", function (event) {
    if (event.target.id === "updateSaveBtn") {
      const taskNo = document.getElementById("taskUpdatetaskNo").innerText;
      console.log("updateSaveTask : " + taskNo);
      const title = document.querySelector(".taskUpdateTitle");

      updateTaskSave(taskNo, header, token);
    }
    if (event.target.id === "deleteTaskBtn") {
      const taskNo = document.getElementById("taskDetailtaskNo").innerText;
      deleteTask(taskNo, header, token);
      removeEvent();
      console.log("안됨");
    }
    if (event.target.id === "insertSaveBtn") {
      if (insertValidation()) {
        insertTaskSave(projNo, header, token);
      }
    }
  });
</script>
