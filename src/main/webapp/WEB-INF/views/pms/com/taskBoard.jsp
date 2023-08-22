<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<script src="${pageContext.request.contextPath}/common/sw/js/PmsProjectJs.js"></script>
<script src="${pageContext.request.contextPath}/common/sw/js/CommonCode.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<c:set var="projNo" value="${projNo}" />
<c:set var="userNo" value="${userNo}" />
<c:set var="userVo" value="${userVo}" />
<style>
  /*   /* 헤더 텍스트 가운데 정렬 */
  .centered {
    .ag-header-cell-label {
      justify-content: center !important;
    }
  }

  /* AG 그리드 헤더 색상변경 */
  /*   .ag-header-viewport {
    background-color: #d7d7d7;
  } */

  .ag-header-cell-label {
    justify-content: center;
  }

  /* 그리드 내용 가운데 정렬 */
  .ag-row .ag-cell {
    display: flex;
    justify-content: center !important;
    /* align horizontal */
    align-items: center !important;
    /* align-content: center; */
  }

  .ag-header-cell-text {
    margin-left: 40px !important;
  }

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

  .textline {
    border: 1px solid #e5e5e5;
  }

  .search {
    border: 1px solid gray;
  }

  label.necessary::after {
    content: "*";
    color: red;
    margin-left: 4px;
  }

  .form-control {
    border: 1px solid #d2d6da;
  }
</style>

<link
  rel="stylesheet"
  href="${pageContext.request.contextPath}/common/sw/css/PmsProjectCss.css"
/>

<div class="card mt-3">
  <div class="card-body">
    <div class="row">
      <div class="col-8 pe-2">
        <button
          type="button"
          id="insertTaskBtn"
          class="btn btn-outline-secondary msubBtn"
        >
          등록
        </button>
        <button
          onclick="onBtPrint()"
          class="ms-3 btn btn-outline-secondary msubBtn"
        >
          프린트
        </button>
      </div>

      <div class="col-4 ps-1" style="border: none">
        <div
          class="d-flex justify-content-end border rounded bg-white"
          style="border: none"
        >
          <input
            type="text"
            class="form-control"
            style="border: none"
            oninput="onQuickFilterChanged()"
            id="searchFilter"
            placeholder="통합검색"
          />
          <button
            type="button"
            id="searchBtn"
            class="w-10 btn btn-default mb-0 search"
          >
            <i class="fas fa-search" aria-hidden="true"></i>
          </button>
        </div>
      </div>
    </div>

    <div class="row">
      <div
        id="myGrid"
        style="height: 624px; width: 100%"
        class="ag-theme-alpine"
      ></div>
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

<script src="https://cdn.jsdelivr.net/npm/ag-grid-community/dist/ag-grid-community.min.js"></script>
<script>
  const projNo = "${projNo}";
  const userNm = "${userNm}";
  const userVo = "${userVo}";
  const projNm = "${projNm}";

  console.log("projNm", projNm);

  // 데이터 보내고 싶을 때 사용 , handleTextMessage로 전송
  //서버로 메세지 전달하는 함수
  function sendMsg(msg) {
    if (!msg) {
      webSocket.send("연결성공");
      return;
    }
    webSocket.send(msg);
    console.log("msg : ", msg);
  }

  //서버에서 발행된 헤더네임과 토큰갑사 저장
  var header = "${_csrf.headerName}";
  var token = "${_csrf.token}";

  //바닐라 자바스크립트 사용시 AJAX send 전에 헤더값 세팅 필요
  //xhr.setRequestHeader(header, token);

  let projBgngDt = "";
  let projDdlnDt = "";

  function onQuickFilterChanged() {
    gridOptions.api.setQuickFilter(
      document.querySelector("#searchFilter").value
    );
  }

  const columnDefs = [
    {
      field: "taskTitle",
      headerName: "업무명",
      maxWidth: 150,
    },
    {
      field: "taskStts",
      headerName: "상태",
      cellStyle: { textAlign: "center" },
      maxWidth: 150,
    },
    {
      field: "taskPriority",
      headerName: "우선순위",
      cellStyle: { textAlign: "center" },
      maxWidth: 150,
    },
    {
      field: "taskBengDt",
      headerName: "시작일",
      cellStyle: { textAlign: "center" },
      maxWidth: 150,
    },
    {
      field: "taskDdlnDt",
      headerName: "마감일",
      cellStyle: { textAlign: "center" },
      maxWidth: 150,
    },
    {
      field: "taskSttr",
      headerName: "전척도",
      cellStyle: { textAlign: "center" },
      maxWidth: 150,
    },
    {
      field: "userNms",
      headerName: "담당자",
      cellStyle: { textAlign: "center" },
      maxWidth: 160,
    },
  ];

  const rowData = [];

  function getData(projNo) {
    $.ajax({
      url: "/pms/project/taskListOut?${_csrf.parameterName}=${_csrf.token}",
      data: {
        projNo: projNo,
      },
      type: "POST",
      dataType: "json",
      success: function (res) {
        console.log("넘어온 데이터", res);

        for (let i = 0; i < res.length; i++) {
          res[i].taskSttr = res[i].taskSttr + "%";
        }

        projBgngDt = res[0].projBgngDt;
        projDdlnDt = res[0].projDdlnDt;

        const updatedRes = res.map((data) => {
          const userNms = data.asgList.map((item) => item.userNm);
          return { ...data, userNms };
        });

        gridOptions.api.setRowData(updatedRes);
      },
      error: function (xhr, status, error) {
        console.error(error);
      },
    });
  }

  const gridOptions = {
    defaultColDef: {
      enableRowGroup: true,
      enablePivot: true,
      enableValue: true,
      sortable: true,
      resizable: true,
      filter: true,
      minWidth: 100,
    },
    rowHeight: 52.3,
    suppressRowClickSelection: true,
    groupSelectsChildren: true,
    columnDefs: columnDefs,
    rowData: rowData,
    rowSelection: "multiple",
    rowGroupPanelShow: "always",
    pivotPanelShow: "always",
    animateRows: true,
    pagination: true,
    paginationPageSize: 10,
    onCellClicked: (params) => {
      console.log("등록한 데이터 tr", params);

      detailTask(params.data.taskNo);
    },
  };

  document.addEventListener("DOMContentLoaded", () => {
    const gridDiv = document.querySelector("#myGrid");
    new agGrid.Grid(gridDiv, gridOptions);
    getData(projNo);
  });

  // 삭제버튼
  document.addEventListener("click", function (event) {
    if (event.target.id === "deleteTaskBtn") {
      const taskNo = document.getElementById("taskDetailtaskNo").innerText;
      deleteTask(taskNo, header, token);
    }
  });

  // 수정 저장 버튼
  document.addEventListener("click", function (event) {
    if (event.target.id === "updateSaveBtn") {
      const taskNo = document.getElementById("taskUpdatetaskNo").innerText;
      console.log("updateSaveTask : " + taskNo);
      updateTaskSave(taskNo, header, token);
    }
  });

  //일감 저장 버튼

  document.addEventListener("click", function (event) {
    if (event.target.id === "insertSaveBtn") {
      if (insertValidation()) {
        insertTaskSave(projNo, header, token);
      }
    }
  });

  function onBtPrint() {
    const api = gridOptions.api;

    setPrinterFriendly(api);

    setTimeout(function () {
      print();
      setNormal(api);
    }, 1000);
  }

  function setPrinterFriendly(api) {
    const eGridDiv = document.querySelector("#myGrid");
    eGridDiv.style.width = "";
    eGridDiv.style.height = "";
    api.setDomLayout("print");
  }

  const alarm = (HourMinute, taskTitle) => {
    console.log("HourMinute,taskTitle!!!!!!!!!!!!!!!! ", HourMinute, taskTitle);

    sendMsg(
      `새로운 일감,\${projNo},\${userVo.userNm},\${userVo.userProfile},HourMinute,\${projNm},일감 게시판,\${stuNo},\${taskTitle}`
    );
    console.log("taskTitle!!!!!!!!!!!!!!!!!!!!!!!: ", taskTitle);
  };
</script>
