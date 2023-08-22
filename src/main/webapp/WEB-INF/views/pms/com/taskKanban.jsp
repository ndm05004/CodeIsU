<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<script src="${pageContext.request.contextPath}/common/sw/js/CommonCode.js"></script>

<style>
  #myKanban {
    overflow-x: auto;
    padding: 20px 0;
    height: 700px;
  }

  .success {
    background: #00b961;
  }

  .info {
    background: #2a92bf;
  }

  .warning {
    background: #f4ce46;
  }

  .error {
    background: #fb7d44;
  }

  .custom-button {
    background-color: #4caf50;
    border: none;
    color: white;
    padding: 7px 15px;
    margin: 10px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
  }

  .pre {
    width: 50px;
    height: 50px;
  }

  .circle {
    width: 20px;
    height: 20px;
    border-radius: 50%;
  }

  .kanban-item {
    background-color: transparent;
    padding: 0;
  }

  .card .card-header {
    padding: 0.32rem;
  }

  .kanban-container {
    height: 500px;
  }

  .border-success {
    border-color: #4caf50 !important;
    width: 300px !important;
  }

  .kanban-board.card {
    width: 330px !important;
  }

  .kanban-drag {
    overflow: hidden;
  }

  .task {
    background-color: #f4f2f2;
  }
  .taskCn {
    background-color: #f4f2f2;
  }
</style>
<link
  rel="stylesheet"
  href="${pageContext.request.contextPath}/common/sw/css/jkanban.min.css"
/>
<script src="${pageContext.request.contextPath}/common/sw/js/jkanban.js"></script>

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
    <div id="myKanban"></div>
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

<!-- <button id="addDefault">Add "Default" board</button>
<br />
<button id="addToDo">Add element in "To Do" Board</button>
<br />
<button id="addToDoAtPosition">
  Add element in "To Do" Board at position 2
</button>
<br />
<button id="removeBoard">Remove "Done" Board</button>
<br />
<button id="removeElement">Remove "My Task Test"</button> -->

<script>
  projNo = "${projNo}";

  var header = "${_csrf.headerName}";
  var token = "${_csrf.token}";

  function getData(projNo) {
    $.ajax({
      url: "/pms/project/taskListOut?${_csrf.parameterName}=${_csrf.token}",
      data: {
        projNo: projNo,
      },
      type: "POST",
      dataType: "json",
      success: function (res) {
        let wait = [];
        let work = [];
        let done = [];
        let postpone = [];

        res = res.map((data) => {
          const userNms = data.asgList.map((item) => item.userNm);
          return { ...data, userNms };
        });

        console.log("넘어온 데이터 : ", res);

        for (let i = 0; i < res.length; i++) {
          let profile = "";

          for (let j = 0; j < res[i].asgList.length; j++) {
            profile += `
            <a href="javascript:;" class="avatar avatar-xs rounded-3" data-bs-toggle="tooltip" data-bs-placement="bottom" aria-label=\${res[i].asgList[j].userNm} data-bs-original-title=\${res[i].asgList[j].userNm} >
             <img src="\${res[i].asgList[j].userProfile}" class="avatar avatar-sm rounded-3">
            </a>
            `;
          }

          const taskStts = res[i].taskStts;

          let priorityStyle = "";

          if (res[i].taskPriority === "낮음") {
            priorityStyle = 'style="background-color:#56726a"';
          } else if (res[i].taskPriority === "보통") {
            priorityStyle = 'style="background-color:#465b8a"';
          } else if (res[i].taskPriority === "높음") {
            priorityStyle = 'style="background-color:#d48834"';
          } else {
            priorityStyle = 'style="background-color:#d71923"';
          }

          title = `
          <div class="card border-success">
              <div class="card-header m-0 item_handle drag_handler" \${priorityStyle}>
              </div>
              <div class="card-body pt-2">
                <div class="row">
                  <div class="col-md-3 ps-0">
                    <div class="avatar-group mt-2">
                      \${profile}
                    </div>
                    </div>
                  <div class="col-md-9">
                    <div class="row text-sm">
                      담당자 : \${res[i].userNms}
                    </div>
                    <div class="row text-xs">
                      기한 : \${res[i].taskBengDt} ~ \${res[i].taskDdlnDt}
                    </div>
                </div>

                  <div class="row text-sm">
                    <div class="col-1 ps-0">
                      <i class="material-icons opacity-10 iconBtn save">work</i>
                    </div>
                    : \${res[i].taskTitle}
                    <input type="hidden" class="taskNo" value=\${res[i].taskNo}>
                  </div>

                  <div class="row pe-0">
                   <div class="progress-wrapper ps-0 pe-0">
                   <div class="progress-info">
                     <div class="progress-percentage">
                       <span class="text-sm font-weight-normal">\${res[i].taskSttr}%</span>
                     </div>
                   </div>
                   <div class="progress">
                     <div class="progress-bar bg-info" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: \${res[i].taskSttr}%;"></div>
                   </div>
                 </div>
                  </div>
                </div>
              </div>
          </div>
          `;
          const htmlTemplate = {
            title: title,
          };

          switch (taskStts) {
            case "대기":
              wait.push(htmlTemplate);
              break;
            case "진행":
              work.push(htmlTemplate);
              break;
            case "완료":
              done.push(htmlTemplate);
              break;
            case "지연":
              postpone.push(htmlTemplate);
              break;
            default:
              // Handle any other cases if necessary
              break;
          }
        }

        var KanbanTest = new jKanban({
          element: "#myKanban",
          gutter: "10px",
          widthBoard: "370px",
          itemHandleOptions: {
            enabled: true,
          },
          click: function (el) {
            let taskNo = el.querySelector(".taskNo").value;
            console.log("el : ", el);
            console.log("taskNo : ", taskNo);
            detailTask(taskNo);
          },
          dropEl: function (el, target, source, sibling) {
            console.log("drop 으로 옴김");
            console.log("el(옴기는 element) : ", el);
            console.log("target.parentElement : ", target.parentElement);

            const parent = target.parentElement;
            const dataIdValue = parent.getAttribute("data-id");
            let getCmCd = "";
            let taskNo = el.querySelector(".taskNo").value;

            console.log("taskNo : ", taskNo);

            if (dataIdValue == "_wait") {
              getCmCd = "P003-1";
            } else if (dataIdValue == "_working") {
              getCmCd = "P003-2";
            } else if (dataIdValue == "_done") {
              getCmCd = "P003-4";
            } else {
              getCmCd = "P003-3";
            }

            console.log("getCmCd : ", getCmCd);

            console.log("el : ", el);
            console.log("taskNo : ", taskNo);

            let data = {
              taskNo: taskNo,
              taskStts: getCmCd,
            };

            $.ajax({
              url: "/pms/project/moveboard",
              type: "PUT",
              data: JSON.stringify(data),
              dataType: "text",
              contentType: "application/json;charset=utf-8",
              beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
              },
              success: function (res) {
                console.log(res);
              },
              error: function (err) {
                console.log(err);
              },
            });
          },
          buttonClick: function (el, boardId) {
            console.log("버튼클릭");
          },
          /*
          ,
          itemAddOptions: {
            enabled: true,
            content: "+ Add New Card",
            class: "custom-button",
            footer: true,
          }
          */ boards: [
            {
              id: "_wait",
              title: "상태 : 대기",
              class: "P003-1",
              item: wait,
            },
            {
              id: "_working",
              title: "상태 : 진행중",
              class: "P003-2",
              item: work,
            },
            {
              id: "_done",
              title: "상태 : 완료",
              class: "P003-4",
              item: done,
            },
            {
              id: "_postPone",
              title: "상태 : 지연",
              class: "P003-3",
              item: postpone,
            },
          ],
        });

      },
    });
  }

  getData(projNo);

  const kanbanRender = () => {
    $("#myKanban").empty();
    getData(projNo);
  };

  const getAsgList = (asgList) => {
    let taskPics = "";

    for (let i = 0; i < asgList.length; i++) {
      taskPics += asgList[i].userNm + " ";
    }
    console.log(taskPics);
    return taskPics;
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
  function detailTask(taskNo) {
    $.ajax({
      url: "/pms/project/taskDetail",
      data: {
        taskNo: taskNo,
      },
      type: "get",
      dataType: "json",
      success: function (res) {
        console.log("res : : : ", res);

        const taskBengDt = convertDate(res.taskBengDt);
        const taskDdlnDt = convertDate(res.taskDdlnDt);
        let taskPics = getAsgList(res.asgList);

        let modalHtml = `
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
	                   <p id="taskDetailTitle" name="taskTitle" class="form-control task mb-1">\${res.taskTitle}</p>
                 	 </div>
                 	</div>
                  </div>

 				<div class="container">
                   <div class="row">
	                 <div class="col-3">
                  		<label class="" for="taskDetailBengDt">날짜</label>
	                 </div>
	                 <div class="col-4">
	                    <p name="taskBengDt" id="taskDetailBengDt" class="form-control text-center task mb-1 me-2">\${taskBengDt}</p>
	                 </div>
	                 <div class="col-1">
	                    <span style="line-height:40px;">-</span>
	                 </div>
	                 <div class="col-4">
	                    <p id="taskDetailDdlnDt" name="taskDdlnDt" class="form-control text-center task mb-1 ms-0">\${taskDdlnDt}</p>
                	 </div>
                  </div>
               </div>

			  	<div class="container">
                   <div class="row">
	                 <div class="col-3">
	                	<label>담당자</label>
				     </div>
	                 <div class="col-9">
	                	<p name="taskPic" id="taskDetailPic" class="form-control task mb-1"> \${taskPics}</p>
				 	 </div>
				  </div>
				</div>

			   <div class="container">
                   <div class="row">
	                 <div class="col-3">
                  	   <label class="" for="taskDetailPriority">우선순위</label>
                     </div>
	                 <div class="col-9">
                   	   <p class="form-control task mb-1"id="taskDetailPriority" name="taskPriority" aria-label="Default select example">\${res.taskPriority}</p>
                     </div>
				  </div>
			   </div>

			   <div class="container">
                   <div class="row">
	                 <div class="col-3">
	         			<label class="" for="taskDetailStts">상태</label>
	         		 </div>
	                 <div class="col-9">
	                	<p class="form-control task mb-1" id="taskDetailStts" name="taskStts">\${res.taskStts}</p>
				  	 </div>
				  </div>
			   </div>

			   <div class="container">
                   <div class="row">
	                 <div class="col-3">
	               		<label class="" for="taskDetailtaskNo">업무번호</label>
	               	 </div>
	                 <div class="col-9">
	                	<p id="taskDetailtaskNo" name="taskNo"  class="form-control task mb-1" >\${res.taskNo}</p>
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
			                  <div class="progress-bar bg-info" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: \${res.taskSttr}%;">
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
	               		<p name="taskRegDt" id="taskDetailRegDt"  class="form-control task mb-1" >\${res.taskRegDt}</p>
	               	 </div>
	               </div>
			    </div>

				<div class="container">
                   <div class="row">
	                 <div class="col-3">
	              	  	<label class="" for="">내용</label>
	              	 </div>
	                 <div class="col-9">
			           <p  id="taskDetailCn" name="taskCn" class="form-control task Cn">\${res.taskCn}</p>
					 </div>
	              </div>
	            </div>


                <div class="modal-footer">
                  <button
                    type="button"
                    class="btn bg mcanBtn"
                    data-bs-dismiss="modal" style="border: 1px solid #56726a;"

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
</script>
