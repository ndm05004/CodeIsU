/**
 *
 */

// 헤더, 토큰 가져오는 함수
/*
const headerToken = window.deliverToken();

header = headerToken[0];
token = headerToken[1];

console.log(header + "값      " + token + "값"); */

// 담당자 리스트 AG그리드때 사용
const getAsgList = (asgList) => {
  let taskPics = "";

  for (let i = 0; i < asgList.length; i++) {
    taskPics += asgList[i].userNm + " ";
  }
  console.log(taskPics);
  return taskPics;
};

// 담당자 array 수정 모달에서 사용
const getAsgArray = (asgList) => {
  let taskPics = [];

  for (let i = 0; i < asgList.length; i++) {
    taskPics.push(asgList[i].userNm);
  }
  console.log(taskPics);
  return taskPics;
};

// 프로젝트 팀원 리스트 추출 상세 모달에서 사용
const getTeamMemList = (projNo) => {
  $.ajax({
    url: "/pms/project/extractMem",
    data: {
      projNo: projNo,
    },
    type: "get",
    dataType: "json",
    success: function (res) {
      console.log("팀원", res);
      let teamOption = "";
      for (let i = 0; i < res.length; i++) {
        teamOption += `<option value=${res[i].stuNo}>${res[i].userNm}</option>`;
      }
      console.log("getTeamMemList : " + teamOption);
      $("#taskInsertPic").html(teamOption);
    },
    error: function (xhr) {
      console.log("getTeamMemList 상태: " + xhr.status);
    },
  });
};

// 프로젝트 팀원 리스트 추출 수정 모달에서 사용
const getTeamMemTaskList = (projNo, selection) => {
  $.ajax({
    url: "/pms/project/extractMem",
    data: {
      projNo: projNo,
    },
    type: "get",
    dataType: "json",
    success: function (res) {
      console.log("팀원", res);
      let teamOption = "";
      for (let i = 0; i < res.length; i++) {
        const isSelected = selection.includes(res[i].userNm) ? "selected" : "";
        teamOption += `<option value=${res[i].stuNo} ${isSelected}>${res[i].userNm}</option>`;
      }

      console.log("getTeamMemList : " + teamOption);
      $("#taskUpdatePic").html(teamOption);
    },
    error: function (xhr) {
      console.log("getTeamMemList 상태: " + xhr.status);
    },
  });
};

// 상위 일감 추가 시
// 상위 일감 추가 시
const getUpperTaskNo = (projNo) => {
  $.ajax({
    url: "/pms/project/upperTask",
    data: {
      projNo: projNo,
    },
    type: "get",
    dataType: "json",
    success: function (res) {
      let upperTask = "<option value='-'>해당사항없음</option>";
      for (let i = 0; i < res.length; i++) {
        upperTask += `<option value=${res[i].taskNo}>${res[i].taskTitle}</option>`;
      }

      $("#taskInsertTaskNo").html(upperTask);
    },
    error: function (xhr) {
      console.log("getTeamMemList 상태: " + xhr.status);
    },
  });
};
// 날짜 수정
function convertDate(Cdate) {
  const year = Cdate.substring(0, 4);
  const month = Cdate.substring(4, 6);
  const day = Cdate.substring(6, 8);
  const formattedDate = year + "-" + month + "-" + day;
  return formattedDate;
}

// 상세보기 모달
function detailTask(taskNo, arg) {
  $.ajax({
    url: "/pms/project/taskDetail",
    data: {
      taskNo: taskNo,
    },
    type: "get",
    dataType: "json",
    success: function (res) {
      console.log(res.taskBengDt);
      console.log(res.taskDdlnDt);

      const taskBengDt = convertDate(res.taskBengDt);

      const taskDdlnDt = convertDate(res.taskDdlnDt);

      console.log(taskBengDt);

      let taskPics = getAsgList(res.asgList);

      console.log(taskPics);

      const modalHtml = `
            <div class="modal-header">
            <h5 class="modal-title font-weight-normal" id="taskDetailModalLabel">
              일감 상세보기
            </h5>
          </div>
          <div class="modal-body">
            <form>

                <div class="container">
                <div class="row">
                <div class="col-3">
                  <label class="" for="taskDetailTitle">업무명</label>
                </div>
                <div class="col-9">
                  <p id="taskDetailTitle" name="taskTitle" class="form-control task mb-1">${res.taskTitle}</p>
                  </div>
                </div>
                </div>

      <div class="container">
                <div class="row">
                <div class="col-3">
                    <label class="" for="taskDetailBengDt">날짜</label>
                </div>
                <div class="col-4">
                    <p name="taskBengDt" id="taskDetailBengDt" class="form-control text-center task mb-1 me-2">${taskBengDt}</p>
                </div>
                <div class="col-1">
                    <span style="line-height:40px;">-</span>
                </div>
                <div class="col-4">
                    <p id="taskDetailDdlnDt" name="taskDdlnDt" class="form-control text-center task mb-1 ms-0">${taskDdlnDt}</p>
                </div>
                </div>
            </div>

        <div class="container">
                <div class="row">
                <div class="col-3">
                  <label class=" for="taskDetailPic">담당자</label>
          </div>
                <div class="col-9">
                  <p name="taskPic" id="taskDetailPic" class="form-control task mb-1"> ${taskPics}</p>
          </div>
        </div>
      </div>

      <div class="container">
                <div class="row">
                <div class="col-3">
                    <label class="" for="taskDetailPriority">우선순위</label>
                  </div>
                <div class="col-9">
                      <p class="form-control task mb-1"id="taskDetailPriority" name="taskPriority" aria-label="Default select example">${res.taskPriority}</p>
                  </div>
        </div>
      </div>

      <div class="container">
                <div class="row">
                <div class="col-3">
              <label class="" for="taskDetailStts">상태</label>
              </div>
                <div class="col-9">
                  <p class="form-control task mb-1" id="taskDetailStts" name="taskStts">${res.taskStts}</p>
          </div>
        </div>
      </div>

      <div class="container">
                <div class="row">
                <div class="col-3">
                  <label class="" for="taskDetailtaskNo">업무번호</label>
                  </div>
                <div class="col-9">
                  <p id="taskDetailtaskNo" name="taskNo"  class="form-control task mb-1" >${res.taskNo}</p>
                  </div>
        </div>
      </div>


      <div class="container" id="taskDetailSttrDiv">
                <div class="row">
                  <div class="col-3 progress-info">
                    <label class="" for="taskDetailSttrDiv">진척도</label>
                  </div>
          <div class="col-9 mt-3">
                    <div class="progress">
                      <div class="progress-bar bg-info" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: ${res.taskSttr}%;">
                      </div>
                      </div>
                      <div class=" text-sm font-weight-normal" id="taskDetailSttr"></div>
                  </div>
                </div>
              </div>

      <div class="container">
                <div class="row">
                <div class="col-3">
                  <label class="" for="">등록일</label>
                  </div>
                <div class="col-9">
                  <p name="taskRegDt" id="taskDetailRegDt"  class="form-control task mb-1" >${res.taskRegDt}</p>
                  </div>
              </div>
        </div>

      <div class="container">
                <div class="row">
                <div class="col-3">
                    <label class="" for="">내용</label>
                </div>
                <div class="col-9">
              <p  id="taskDetailCn" name="taskCn" class="form-control task Cn">${res.taskCn}</p>
        </div>
              </div>
            </div>


              <div class="modal-footer">
                <button type="button" id="updateTaskBtn" class="btn bg msubBtn">수정</button>
                <button type="button" id="deleteTaskBtn" class="btn bg msubBtn">삭제</button>
                <button
                  type="button"
                  class="btn bg mcanBtn"
                  data-bs-dismiss="modal" style="border: 1px solid #344767;"

                >
                  닫기
                </button>
              </div>
            </form>
          </div>
            `;
      $("#taskModalBody").html(modalHtml);

      $("#taskModal").modal("show");
    },
  });
}

// 업데이트 모달
function updateTask(taskNo, startDate, endDate, projBgngDt, projDdlnDt) {
  $.ajax({
    url: "/pms/project/taskDetail",
    data: {
      taskNo: taskNo,
    },
    type: "get",
    dataType: "json",
    success: function (res) {
      let taskBengDt = "";
      let taskDdlnDt = "";

      console.log("projBgngDt, projDdlnDt : ", projBgngDt, projDdlnDt);

      if (startDate == null && endDate == null) {
        taskBengDt = convertDate(res.taskBengDt);

        taskDdlnDt = convertDate(res.taskDdlnDt);
      } else {
        taskBengDt = startDate;
        taskDdlnDt = endDate;
      }

      if (projBgngDt == null && projDdlnDt == null) {
        projBgngDt = convertDate(projBgngDt);

        projDdlnDt = convertDate(projDdlnDt);
      } else {
        projBgngDt = projBgngDt;
        projDdlnDt = projDdlnDt;
      }

      console.log(taskBengDt);

      let taskPics = getAsgArray(res.asgList);

      console.log("담당자 이름들 : " + taskPics);

      const modalHtml = `
                <div class="modal-header">
                <div class="container">
                  <div class="row">
                <div class="col-8">
                  <h5 class="modal-title font-weight-normal" id="taskUpdateModalLabel">
                      일감 수정하기
                  </h5>
                </div>
                  </div>
                </div>

                <div class="container">
                  <div class="row justify-content-end">
                <div class="col-6 text-right " for="taskUpdatetaskNo ">업무번호</div>
                <div class="col-4 textline" id="taskUpdatetaskNo" name="taskNo"  class="form-control task mb-1" >${res.taskNo}</div>
                </div>
              </div>
            </div>
            <div class="modal-body">
              <form>

                <div class="container">
                  <div class="row">
                  <div class="col-3">
                    <label>제목</label>
                  </div>
                  <div class="col-9">
                    <input type="text" id="taskUpdateTitle" name="taskTitle" class="form-control task mb-1 textline" value="${res.taskTitle}"/>
                  </div>
                </div>
                </div>

          <div class="container">
                  <div class="row">
          <div class="col-3" for="taskUpdateStts">
          <label>상태</label>
          </div>
                      <div class="col-9">
                        <select class="mb-1 form-select task textline" id="taskUpdateStts" name="taskStts">
                      </select>
                      </div>
          </div>
          </div>


          <div class="container">
                  <div class="row">
                    <div class="col-3" for="taskUpdatePic">
                      <label>담당자</label>
                    </div>
          <div class="col-9">
                        <select class="mb-1 form-select task textline" multiple="true" id="taskUpdatePic" name="taskStts">
                      </select>
                    </div>
          </div>
          </div>

          <div class="container">
            <div class="row">
            <div class="col-3" for="controllProgressDiv">
              <label>진척도</label>
            </div>
            <div class="col-9 controllProgress" id="controllProgressDiv">
              <input class="mb-1 progress-bar bg-info controllInput" type="range" min="1" max="100" value="${res.taskSttr}" id="progress">

            <div id="progressPer"></div></div>
            </div>
         </div>

          <div class="container">
            <div class="row">
              <div class="col-3" for="taskUpdateRegDt">
                      <label>등록일</label>
                    </div>
                    <div class="col-9">
                      <p
                        name="taskRegDt"
                        id="taskUpdateRegDt"
                        class="form-control task mb-1 textline"
                      >${res.taskRegDt}</p>\
                </div>
                  </div>
          </div>
              <div>



          <div class="container">
          <div class="row">
            <div class="col-3" for="taskDetailBengDt">
                      <label>날짜</label>
                </div>
          <div class="col-4 mb-1" for="">
                      <input
                        type="date"
                        name="taskBengDt"
                        id="taskUpdateBengDt"
                        class="form-control task textline"
                        style="width:140px;"
                        value=${taskBengDt}
                        min=${projBgngDt} max=${projDdlnDt}
                      />
          </div>
          <div class="col-1 ms-0 mb-1" for="">
                  <span style="line-height:40px;">~</span>
          </div>
          <div class="col-4 mb-1 ps-0" for="">
                      <input
                        type="date"
                        id="taskUpdateDdlnDt"
                        name="taskDdlnDt"
                        class="form-control task textline"
                        style="width:140px;"
                        value=${taskDdlnDt}
                        min=${projBgngDt} max=${projDdlnDt}
                      />
                    </div>

                </div>
          </div>



          <div class="container">
          <div class="row">
            <div class="col-3">
                    <label>우선순위</label>
              </div>
              <div class="col-9 ">
                  <select class="textline mb-1 form-select task" id="taskUpdatePriority" name="taskStts">
                  </select>
          </div>
          </div>
          </div>

          <div class="container">
          <div class="row">
          <div class="col-3">
          <label>내용</label>
          </div>
          <div class="col-9">
                <textarea
                  class="form-control task mb-1 Cn textline"
                  id="taskUpdateCn"
                  name="taskCn"
                >${res.taskCn}</textarea>
          </div>
          </div>
          </div>
                <div class="modal-footer">
                  <button type="button" id="updateSaveBtn" class="btn bg msubBtn">저장</button>
                  <button
                    type="button"
                    class="btn bg mcanBtn"
                    data-bs-dismiss="modal"
                    style="border: 1px solid #344767;"
                  >
                    취소
                  </button>
                </div>
              </form>
            </div>
              `;

      $("#taskModalBody").html(modalHtml);
      getTeamMemTaskList(projNo, taskPics);
      setTimeout(() => {
        getCodeOptionOneSelected(
          "P005",
          "taskUpdatePriority",
          res.taskPriority
        );
        getCodeOptionOneSelected("P003", "taskUpdateStts", res.taskStts);
      }, 100);

      document.querySelector("#progress").addEventListener("input", (e) => {
        document.querySelector("#progressPer").innerHTML = e.target.value + "%";
      });

      $("#taskModal").modal("show");
    },
  });
}

// 일감 생성 모달
function insertTask(projNo, taskBengDt, taskDdlnDt, projBgngDt, projDdlnDt) {
  if (projBgngDt == null && projDdlnDt == null) {
    projBgngDt = convertDate(projBgngDt);

    projDdlnDt = convertDate(projDdlnDt);
  } else {
    projBgngDt = projBgngDt;
    projDdlnDt = projDdlnDt;
  }

  const modalHtml = `
          <div class="modal-header">
          <h5 class="modal-title font-weight-normal" id="taskinsertModalLabel">
            일감 등록하기
          </h5>
        </div>
        <div class="modal-body">
          <form>

          <div class="row">
            <div class="col-3">
        <label class="necessary">제목</label>
            </div>
            <div class="col-9">
                <input
                  type="text"
                  id="taskinsertTitle"
                  name="taskTitle"
                  class="form-control task mb-1"
                />
            </div>
          </div>

          <div class="row">
            <div class="col-3">
              <label>상위 일감 선택</label>
            </div>
            <div class="col-9">
                <select class="form-select task mb-1" id="taskInsertTaskNo" name="taskNo">

                </select>
            </div>
          </div>

          <div class="row">
            <div class="col-3">
        <label class="necessary">상태</label>
            </div>
            <div class="col-9">
              <select class="form-select task mb-1" id="taskinsertStts" name="taskStts">

              </select
            </div>
          </div>
          </div>


          <div class="row">
            <div class="col-3">
        <label class="necessary">담당자</label>
            </div>
            <div class="col-9">
                <select class="form-select task mb-1" multiple="true" id="taskInsertPic" name="taskStts">

                </select>
            </div>
          </div>

        <div class="row">
        <div class="col-3">
                <label class="necessary">날짜</label>
            </div>
        <div class="col-4 mb-1">
                  <input
                    type="date"
                    name="taskBengDt"
                    id="taskinsertBengDt"
                    class="form-control task textline mb-1"
                    style="width:140px;"
                    value=${taskBengDt}
                    min=${projBgngDt} max=${projDdlnDt}
                  />
        </div>
        <div class="col-1 ms-0 mb-1">
              <span style="line-height:40px;">~</span>
        </div>
        <div class="col-4 mb-1">
                  <input
                    type="date"
                    id="taskinsertDdlnDt"
                    name="taskDdlnDt"
                    class="form-control task textline"
                    style="width:140px;"
                    value=${taskDdlnDt}
                    min=${projBgngDt} max=${projDdlnDt}
                  />
                </div>

            </div>




          <div class="row">
            <div class="col-3">
        <label class="necessary">진척도</label>
            </div>
            <div class="col-9">
            <div class="controllProgress" id="taskinsertSttrDiv">
                  <input class="progress-bar bg-info controllInput" type="range" min="1" max="100" id="progress">
                  <div id="progressPer"></div>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-3">
        <label class="necessary">우선순위</label>
            </div>
            <div class="col-9">
              <select class="form-select task mb-1" id="taskinsertPriority" name="taskStts">

                </select>
            </div>
          </div>

          <div class="row">
            <div class="col-3">
        <label class="necessary">내용</label>
            </div>
            <div class="col-9">
            <textarea
                class="form-control task mb-1 Cn"
                id="taskinsertCn"
                name="taskCn"
              ></textarea>
            </div>
          </div>


            <div class="modal-footer">
              <button type="button" id="insertSaveBtn" class="btn bg msubBtn">저장</button>
              <button
                type="button"
                class="btn bg mcanBtn"
                data-bs-dismiss="modal"
              >
                취소
              </button>
            </div>
          </form>
        </div>
          `;

  $("#taskModalBody").html(modalHtml);

  document.querySelector("#progressPer").innerHTML = 0 + "%";

  getUpperTaskNo(projNo);
  getTeamMemList(projNo);
  setTimeout(() => {
    getCodeOption("P005", "taskinsertPriority");
    getCodeOption("P003", "taskinsertStts");
  }, 100);
  document.querySelector("#progress").addEventListener("input", (e) => {
    document.querySelector("#progressPer").innerHTML = e.target.value + "%";
  });

  $("#taskModal").modal("show");
  autoComplete();
}

// 업무 삭제
function deleteTask(taskNo, header, token) {
  console.log("deleteTask ----", taskNo);

  Swal.fire({
    title: "삭제하시겠습니까?",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
    confirmButtonText: "확인",
    cancelButtonText: "취소",
  }).then((result) => {
    if (result.value) {
      $.ajax({
        url: "/pms/project/taskDelete",
        data: JSON.stringify({
          taskNo: taskNo,
        }),
        type: "delete",
        dataType: "text",
        contentType: "application/json;charset=utf-8",
        beforeSend: function (xhr) {
          xhr.setRequestHeader(header, token);
        },
        success: function (res) {
          console.log("삭제성공", taskNo);
          $("#taskModal").modal("hide");
        },
        error: function (request, status, error) {
          console.log("code: " + request.status);
          console.log("message: " + request.responseText);
          console.log("error: " + error);
        },
      });
    }
  });
}

// 업데이트 버튼 눌렀을때 발생하는 이벤트
function updateTaskSave(taskNo, header, token) {
  console.log("UpdateTask ----", taskNo);
  const taskTitle = $("#taskUpdateTitle").val();
  const taskStts = $("#taskUpdateStts").val();
  const taskUpdatePic = $("#taskUpdatePic").val();
  const taskUpdateSttr = $("#taskUpdateSttr").text();
  const taskSttr = parseInt(taskUpdateSttr, 10);
  const taskBengDt = $("#taskUpdateBengDt").val().replace(/-/g, "");
  const taskDdlnDt = $("#taskUpdateDdlnDt").val().replace(/-/g, "");
  const taskPriority = $("#taskUpdatePriority").val();
  const taskCn = $("#taskUpdateCn").val();

  let asgList = taskUpdatePic.map(function (item) {
    return { stuNo: item, taskNo: taskNo };
  });

  const data = {
    taskNo: taskNo,
    taskTitle: taskTitle,
    taskStts: taskStts,
    asgList: asgList,
    taskSttr: taskSttr,
    taskBengDt: taskBengDt,
    taskDdlnDt: taskDdlnDt,
    taskPriority: taskPriority,
    taskCn: taskCn,
  };

  console.log(JSON.stringify(data));

  $.ajax({
    url: "/pms/project/updateTask",
    data: JSON.stringify(data),
    type: "put",
    contentType: "application/json;charset=utf-8",
    dataType: "text",

    beforeSend: function (xhr) {
      xhr.setRequestHeader(header, token);
    },
    success: function (res) {
      console.log("저장성공", taskNo);
      $("#taskModal").modal("hide");
      getCalander(projNo);
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
// 일감 생성 저장 버튼 눌렀을 때 이벤트
function insertTaskSave(projNo, header, token) {
  console.log("insertTask ----", projNo);

  const taskTitle = $("#taskinsertTitle").val();
  const taskStts = $("#taskinsertStts").val();
  const taskInsertPic = $("#taskInsertPic").val();
  const progress = $("#progress").val();
  const taskBengDt = $("#taskinsertBengDt").val().replace(/-/g, "");
  const taskDdlnDt = $("#taskinsertDdlnDt").val().replace(/-/g, "");
  const taskPriority = $("#taskinsertPriority").val();
  const taskCn = $("#taskinsertCn").val();
  const upperTask = $("#taskInsertTaskNo").val();

  let asgList = taskInsertPic.map(function (item) {
    return { stuNo: item };
  });

  let backgroundColor;
  let borderColor = "white";

  if (taskPriority == "P005-1") {
    backgroundColor = "#56726A";
  } else if (taskPriority == "P005-2") {
    backgroundColor = "#465B8A";
  } else if (taskPriority == "P005-3") {
    backgroundColor = "#D48834";
  } else if (taskPriority == "P005-4") {
    backgroundColor = "#D71923";
  }

  let end = parseInt(taskDdlnDt) + 1;
  console.log(end);
  end = String(end);

  calendar.addEvent({
    title: taskTitle,
    start: taskBengDt,
    end: end,
    backgroundColor: backgroundColor,
    borderColor: borderColor,
  });

  const data = {
    projNo: projNo,
    taskTitle: taskTitle,
    taskStts: taskStts,
    asgList: asgList,
    taskSttr: progress,
    taskBengDt: taskBengDt,
    taskDdlnDt: taskDdlnDt,
    taskPriority: taskPriority,
    taskCn: taskCn,
    upperTask: upperTask,
  };

  console.log(JSON.stringify(data));

  Swal.fire({
    title: "저장하시겠습니까?",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
    confirmButtonText: "확인",
    cancelButtonText: "취소",
  }).then((result) => {
    if (result.isConfirmed) {
      $.ajax({
        url: "/pms/project/insertTask",
        data: JSON.stringify(data),
        type: "post",
        contentType: "application/json;charset=utf-8",
        dataType: "text",

        beforeSend: function (xhr) {
          xhr.setRequestHeader(header, token);
        },
        success: function (res) {
          console.log(res, projNo);
          $("#taskModal").modal("hide");
          Swal.fire({
            icon: "success",
            title: "저장되었습니다.",
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
}

// 생성버튼
document.addEventListener("click", function (event) {
  if (event.target.id === "insertTaskBtn") {
    insertTask(projNo);
  }
});

// 수정버튼
document.addEventListener("click", function (event) {
  if (event.target.id === "updateTaskBtn") {
    const taskNo = document.getElementById("taskDetailtaskNo").innerText;
    console.log("updateTask : " + taskNo);
    updateTask(taskNo, null, null, projBgngDt, projDdlnDt);
  }
});

const autoComplete = () => {
  $(document).keydown(function (event) {
    if (event.keyCode == "220") {
      taskAutoComplete();
    }
  });
};

const taskAutoComplete = () => {
  document.getElementById("taskinsertTitle").value = "프로세스 흐름도 설계"; // 나중에 고쳐야함
  document.getElementById("taskinsertStts").value = "P003-1";
  $("#taskInsertPic").val("S2301201");
  document.getElementById("progress").value = 40;
  document.getElementById("progressPer").innerHTML = "40%";
  document.getElementById("taskinsertPriority").value = "P005-3";
  document.getElementById("taskinsertCn").innerText =
    "프로세스 흐름도를 설계해주세요"; // 나중에 고쳐야함
  document.getElementById("taskInsertTaskNo").value = "T423"; // 나중에 고쳐야함
};

const insertValidation = () => {
  const title = document.getElementById("taskinsertTitle").value;
  const status = document.getElementById("taskinsertStts").value;
  const assignee = $("#taskInsertPic").val();
  const startDate = document.getElementById("taskinsertBengDt").value;
  const endDate = document.getElementById("taskinsertDdlnDt").value;
  const progress = document.getElementById("progress").value;
  const priority = document.getElementById("taskinsertPriority").value;
  const content = document.getElementById("taskinsertCn").value;

  console.log("assignee : ", assignee.length);

  // Validation logic for each field
  if (title.trim() === "") {
    Swal.fire({
      icon: "error",
      title: "제목은 필수입니다.",
    });
    return false;
  }

  if (title.length >= 14 && title.length <= 6) {
    Swal.fire({
      icon: "error",
      title: "제목은 5자 이상, 14자 이하만 가능합니다.",
    });
    return false;
  }

  if (status === "") {
    Swal.fire({
      icon: "error",
      title: "상태값은 필수입니다.",
    });
    return false;
  }

  if (assignee.length === 0) {
    Swal.fire({
      icon: "error",
      title: "담당자는 필수입니다.",
    });
    return false;
  }

  if (assignee.length > 4) {
    Swal.fire({
      icon: "error",
      title: "담당자는 3인 이하만 선택 가능합니다.",
    });
    return false;
  }

  if (startDate === "" || endDate === "") {
    Swal.fire({
      icon: "error",
      title: "시작일과 마감일을 선택하세요.",
    });
    return false;
  }

  if (new Date(startDate) > new Date(endDate)) {
    Swal.fire({
      icon: "error",
      title: "시작일이 마감일보다 빠를 수 없습니다.",
    });
    return false;
  }

  if (progress === "") {
    Swal.fire({
      icon: "error",
      title: "진척도를 입력하세요.",
    });
    return false;
  }

  if (priority === "") {
    Swal.fire({
      icon: "error",
      title: "우선순위를 선택하세요.",
    });
    return false;
  }

  if (content.trim() === "") {
    Swal.fire({
      icon: "error",
      title: "내용을 입력하세요.",
    });
    return false;
  }

  if (content.length >= 30 && content.length <= 6) {
    Swal.fire({
      icon: "error",
      title: "내용은 5자 이상, 30자 이하만 가능합니다.",
    });
    return false;
  }

  return true;
};
