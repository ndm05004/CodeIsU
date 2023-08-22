<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!-- <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script> -->
<script src="${pageContext.request.contextPath}/common/sw/js/PmsProjectJs.js"></script>
<script src="${pageContext.request.contextPath}/common/sw/js/PmsDashBoardJs.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.6/Chart.bundle.js"></script>
<script src="${pageContext.request.contextPath}/common/sw/js/CommonCode.js"></script>
<style>
  #mouseHover {
    background: darkred;
    width: 400px;
    height: 400px;
    line-height: 400px;
    text-align: center;
    color: #fff;
    font-size: 20px;
    margin: 0 auto;
  }

  .topTaskAndIssue {
    font-size: 13px !important;
    color: #7b809a !important;
  }

  .taskAndIssueBody {
    padding: 0.5rem !important;
  }

  .table td .progress .progress-bar {
    height: 8px !important;
  }

  .table td .progress {
    height: 8px;
    margin: 0;
  }

  .menagement {
    height: 238px
  }

  .mytd {
    height: 55px;
  }

  /* Add the additional styling required for the scrollable table */
  .card.menagement {
    padding: 15px;
  }

  .table-responsive {
    overflow-x: auto;
  }

  .table {
    width: 100%;
    border-collapse: collapse;
  }

  th,
  td {
    padding: 10px;
    border-bottom: 1px solid #ddd;
  }

  th {
    position: sticky;
    top: 0;
    background-color: #f9f9f9;
  }

  /* Optional: Add styling for scrollbar */
  .table-responsive::-webkit-scrollbar {
    width: 12px;
  }

  .table-responsive::-webkit-scrollbar-thumb {
    background-color: #888;
    border-radius: 10px;
  }

  .table-responsive::-webkit-scrollbar-thumb:hover {
    background-color: #555;
  }

  .tdTitle {
    font-weight: var(--bs-nav-link-font-weight) !important;
    font-size: 13px !important;
    background: white;
  }

  .modal {
    --bs-modal-width: 510px;
  }

  .img-thumbnail{
    height: 120px;
  }


</style>

<div class="card mt-3 ps-3 mb-2" id="dashBoardHeader">
  <div class="table-responsive container">
    <div class="row pt-3">
      <div class="col-10">
        <span class="h4" id="projTitle"></span>
        <span
          class="fs-6 ms-3 ps-2 pe-2 pt-1 pb-1"
          style="font-size: 12px"
          id="projSttsCd"
        ></span>
      </div>
    </div>
    <div class="row">
      <div class="col" style="color: #979797">
        <span class="fs-6" id="projDate1"></span> ~
        <span class="fs-6" id="projDate2"></span>
      </div>
    </div>
    <div class="row pt-2 mb-2">
      <div class="col fs-6 mouseHover" id="projExpln"></div>
    </div>

    <div class="row pt-2 mb-2">
      <div class="col-6">
        <span class="fs-6 float-start" id="projTech2">
          <i class="mt-2 fas fa-laptop-code"></i>
        </span>
        <span class="fs-6 ps-2" id="projTech"></span>
      </div>

      <div class="col-6">
        <div class="position-relative" id="projectProgress"></div>
      </div>
    </div>
  </div>
</div>

<div class="row g-3 mb-2 row-deck">
  <div class="col-md-12 col-lg-4 col-xl-4 col-xxl-4">
    <div class="card">
      <div class="card-body" id="projectSttr">1</div>
    </div>
  </div>

  <div class="col-md-12 col-lg-4 col-xl-4 col-xxl-4">
    <div class="card">
      <div class="card-body" id="projectWork"></div>
    </div>
  </div>
  <div class="col-md-12 col-lg-4 col-xl-4 col-xxl-4">
    <div class="card">
      <div class="card-body" id="projectIssue">
        3
        <div>
          <div>진행상태</div>
        </div>
        <div>
          <div>차트자리</div>
        </div>
        <div>남은일</div>
      </div>
    </div>
  </div>
</div>

<div class="row g-3 mb-2 row-deck">
  <div class="col-md-12 col-lg-8 col-xl-8 col-xxl-8">
    <div class="card menagement">
      <div class="table-responsive">
        <table class="table align-items-center mb-0">
          <thead>
            <tr>
              <th class="tdTitle" style="width: 18%; background: white;">이름</th>
              <th class="ps-2 tdTitle" style="width: 10%; background: white;">직책</th>
              <th class="ps-2 tdTitle" style="width: 70%; background: white;">
                <div class="row">
                  <div class="col-1"></div>
                  <div class="col-9">진척도</div>
                </div>
              </th>
              <th class="ps-4 tdTitle" style="background: white;">상세보기</th>
            </tr>
          </thead>
          <tbody id="projectMemberList"></tbody>
        </table>
      </div>
    </div>
  </div>

  <div class="col-md-12 col-lg-4 col-xl-4 col-xxl-4">
    <div class="card menagement">
      <div class="card-body taskAndIssueBody">
        <div id="sttrStatistics"></div>

        <nav>
          <div class="nav nav-tabs" id="nav-tab" role="tablist">
            <button
              class="nav-link active topTaskAndIssue"
              id="nav-home-tab"
              data-bs-toggle="tab"
              data-bs-target="#nav-home"
              type="button"
              role="tab"
              aria-controls="nav-home"
              aria-selected="true"
            >
              내 최근 일감
            </button>
            <button
              class="nav-link topTaskAndIssue"
              id="nav-profile-tab"
              data-bs-toggle="tab"
              data-bs-target="#nav-profile"
              type="button"
              role="tab"
              aria-controls="nav-profile"
              aria-selected="false"
            >
              내 최근 이슈
            </button>
          </div>
        </nav>
        <div class="tab-content" id="nav-tabContent">
          <div
            class="tab-pane fade show active"
            id="nav-home"
            role="tabpanel"
            aria-labelledby="nav-home-tab"
          >
            <div class="table-responsive">
              <table class="table align-items-center mb-0">

                <thead>
                  <tr>
                    <th class="tdTitle">일감명</th>
                    <th class="ps-2 tdTitle">상태</th>
                  </tr>
                </thead>

                <tbody id="topTaskList"></tbody>
              </table>
            </div>
          </div>
          <div
            class="tab-pane fade"
            id="nav-profile"
            role="tabpanel"
            aria-labelledby="nav-profile-tab"
          >
            <div class="table-responsive">
              <table class="table align-items-center mb-0">

                <thead>
                  <tr>
                    <th class="tdTitle">이슈명</th>
                    <th class="ps-2 tdTitle">상태</th>
                  </tr>
                </thead>

                <tbody id="topIssueList"></tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div
  class="modal fade"
  id="profileModal"
  role="dialog"
  aria-labelledby="profileModal"
  aria-hidden="true"
>
  <div class="modal-dialog d-flex justify-content-center" role="document">
    <div class="modal-content" id="profileModalBody">


      </div>
    </div>
  </div>








  <script>
    let projNo = "${projNo}";
    stuNo = "${userNo}";
    let ctxProject;

    console.log("projNo : : ", projNo);

    charPluginSettings();

    const projectChart = (data, backgroundColor, labels, text) => {
      var myChart = new Chart(ctxProject, {
        type: "doughnut",
        data: {
          labels: labels,
          datasets: [
            {
              data: data,
              backgroundColor: backgroundColor,
              borderColor: "white",
              borderWidth: 0,
              scaleBeginAtZero: true,
              hoverOffset: 6,
            },
          ],
        },
        options: {
          responsive: false,
          legend: {
            labels: {
              boxWidth: 16,
            },
          },
          elements: {
            center: {
              text: text,
              color: "black", // Default is #000000
              fontStyle: "Arial", // Default is Arial
              sidePadding: 20, // Default is 20 (as a percentage)
              minFontSize: 15, // Default is 20 (in px), set to false and text will not wrap.
              lineHeight: 25, // Default is 25 (in px), used for when text wraps
            },
          },
        },
      });
    };

    const getProjectInfo = (projNo) => {
      $.ajax({
        url: "/pms/project/projectInfo",
        data: {
          projNo: projNo,
        },
        type: "get",
        dataType: "json",
        success: function (res) {
          console.log("이것은 vo리스트:", res);
          console.log("projSttsCd 상태~~~~~~~~~~~:", res.projSttsCd);
          console.log("플젝 시작일~~~~~~~~~~~:", res.projBgngDt);

          let str = "";
          str += `
  			  	<div class="progress mb-3 ms-4 mt-3" style="width:85%;">
  		  		 <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: `;

          str += res.projSttr;
          str += `%;"></div></div>`;
          str += `
  			<sapn class="fs-6 position-absolute persent" style="top: -10px;right: 10px;}"></span>`;
          str += res.projSttr;
          str += `%
  			</div>
  			`;
          console.log("이것은 진행률:", res.projSttr);

          let expln = res.projExpln;

          if (expln.length > 140) {
            expln = expln.substring(0, 140) + "...";
          }

          $("#projectProgress").html(str);

          document.querySelector("#projExpln").title = res.projExpln;

          chatProjNm = res.projNm;

          $("#projTitle").text(res.projNm);
          $("#projSttsCd").text(res.projSttsCd);
          $("#projExpln").text(expln);
          $("#projTech").text(res.projTech);
          $("#progress").text(res.projSttr);
          $("#projDate1").text(res.projBgngDt);
          $("#projDate2").text(res.projDdlnDt);
        },
      });
    };

    getProjectInfo(projNo);

    const getProjectInfoChart = (projNo) => {
      $.ajax({
        url: "/pms/project/projectInfo",
        data: {
          projNo: projNo,
        },
        type: "get",
        dataType: "json",
        success: function (res) {
          console.log("프로젝트 정보", res);
          let projBgngDt = res.projBgngDt;
          let projDdlnDt = res.projDdlnDt;

          let sys = new Date();

          let lestDay = Date.parse(projDdlnDt) - sys;

          let daysLeft =
            Math.ceil(lestDay / (1000 * 60 * 60 * 24)) + " days left";

          str = `
            <div>
                <div class="itemHeader" id="projectHeader">

                </div>
            </div>
            <hr style="border: solid 1px black;">
            <div>
              <div>
                <div id="projectChartInner">
                </div>
                <canvas  id="projectChart"  width="309" height="190" style="width: 250px; height: 250px;">
                </canvas>
              </div>
            </div>
          `;

          // 차트 js 데이터 셋
          projSttr = [];
          lestStrr = 100 - res.projSttr;
          projSttr.push(res.projSttr);
          projSttr.push(lestStrr);

          backgroundColor = [];
          backgroundColor.push("#56726A");
          backgroundColor.push("#F2F3F6");

          labels = [];
          labels.push("진행", "미진행");
          // 데이터 셋 추가 완료

          text = "진행도\n" + res.projSttr + "%";
          console.log("project text : ", text);

          $("#projectSttr").html(str);
          $("#projectHeader").html("상태 : " + res.projSttsCd);

          ctxProject = document.getElementById("projectChart").getContext("2d");

          projectChart(projSttr, backgroundColor, labels, text);
        },
        error: function (xhr) {
          console.log("getProjectInfo 상태: " + xhr.status);
        },
      });
    };

    getProjectInfoChart(projNo);

    const getProjectTaskInfo = (projNo) => {
      $.ajax({
        url: "/pms/project/ProjectTaskInfo",
        data: {
          projNo: projNo,
        },
        type: "get",
        dataType: "json",
        success: function (res) {
          console.log("일감 정보", res);

          let complete = 0;
          let wait = 0;
          let progress = 0;
          let postpone = 0;

          let completeColor = "#E9D6C6";

          let waitColor = "#465B8A";

          let progressColor = "#56726A";

          let postponeColor = "#AA6062";
          if(res.length == 0){
            complete = 0;
            wait = 0;
            progress = 0;
            postpone = 0;
          }else{
            for (let i = 0; i < res.length; i++) {
              if (res[i].taskStts == "완료") {
                complete++;
              } else if (res[i].taskStts != "완료" && res[i].taskStts == "대기") {
                wait++;
              } else if (res[i].taskStts != "완료" && res[i].taskStts == "진행") {
                progress++;
              } else if (res[i].taskStts != "완료" && res[i].taskStts == "지연") {
                postpone++;
              }
            }
          }
          console.log('res.length =0')

          str = `
        <div>

            <div class="itemHeader" id="taskHeader">

            </div>
        </div>
        <hr style="border: solid 1px black;">
        <div>
          <div>
            <div id="projectTaskChartInner">
            </div>
            <canvas id="projectTaskChart" width="309" height="190" style="width: 250px; height: 250px;"></canvas>

          </div>
        </div>
      `;

          // 차트 js 데이터 셋
          projTaskSttr = [];
          projTaskSttr.push(complete, wait, progress, postpone);

          backgroundColor = [];
          backgroundColor.push(
            completeColor,
            waitColor,
            progressColor,
            postponeColor
          );

          labels = [];
          labels.push("완료", "대기", "진행", "지연");

          // 데이터 셋 추가 완료

          let allStts = complete + wait + progress + postpone;
          let taskStts = (complete / allStts) * 100;

          console.log('allStts : ', allStts)
          console.log('taskStts : ', taskStts)

          if(allStts === 0){
            taskStts = 0
            let defaultValue = 100;
            let defaultColor = "#F2F3F6";
            let defaultLabel = "해당없음"

            projTaskSttr.push(defaultValue);
            backgroundColor.push(defaultColor);
            labels.push(defaultLabel);
          }else{
            taskStts = (complete / allStts) * 100;
          }

          taskStts = Math.floor(taskStts);
          console.log('taskStts = Math.floor(taskStts);')



          console.log("taskStts : ", taskStts);

          text = "진행도\n" + taskStts + "%";

          let headerText = "일감상태  " + complete + "/" + allStts;

          $("#projectWork").html(str);
          $("#taskHeader").html(headerText);

          ctxProject = document
            .getElementById("projectTaskChart")
            .getContext("2d");

          projectChart(projTaskSttr, backgroundColor, labels, text);
        },
        error: function (xhr) {
          console.log("getProjectInfo 상태: " + xhr.status);
        },
      });
    };

    getProjectTaskInfo(projNo);

    const getProjectIssueInfo = (projNo) => {
      $.ajax({
        url: "/pms/project/getIssue",
        data: {
          projNo: projNo,
        },
        type: "get",
        dataType: "json",
        success: function (res) {
          console.log("이슈 정보", res);

          let complete = 0;
          let defect = 0;
          let modify = 0;

          let completeColor = "#E9D6C6";

          let modifyColor = "#56726A";

          let defectColor = "#AA6062";

          if(res.length != 0){
            for (let i = 0; i < res.length; i++) {
              if (res[i].issueSttsCd == "완료") {
                complete++;
              } else if (
                res[i].issueSttsCd != "완료" &&
                res[i].issueSttsCd == "결함"
              ) {
                defect++;
              } else if (
                res[i].issueSttsCd != "완료" &&
                res[i].issueSttsCd == "수정"
              ) {
                modify++;
              }
            }
          }

          str = `
        <div>

            <div class="itemHeader" id="issueHeader">

            </div>
        </div>
        <hr style="border: solid 1px black;">
        <div>
          <div>
            <div id="projectIssueChartInner">
            </div>
            <canvas id="projectIssueChart" width="309" height="190" style="width: 250px; height: 250px;">
            </canvas>
          </div>
        </div>
      `;

          // 차트 js 데이터 셋
          projTaskSttr = [];
          projTaskSttr.push(complete, modify, defect);

          backgroundColor = [];
          backgroundColor.push(completeColor, defectColor, modifyColor);

          labels = [];
          labels.push("완료", "수정", "결함");

          // 데이터 셋 추가 완료

          let allSttr = complete + defect + modify;
          let issueSttr =0;

          if(allSttr === 0){
            issueSttr = 0
            let defaultValue = 100;
            let defaultColor = "#F2F3F6";
            let defaultLabel = "해당없음"

            projTaskSttr.push(defaultValue);
            backgroundColor.push(defaultColor);
            labels.push(defaultLabel);

          }else{
            issueSttr = (complete / allSttr) * 100;
            issueSttr = Math.floor(issueSttr);
          }

          console.log("taskStts : ", issueSttr);

          text = "진행도\n" + issueSttr + "%";

          let headerText = "이슈상태  " + complete + "/" + allSttr;

          $("#projectIssue").html(str);
          $("#issueHeader").html(headerText);

          ctxProject = document
            .getElementById("projectIssueChart")
            .getContext("2d");

          projectChart(projTaskSttr, backgroundColor, labels, text);


        },
        error: function (xhr) {
          console.log("getProjectInfo 상태: " + xhr.status);
        },
      });
    };

    getProjectIssueInfo(projNo);

    const ProjectMemberInfo = (projNo) => {
      $.ajax({
        url: "/pms/project/ProjectMemberInfo",
        data: {
          projNo: projNo,
        },
        type: "get",
        dataType: "json",
        success: function (res) {
          let MemberInfo = "";
          let memList = res.memList;
          let sttrArr = [];



          for (let i = 0; i < memList.length; i++) {

            complete = memList[i].complete;
            progress = memList[i].progress;

            total = complete + progress;

            let sttr = (complete / total) * 100;

            sttr = Math.ceil(sttr);

            if(!total){
              sttr = 0;
            }


            sttrArr[i] = sttr;

            console.log('memList[',i,'].userNm : : : ',memList[i].userNm)

            console.log("taskSttr[",i,"].complete : ", memList[i].complete);
            console.log("taskSttr[",i,"].progress : ", memList[i].progress);
            console.log("total : ", total);
            console.log('sttr2 : : :', sttr);

          }


          for (let i = 0; i < memList.length; i++) {
            MemberInfo += `
            <tr>
                    <td>
                      <div class="d-flex px-2">
                        <div>
                          <img src=\${memList[i].userProfile} class="avatar avatar-sm rounded-circle me-2">
                        </div>
                        <div class="my-auto">
                          <h6 class="mb-0 text-xs" id="proMem">\${memList[i].userNm}</h6>
                        </div>
                      </div>
                    </td>
                    <td>
                      <p class="text-xs font-weight-normal mb-0" id="projbttl">\${memList[i].jbttlCd}</p>
                    </td>
                    <td>
                        <div class="row">

                          <div class="col-1"></div>
                          <div class="col-9 pe-0 mt-3">
                            <div class="progress w-100">
                              <div class="progress-bar bg-info" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: \${sttrArr[i]}%;">
                              </div>
                            </div>
                          </div>

                          <div class="col-2">
                            <span class="text-sm font-weight-normal" id="taskDetailSttr"+i>\${sttrArr[i]}%</span>
                          </div>

                        </div>

                    </td>
                    <td class="align-middle">
                      <button class="btn btn-link text-secondary mb-0 getMemberInfoBtn" id=\${memList[i].stuNo} aria-haspopup="true" aria-expanded="false">
                        <span class="material-icons">
                        more_vert
                        </span>
                      </button>
                    </td>
                  </tr>
            `;
          }

          $("#projectMemberList").html(MemberInfo);
          membergetInfo()
        },
      });
    };

    const membergetInfo = () =>{
      $(".getMemberInfoBtn").on("click", function(){
        console.log('$(this)', $(this).attr("id"))

        let getStuNo = $(this).attr("id")

        indivisualInfo(projNo, getStuNo);

      })

    }


    ProjectMemberInfo(projNo);

    const proStatics = (projNo, stuNo) => {
      let data = {
        projNo: projNo,
        stuNo: stuNo,
      };

      $.ajax({
        url: "/pms/project/getCountMyTaskAndIssue",
        data: data,
        type: "get",
        dataType: "json",
        success: function (res) {
          console.log("const proStatics = (projNo) => {", res);

          let topTaskList = "";
          let topIssueList = "";

          for (let i = 0; i < res.issueCount.length; i++) {
            topIssueList += `
          <tr>
              <td class="">
                <div class="my-auto">
                    <h6 class="mb-0 text-xs">\${res.issueCount[i].issueTtl}</h6>
                </div>
              </td>
              <td class="">
                <div class="my-auto">
                    <h6 class="mb-0 text-xs">\${res.issueCount[i].issueSttsCd}</h6>
                </div>
              </td>
          </tr>
          `;
          }


          for (let i = 0; i < res.taskCount.length; i++) {
            topTaskList += `
          <tr>
              <td class="">
                <div class="my-auto">
                    <h6 class="mb-0 text-xs">\${res.taskCount[i].taskTitle}</h6>
                </div>
              </td>
              <td class="">
                <div class="my-auto">
                    <h6 class="mb-0 text-xs">\${res.taskCount[i].taskStts}</h6>
                </div>
              </td>
          </tr>
          `;
          }
          $("#topTaskList").html(topTaskList);
          $("#topIssueList").html(topIssueList);
        },
      });
    };

    proStatics(projNo, stuNo);

    function formatDateToKorean(dateString) {
      let dateObj;

      if (dateString.includes('-')) {
        dateObj = new Date(dateString);
      } else {
        const year = dateString.substring(0, 4);
        const month = dateString.substring(4, 6);
        const day = dateString.substring(6, 8);
        dateObj = new Date(`\${year}-\${month}-\${day}`);
      }

      const year = dateObj.getFullYear();
      const month = String(dateObj.getMonth() + 1).padStart(2, '0');
      const day = String(dateObj.getDate()).padStart(2, '0');

      return `\${year}년 \${month}월 \${day}일`;
    }



    const indivisualInfo = (projNo, getStuNo) => {
      let data = {
        projNo: projNo,
        stuNo: getStuNo,
      };

      $.ajax({
        url: "/pms/project/getCountMemberTaskAndIssue",
        data: data,
        type: "get",
        dataType: "json",
        success: function (res) {
          console.log("const indivisualInfo = (projNo, stuNo) => {", res);
          let indivisualInfo = res.indivisualInfo;
          let indivisualIssue = res.indivisualIssue;
          let indivisualSttr = res.indivisualSttr;
          let indivisualTask = res.indivisualTask;
          let topTaskList = "";
          let topIssueList = "";

          const original = indivisualInfo.userProfile;
          const modifiedOriginal = original.replace(/\/s_/g, '/');

          let teamJoinDt = formatDateToKorean(indivisualInfo.teamJoinDt)
          let userBrdt = formatDateToKorean(indivisualInfo.userBrdt)

          console.log('teamJoinDt, userBrdt', teamJoinDt, userBrdt)


          for (let i = 0; i < indivisualTask.length; i++) {
            topTaskList += `
              <tr>
                  <td class="mytd">
                    <div class="my-auto">
                        <h6 class="mb-0 text-xs">\${indivisualTask[i].taskTitle}</h6>
                    </div>
                  </td>
                  <td class="mytd">
                    <div class="my-auto">
                        <h6 class="mb-0 text-xs">\${indivisualTask[i].taskStts}</h6>
                    </div>
                  </td>
              </tr>
          `;
          }


          for (let i = 0; i < indivisualIssue.length; i++) {
            topIssueList += `
              <tr>
                  <td class="mytd">
                    <div class="my-auto">
                        <h6 class="mb-0 text-xs">\${indivisualIssue[i].issueTtl}</h6>
                    </div>
                  </td>
                  <td class="mytd">
                    <div class="my-auto">
                        <h6 class="mb-0 text-xs">\${indivisualIssue[i].issueSttsCd}</h6>
                    </div>
                  </td>
              </tr>
          `;
          }


          let total = 0;
          let sttr = 0;

          if(indivisualSttr !== null && indivisualSttr.complete !== null && !indivisualSttr.progress !== null){
            total = indivisualSttr.complete + indivisualSttr.progress;
            console.log("total : ", total);

            sttr = (indivisualSttr.complete / total) * 100;
            console.log("sttr : ", sttr);

            sttr = Math.ceil(sttr);
          }


          console.log('sttr : : :', sttr);


          const modalHtml = `

          <div class="modal-header">
                    <div class="container">
                      <div class="row">
                        <div class="col-8">
                          <h5
                            class="modal-title font-weight-normal"
                            id="taskUpdateModalLabel"
                          >
                            \${indivisualInfo.userNm}님의 프로필
                          </h5>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="modal-body" style="height: 600px">
                  <div class="container">
                    <div class="row">
                      <div class="col-4 pe-0">
                        <img src=\${modifiedOriginal} class="img-thumbnail">
                        </div>

                      <div class="col pe-0 ps-0">
                        <div class="row">
                          <div class="col-3 text ps-0"><p class="m-0">이름</p></div>
                          <div class="col"><p class="m-0">\${indivisualInfo.userNm}</p></div>
                        </div>

                        <div class="row">
                          <div class="col-3 ps-0">
                            <p class="m-0">직책</p>
                          </div>
                          <div class="col">
                            <p class="m-0">\${indivisualInfo.jbttlCd}</p>
                          </div>
                        </div>

                        <div class="row">
                            <div class="col-3 ps-0">
                              <p class="m-0">생년월일</p>
                            </div>
                          <div class="col">
                            <p class="m-0">
                              \${userBrdt}
                            </p>
                          </div>
                          </div>

                        <div class="row">
                          <div class="col-3 ps-0">
                            <p class="m-0">
                              이메일
                            </p>
                          </div>
                          <div class="col">
                            <p class="m-0">
                              \${indivisualInfo.userEmlAddr}
                            </p>
                            </div>
                        </div>

                        <div class="row">
                          <div class="col-3 ps-0">
                            <p class="m-0">
                              전화
                            </p>
                          </div>
                          <div class="col">
                            <p class="m-0">
                              \${indivisualInfo.userPhoneno}
                            </p>
                          </div>
                        </div>

                      </div>
                    </div>

                    <div class="container">
                      <div class="row">
                        <div class="col-4" for="taskUpdateRegDt">
                          <label>프로젝트 합류일</label>
                        </div>
                        <div class="col-8">
                          <p
                            name="taskRegDt"
                            id="taskUpdateRegDt"
                            class="form-control task mb-1 textline"
                          >\${teamJoinDt}</p>
                        </div>
                      </div>
                    </div>

                    <div class="container">
                      <div class="row">
                        <div class="col-4" for="controllProgressDiv">
                          <label>일감 진척도</label>
                        </div>
                        <div class="col-8 controllProgress" id="controllProgressDiv">

                          <div class="row">

                          <div class="col-10 pe-0 mt-3">
                            <div class="progress w-100">
                              <div class="progress-bar bg-info" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: \${sttr}%;">
                              </div>
                            </div>
                          </div>

                          <div class="col-2">
                            <span class="text-sm font-weight-normal" id="taskDetailSttr"+i>\${sttr}%</span>
                          </div>

                        </div>

                          </div>
                      </div>
                    </div>

                    <div class="container">
                      <div class="row">

                        <div class="card menagement">
                          <div class="card-body taskAndIssueBody">

                            <nav>
                              <div class="nav nav-tabs" id="Indivisual-nav-tab" role="tablist">
                                <button
                                  class="nav-link active topTaskAndIssue"
                                  id="Indivisual-nav-home-tab"
                                  data-bs-toggle="tab"
                                  data-bs-target="#Indivisual-nav-home"
                                  type="button"
                                  role="tab"
                                  aria-controls="Indivisual-nav-home"
                                  aria-selected="true"
                                >
                                  최근 일감
                                </button>

                                <button
                                  class="nav-link topTaskAndIssue"
                                  id="Indivisual-nav-profile-tab"
                                  data-bs-toggle="tab"
                                  data-bs-target="#Indivisual-nav-profile-1"
                                  type="button"
                                  role="tab"
                                  aria-controls="Indivisual-nav-profile-1"
                                  aria-selected="false"
                                >
                                  최근 이슈
                                </button>


                              </div>
                            </nav>
                            <div class="tab-content" id="nav-tabContent-1">
                              <div
                                class="tab-pane fade show active"
                                id="Indivisual-nav-home"
                                role="tabpanel"
                                aria-labelledby="Indivisual-nav-home-tab"
                              >
                                <div class="table-responsive">
                                  <table class="table align-items-center mb-0">
                                    <thead>
                                      <th class="tdTitle">일감명</th>
                                      <th class="tdTitle">상태</th>
                                    </thead>

                                    <tbody id="IndivisualTopTaskList">
                                      \${topTaskList}
                                      </tbody>
                                  </table>
                                </div>
                              </div>
                              <div
                                class="tab-pane fade"
                                id="Indivisual-nav-profile-1"
                                role="tabpanel"
                                aria-labelledby="Indivisual-nav-profile-tab"
                              >
                                <div class="table-responsive">
                                  <table class="table align-items-center mb-0">
                                    <thead>
                                      <th class="tdTitle">이슈명</th>
                                      <th class="tdTitle">상태</th>
                                    </thead>
                                    <tbody id="IndivisualTopIssueList">
                                      \${topIssueList}
                                      </tbody>
                                  </table>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>


                      </div>
                    </div>

                    <div>
                      </div>
                      </div>
                      </div>
                      <div class="modal-footer">
                        <button
                          type="button"
                          class="btn bg mcanBtn"
                          data-bs-dismiss="modal"
                        >
                          닫기
                        </button>
                      </div>

                `;

                $("#profileModalBody").html(modalHtml);
                $("#profileModal").modal("show");
        },
      });
    };



  </script>
</div>
