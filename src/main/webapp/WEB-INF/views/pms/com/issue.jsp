<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib
uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!-- 공통코드 -->
<script src="${pageContext.request.contextPath}/common/sw/js/CommonCode.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<c:set var="projNo" value="${projNo}" />
<style>
  .form-control {
    text-align: left;
    border: 1px solid #e6e3e2;
  }

  #mUpBtn,
  #mDelBtn,
  #mSubBtn,
  #mUpBtn2,
  #mDelBtn2,
  #insertStorageBtn {
    background-color: #344767;
    color: white;
  }

  #mcanBtn,
  #mcanBtn2 {
    border: 1px solid #e6e3e2;
  }

  input {
    border: 1px solid #e6e3e2;
  }
  .NotComment {
    margin-top: 10px;
    font-size: 14px;
  }
  .CommentStyle {
    background-color: #f0f2f5;
  }
  #upComment,
  #delComment,
  #cnBtn {
    cursor: pointer;
  }
  #commentCn {
    height: 70px;
    border: none;
  }
  .hrline {
    border: 1px solid #f0f2f5;
    width: 100%;
    height: 1px;
  }
  #commentDetail {
    height: 145px;
  }

  #issueTtl {
    cursor: pointer;
  }

  #cnBtn {
    background-color: rgb(25, 195, 125);
    color: white;
    border-radius: 5px;
    height: 35px;
    width: 35px;
    line-height: 35px;
    padding-left: 5px;
    top: 2;
    position: absolute;
    bottom: 8px;
    right: 7px;
    font-size: 25px;
  }

  textarea {
    resize: none;
  }

  /* 무한 스크롤 시작 영역 */
  .scroll-Wrap {
    max-height: 150px;
    overflow-y: auto;
    direction: ltr;
    scrollbar-color: #d4aa70 #e4e4e4;
  }

  .scroll-Wrap::-webkit-scrollbar {
    width: 10px; /* 세로축 스크롤바 폭 너비 */
    height: 20px; /* 가로축 스크롤바 폭 너비 */
  }

  .scroll-Wrap::-webkit-scrollbar-track {
    background-color: #e4e4e4;
    border-radius: 100px;
  }

  .scroll-Wrap::-webkit-scrollbar-thumb {
    border-radius: 50px;
    border-left: 0;
    border-right: 0;
    background-color: #cec8c7;
  }

  .scroll-Wrap2 {
    max-height: 70px;
    overflow-y: auto;
    direction: ltr;
    scrollbar-color: #d4aa70 #e4e4e4;
  }

  .scroll-Wrap2::-webkit-scrollbar {
    width: 10px; /* 세로축 스크롤바 폭 너비 */
    height: 20px; /* 가로축 스크롤바 폭 너비 */
  }

  .scroll-Wrap2::-webkit-scrollbar-track {
    background-color: #e4e4e4;
    border-radius: 100px;
  }

  .scroll-Wrap2::-webkit-scrollbar-thumb {
    border-radius: 50px;
    border-left: 0;
    border-right: 0;
    background-color: #cec8c7;
  }

  label.necessary::after {
    content: "*";
    color: red;
    margin-left: 4px;
  }
</style>
<!--  User ID (원생번호/사원번호) -->

<div class="card mt-3" id="issueList"></div>

<!--  이슈 생성  Modal 시작  -->
<div
  class="modal fade"
  id="insertModal"
  role="dialog"
  aria-labelledby="insertModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog d-flex justify-content-center" role="document">
    <div class="modal-content" id="modalContent"></div>
  </div>
</div>
<!-- 이슈 생성  Modal 끝 -->

<!--  이슈 상세보기  Modal 시작  -->
<div
  class="modal fade"
  id="detailModal"
  role="dialog"
  aria-labelledby="detailModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog d-flex justify-content-center" role="document">
    <div class="modal-content" id="modalDetail"></div>
  </div>
</div>
<!-- 이슈 상세보기 Modal 끝 -->

<!--  이슈 수정  Modal 시작  -->
<div
  class="modal fade"
  id="UpModal"
  role="dialog"
  aria-labelledby="UpModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog d-flex justify-content-center" role="document">
    <div class="modal-content" id="modalUpdate"></div>
  </div>
</div>
<!-- 이슈 상세보기 Modal 끝 -->

<script>
  //서버에서 발행된 헤더네임과 토큰갑사 저장
  var header = "${_csrf.headerName}";
  var token = "${_csrf.token}";

  const projNo = "${projNo}";
  const userNm = "${userNm}";
  const userVo = "${userVo}";
  const userNo = "${userNo}";
  const projNm = "${projNm}";

  console.log("projNm : ", projNm);

  // 데이터 보내고 싶을 때 사용 , handleTextMessage로 전송
  // 서버로 메세지 전달하는 함수
  function sendMsg(msg) {
    if (!msg) {
      webSocket.send("연결성공");
      return;
    }
    webSocket.send(msg);
    console.log("msg : ", msg);
  }

  //날짜 수정
  function convertDate(Cdate) {
    const year = Cdate.substring(0, 5);
    const month = Cdate.substring(5, 7);
    const day = Cdate.substring(7, 10);
    const formattedDate = year + month + day;
    return formattedDate;
  }
  //날짜 수정 하이픈 제거
  function converDate2(Cdate) {
    const formattedDate = Cdate.replaceAll("-", "");
    return formattedDate;
  }

  let page;
  let searchType;
  let searchWord;

  // 프로젝트 팀원 리스트 추출 수정 모달에서 사용
  const getTeamMemTaskList = (projNo, selection, tagId) => {
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
          const isSelected = selection.includes(res[i].userNm)
            ? "selected"
            : "";
          teamOption += `<option value=\${res[i].stuNo} \${isSelected}>\${res[i].userNm}</option>`;
        }

        console.log("getTeamMemList : " + teamOption);
        $("#" + tagId).html(teamOption);
      },
      error: function (xhr) {
        console.log("getTeamMemList 상태: " + xhr.status);
      },
    });
  };

  const getTeamMemList = (projNo, tagId) => {
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
          teamOption += `<option value=\${res[i].stuNo}>\${res[i].userNm}</option>`;
        }
        console.log("getTeamMemList : " + teamOption);
        $("#" + tagId).html(teamOption);
      },
      error: function (xhr) {
        console.log("getTeamMemList 상태: " + xhr.status);
      },
    });
  };

  const issueList = (projNo, page, searchType, searchWord) => {
    if (page == null) {
      page = 1;
    }

    if (searchType == null) {
      searchType = "title";
    }

    $.ajax({
      url: "/pms/project/issueList",
      data: {
        projNo: projNo,
        currentPage: page,
        searchType: searchType,
        searchWord: searchWord,
      },
      type: "get",
      dataType: "json",
      success: function (res) {
        console.log("res!!", res);
        console.log(res.pagingVO);
        console.log("이거는 : ", res.pagingVO.dataList);

        const dataList = res.pagingVO.dataList;
        const pagingHTML = res.pagingVO.pagingHTML;
        const pageNum =
          res.pagingVO.totalRecord -
          (res.pagingVO.currentPage - 1) * res.pagingVO.screenSize;

        let projectissueList = `

        <div class="container mt-5">
	        <div class="row">
		        <div class="col-5 pe-2">
			        <button type="button" id="insertStorageBtn" class="ms-4 btn btn-outline-secondary">
			      		 등록
			        </button>
		        </div>
		        <div class="col-2">
		        </div>

				<div class="col-4 ms-6" style="border: none;">
			        <form class="input-group input-group-outline" id="searchForm" style="border: none;">
		              <input type="hidden" name="page" id="page" /><input type="hidden" name="page" id="page" value="1">
					  <div class="d-flex justify-content-end border rounded bg-white" style="border: none;">
						  <select class="w-60 form-control" id="searchType"  style="border: none;">
			                  <option value="title" id="searchTypeTitle">제목
			                  </option>
			                  <option value="writer" id="searchTypeWriter">작성자</option>
			                  <option value="titleWriter" id="searchTypeTitleWriter">제목+작성자</option>
		            	  </select>
		            	  <span style="height:8px;color: #e2e2e2;/* line-height: 38px; */">| </span>
		            	  <input type="text" id="searchWord" name="searchWord" class="form-control" placeholder="Search" style="border: none;">
					      <button type="button" id="searchBtn" class="w-10 btn btn-default mb-0 search">
							 <i class="fas fa-search" aria-hidden="true"></i>
						  </button>
				       </div>
				    </form>
				</div>

				<!-- <div class="col-7 float-end">

		      	 <form class="input-group input-group-outline" id="searchForm">
		              <input type="hidden" name="page" id="page" />
							 <div class="col-2">
			                  <select class="form-control" id="searchType">
			                      <option value="title" id="searchTypeTitle">제목</option>
			                      <option value="writer" id="searchTypeWriter">작성자</option>
			                      <option value="titleWriter" id="searchTypeTitleWriter">제목+작성자</option>
			                  </select>
			                  </div>
			                  <div class="col-7">
				           	       <label class="form-label"></label>
				               	   <input type="text" id="searchWord" name="searchWord" class="form-control" placeholder="Search" />
		                	  </div>
		                	  <div class="col-3">
				                   <button type="button" id="searchBtn" class="btn btn-outline-secondary">
				                	  <i class="fas fa-search"></i>검색
				                   </button>
				              </div>
          	 	  </form>
              	  </div> -->

         		 <!-- <div class="col-5 float-end">

		      	 <form class="input-group input-group-outline" id="searchForm">
		              <input type="hidden" name="page" id="page" />

			                  <select class="form-control" id="searchType">
			                      <option value="title" id="searchTypeTitle">제목</option>
			                      <option value="writer" id="searchTypeWriter">작성자</option>
			                      <option value="titleWriter" id="searchTypeTitleWriter">제목+작성자</option>
			                  </select>


				           	       <label class="form-label"></label>
				               	   <input type="text" id="searchWord" name="searchWord" class="form-control" placeholder="Search" />

				                   <button type="button" id="searchBtn" class="btn btn-outline-secondary">
				                	  <i class="fas fa-search"></i>검색
				                   </button>

          	 	  </form>
              	  </div>  -->
          </div>
		</div>

    <div class="table-responsive">
    <table class="table">
        <thead>
          <tr>
            <th class="text-center" scope="col">번호</th>
            <th class="text-center" scope="col">이슈제목</th>
            <th class="text-center" scope="col">담당자</th>
            <th class="text-center" scope="col">등록자</th>
            <th class="text-center" scope="col">등록일</th>
            <th class="text-center" scope="col">이슈상태</th>
          </tr>
        </thead>
        <tbody>
          `;
        for (let i = 0; i < dataList.length; i++) {
          projectissueList += `
          <tr>
            <td class="text-center">\${pageNum-i}</td>

            <td id="issueTtl" data-value="\${dataList[i].issueNo}">\${dataList[i].issueTtl}</td>

            <td class="text-center">\${dataList[i].issueAsg}</td>

            <td class="text-center" id="writer">\${dataList[i].userNm}</td>

            <td class="text-center" id="issueDt">\${dataList[i].issueRegDt}</td>

            <td class="text-center">\${dataList[i].issueSttsCd}</td>


          </tr>
          `;
        }

        projectissueList += `
              </tbody>
              </table>
          </div>
          <div class="card-footer clearfix" id="pagingArea">
              \${pagingHTML}
          </div>
          `;
        $("#issueList").html(projectissueList);
        $("#page").val(page);
        $("#searchType").val(searchType);
        $("#searchWord").val(searchWord);

        console.log(
          "page, searchType, searchWord : ",
          page,
          searchType,
          searchWord
        );
        pagingClick();
        tableClick();
      },
      error: function (xhr) {
        console.log("issueList 상태: " + xhr.status);
      },
    });
  };
  issueList(projNo, page, searchType, searchWord);

  const pagingClick = () => {
    let searchForm = $("#searchForm");
    let pagingArea = $("#pagingArea");

    let searchBtn = $("#searchBtn");

    let shWord = "";
    let shType = "";

    searchBtn.on("click", function () {
      shWord = $("#searchWord").val();
      shType = $("#searchType").val();

      issueList(projNo, page, shType, shWord);
    });

    pagingArea.on("click", "a", function (event) {
      event.preventDefault();
      var pageNo = $(this).data("page");
      searchForm.find("#page").val(pageNo);

      shWord = $("#searchWord").val();
      shType = $("#searchType").val();

      issueList(projNo, pageNo, shType, shWord);
    });
  };

  /* 이슈 등록 버튼  */
  $("#issueList").on("click", "#insertStorageBtn", function () {
    const insertModal = `
        <div class="modal-header">
          <h5 class="modal-title font-weight-normal" >이슈 등록하기</h5>
          </div>

        <div class="modal-body">
           <form>
           <div class="d-flex justify-content-start mb-3">
           <label class="w-20 pt-2 form-label necessary" for="missueTtl">이슈제목</label>
           <input type="text" class="form-control mb-2 ps-2" id="missueTtl" name="issueTtl"></textarea>
         </div>
          <div class="d-flex justify-content-start mb-3">
           <label class="w-20 pt-2 form-label necessary" for="mIssueCd">이슈코드</label>
           <select class="ps-2 form-select mem" id="mIssueCd" name="issueCd">
          </select>
          </div>



        <div class="d-flex justify-content-start mb-3">
           <label class="w-20 pt-2 form-label necessary" for="missueAsg">담당자</label>
              <select class="form-select ps-2" id="missueAsg" name="issueAsg">
              </select>
        </div>


          <div class="d-flex justify-content-start mb-3">
          <label class="w-20 pt-2 form-label necessary" for="mCon">이슈내용</label>
            <textarea class="form-control mb-2 ps-2" id="mCon" name="issueCn"></textarea>
          </div>
         <div class="d-flex justify-content-start mb-3">
          <label class="w-20 pt-2 form-label necessary" for="mIssueSttsCd">이슈상태</label>
           <select class="ps-2 form-select mem" id="mIssueSttsCd" name="issueSttsCd">

          </select>
          </div>


           <div class="modal-footer">
             <button type="button" class="btn bg msubBtn" id="mSubBtn">등록</button>
             <button type="reset" class="btn bg mcanBtn" data-bs-dismiss="modal" id="mcanBtn">취소</button>
           </div>
          </form>
        </div>
        `;

    $("#modalContent").html(insertModal);
    getCodeOptionOneSelected("P007", "mIssueCd", mIssueCd);
    getCodeOptionOneSelected("P006", "mIssueSttsCd", mIssueSttsCd);
    getTeamMemList(projNo, "missueAsg");

    $("#insertModal").modal("show");
  });

  document.addEventListener("click", function (event) {
    if (event.target.id === "mSubBtn") {
      if (validateForm()) {
        $.ajax({
          url: "/pms/project/userno",
          type: "post",
          dataType: "json",
          beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
          },
          success: function (res) {
            console.log("res!!!!!!!!!: ", res);
            var stuNo = res.userNo;
            console.log("stuNo !!!! : ", stuNo);

            var userName = res.userNm;
            console.log("이름 가져오기 : ", userName);

            var userProfile = res.userProfile;

            var insertTime = new Date();
            var currentHour = insertTime.getHours();
            var currentMinute = insertTime.getMinutes();
            var formattedMinute =
              currentMinute < 10 ? "0" + currentMinute : currentMinute;
            var HourMinute = currentHour + ":" + formattedMinute;
            console.log("등록시간 ", HourMinute);

            var data = {
              issueTtl: $("#missueTtl").val(),
              issueCd: $("#mIssueCd").val(),
              issueCn: $("#mCon").val(),
              issueSttsCd: $("#mIssueSttsCd").val(),
              issueAsg: $("#missueAsg").val(),
              projNo: projNo,
              stuNo: stuNo,
              issueRegDt: HourMinute,
            };

            console.log("등록시 넘어오는 데이터 :", data);
            //서버로 보내기
            insertIssue(data, userName, userProfile);
            $("#insertModal").modal("hide");
          },

          error: function (xhr) {
            console.log(xhr.status);
          },
        });
      }
    }
  });

  /* 이슈 등록 후 데이터 받아오기 */
  function insertIssue(data, userName, userProfile) {
    console.log("data !!!!!!!!!!!!!!!!: ", data);
    console.log("data stuNo: ", data.stuNo);
    console.log("userName : ", userName);

    var dtTime = data.issueRegDt;
    console.log("dtTime: ", dtTime);

    var issueCn = data.issueCn;
    console.log("issueCn: ", issueCn);

    $.ajax({
      url: "/pms/project/insertissue",
      type: "post",
      data: JSON.stringify(data),
      dataType: "text",
      contentType: "application/json; charset=utf-8",
      beforeSend: function (xhr) {
        xhr.setRequestHeader(header, token);
      },
      success: function (res) {
        console.log("서버에서 반환한 이슈 정보: ", res);

        Swal.fire({
          icon: "success",
          title: "이슈 등록 성공",
          showConfirmButton: false,
          timer: 1500,
        });

        sendMsg(
          `신규 이슈,\${projNo},\${userName},\${userProfile},\${dtTime},\${projNm},이슈 게시판,\${stuNo},\${issueCn}`
        );

        issueList(projNo, page, searchType, searchWord);
      },
      error: function (xhr) {
        console.log(xhr.status);
      },
    });
  }

  /* 이슈 디테일 모달 띄우기 */
  const tableClick = () => {
    console.log("tableClick() 실행");

    $(".table").on("click", "#issueTtl", function () {
      var issueNo = $(this).data("value");

      console.log("issueNo : ", issueNo);

      let detailModal = `
          <div class="modal-header">
             <h5 class="modal-title font-weight-normal" id="detailModalLabel">이슈 상세보기</h5>
           </div>

           <div class="modal-body">
              <form>
                   <input type="hidden" class="w-20 pt-2 form-label" id="dIssueNo"></input>
                   <div class="d-flex justify-content-start mb-3">
                       <label class="w-20 pt-2 form-label" for="dIssueTitle">이슈제목</label>
                       <input type="text" class="form-control line w-100" id="dIssueTitle" disabled>
                   </div>

                   <div class="d-flex justify-content-start mb-3">
                       <label class="w-20 pt-2 form-label" for="dIssueCd">이슈코드</label>
                       <input type="text" class="form-control line w-100" id="dIssueCd" disabled>
                   </div>

                  <div class="d-flex justify-content-start mb-3">
                     <label class="w-20 pt-2 form-label" for="dIssueSttsCd">이슈상태</label>
                       <input type="text" class="form-control line w-100" id="dIssueSttsCd" disabled>
                  </div>

                  <div class="d-flex justify-content-start mb-3">
                     <label class="w-20 pt-2 form-label" for="dIssueNm">담당자</label>
                     <input type="text" class="form-control line w-100" id="dIssueNm" disabled>
                  </div>

                   <div class="d-flex justify-content-start mb-3">
                   <label class="w-20 pt-2 form-label" for="dIssueCn">이슈내용</label>
                   <input type="text" class="form-control line w-100" id="dIssueCn" disabled>
                   </div>

                   <div class="mb-2 hrline"></div>

                  <div class="" style="height:150px;"><h6 class="">COMMENTS</h6>
	                  <div class="border rounded scroll-Wrap" >

	                     <!-- 코멘트 하나당 div 한개씩 생성 -->
	                    <div class="container" id="commentDiv">
	                       <div class="row">
	                         <div class="col-12" id="commentDetail">

	                         </div>
	                       </div>
	                     </div>

	                  </div>
                  </div>

                 <div class="container mt-5 mb-2">
                      <div class="col row ps-0" style="font-size:15px;">
                     	 <span>COMMENT : </span>
                      </div>
                 </div>
                 <div class="container">
                      <div class="row border rounded">
                         <div class="col-11 ms-0">
                         	<textarea class="ps-2 col-12 form-control ps-0 scroll-Wrap2" id="commentCn" placeholder="코멘트 입력하기"></textarea>
                         </div>
                         <div class="col-1" style="position: relative;">
                         	<i class="mb-2 pe-2 float-end text-end material-icons opacity-10" id="cnBtn">send</i>
                         </div>
                       </div>
				 </div>

                 <div class="modal-footer mt-3">
                   <button type="button" class="btn bg mUpBtn" id="mUpBtn">수정</button>
                   <button type="reset" class="btn bg mcanBtn" data-bs-dismiss="modal" id="mcanBtn">취소</button>
                 </div>
              </form>
           </div>
      `;
      var data = {
        issueNo: issueNo,
        projNo: projNo,
        stuNo: userNo,
      };

      $.ajax({
        url: "/pms/project/detail",
        type: "get",
        data: data,
        success: function (res) {
          console.log("디테일 res  : ", res);

          $("#modalDetail").html(detailModal);
          $("#detailModal").modal("show");

          var c = res.cmntVoList;
          var c = res;
          console.log("확인용 : : : ", c);
          console.log("res 확인용 : : : ", res);

          var comment = res.cmntVoList.length;
          console.log("comment : : :", comment);

          if (comment === null || comment === "" || comment === "null") {
            $("#commentDetail").html(
              "<p class='NotComment'>코멘트가 없습니다.</p>"
            );
          } else {
            $("#commentDetail").html(""); // 코멘트 내용 초기화

            CmntList(data);
          }

          $("#dIssueNo").val(res.issueNo);
          $("#dIssueTitle").val(res.issueTtl);
          $("#dIssueCd").val(res.issueCd);
          $("#dIssueSttsCd").val(res.issueSttsCd);
          $("#dIssueNm").val(res.issueAsg);
          $("#dIssueCn").val(res.issueCn);
        },

        error: function (xhr) {
          console.log(xhr.status);
        },
      });
    });
  };

  function CmntList(data) {
    $.ajax({
      url: "/pms/project/cmntdetail",
      type: "get",
      data: data,
      success: function (res) {
        console.log("디테일 res 2: ", res);
        let cmnt = "";

        for (let i = 0; i < res.length; i++) {
          cmnt += `<div class="commnet-Wrap" data-value="\${res[i].cmntNo}">
                          <div class="row ps-2 mt-2">
                             <div class="col-5" style="font-size:12px;">
                            \${res[i].userNm} / \${convertDate(res[i].cmntBengDt)}
                             </div>

                             <div class="col-7 text-xxs text-end button-Wrap">
                                <span id="upComment">
                                   <i class="material-icons opacity-10">edit_note</i>
                                </span>
                                <span id="delComment">
                                   <i class="material-icons opacity-10">clear</i>
                                </span>
                             </div>

                          </div>
                             <div class="row mb-3">
                                <div class="col-12" >
                                   <textarea class="w-100 rounded CommentStyle" style="height:50px;" disabled>\${res[i].cmntCn}</textarea>
                                </div>
                                   </div>
                             </div>
                             `;
        }
        $("#commentDetail").html(cmnt);
      },
      error: function (xhr) {
        console.log(xhr.status);
      },
    });
  }

  /* 코멘트 등록 */

  $("#modalDetail").on("click", "#cnBtn", function () {
    var cIssueNo = $("#dIssueNo").val();

    console.log("commnet IssueNoㅋ: ", cIssueNo);
    console.log("commnet stuNoㅋ: ", stuNo);

    var addCn = $("#commentCn").val();
    console.log(addCn);

    var data = {
      issueNo: cIssueNo,
      cmntCn: addCn,
      stuNo: userNo,
      projNo: projNo,
    };
    console.log("commnet data: ", data);

    $.ajax({
      url: "/pms/project/insertcomment",
      type: "post",
      data: JSON.stringify(data),
      dataType: "text",
      contentType: "application/json;charset=utf-8",
      beforeSend: function (xhr) {
        xhr.setRequestHeader(header, token);
      },
      success: function (res) {
        Swal.fire("등록 완료", "코멘트가 등록 되었습니다!", "success");
        $("#commentCn").val("");

        CmntList(data);
      },

      error: function (xhr) {
        console.log(xhr.status);
      },
    });
  });

  /* 수정할 코멘트 데이터 */
  $("#modalDetail").on("click", "#upComment", function () {
    // 클릭된 아이콘이 속한 부모 요소인 .aplyClick 클래스를 찾음
    var parent = $(this).closest(".commnet-Wrap");

    // 해당 부모 요소의 value 속성 값을 가져옴
    var cmntNo = parent.data("value");
    console.log("cmntNo당 : ", cmntNo);

    var data = { cmntNo: cmntNo };

    $.ajax({
      url: "/pms/project/detailcommnet",
      type: "get",
      data: data,
      success: function (res) {
        let check = `<i class="material-icons opacity-10" id="check">check_circle</i>
                        <i class="material-icons opacity-10" id="upcancel">clear</i>
              `;

        console.log("코멘트 수정 버튼 눌렀을 때 불러오는 값 : ", res);

        //textarea 원래 html
        textareaWrap = parent.find(".CommentStyle").html();

        // textarea의 disabled 속성 해제
        parent.find(".CommentStyle").prop("disabled", false);

        // textarea의 배경색 변경
        parent.find(".CommentStyle").css("background", "white");

        parent.find(".CommentStyle").val(res.cmntCn);

        ButtonWrapContent = parent.find(".button-Wrap").html(); // 원래 내용을 저장
        parent.find(".button-Wrap").html(check);
      },

      error: function (xhr) {
        cosole.log(xhr.status);
      },
    });
  });

  /* 코멘트 수정 내용 보내기 */
  $("#modalDetail").on("click", "#check", function () {
    // 클릭된 아이콘이 속한 부모 요소인 .aplyClick 클래스를 찾음
    var parent = $(this).closest(".commnet-Wrap");

    // 해당 부모 요소의 value 속성 값을 가져옴
    var cmntNo = parent.data("value");
    console.log("수정 데이터 보낼 cmntNo당 : ", cmntNo);

    var data = {
      cmntNo: cmntNo,
      cmntCn: parent.find(".CommentStyle").val(),
    };

    console.log("수정할 data : ", data);

    $.ajax({
      url: "/pms/project/updatecomment",
      type: "post",
      data: JSON.stringify(data),
      contentType: "application/json;charset=utf-8",
      beforeSend: function (xhr) {
        xhr.setRequestHeader(header, token);
      },
      dataType: "text",
      success: function (res) {
        console.log("수정할 res", res);
        parent.find(".button-Wrap").html(ButtonWrapContent); // 원래 내용으로 복구
        parent.find(".CommentStyle").prop("disabled", true); // 원래 내용으로 복구
        parent.find(".CommentStyle").css("background-color", ""); // 원래 내용으로 복구
        Swal.fire("수정 완료", "코멘트가 수정 되었습니다!", "success");
      },

      error: function (xhr) {
        console.log("aaa" + xhr.status);
      },
    });
  });

  /* 코멘트 삭제 */
  $("#modalDetail").on("click", "#delComment", function () {
    // 클릭된 아이콘이 속한 부모 요소인 .aplyClick 클래스를 찾음
    var parent = $(this).closest(".commnet-Wrap");

    let dIssueNo = $("#dIssueNo").val();

    let issueNo = {
      issueNo: dIssueNo,
    };

    // 해당 부모 요소의 value 속성 값을 가져옴
    var cmntNo = parent.data("value");
    console.log("수정 데이터 보낼 cmntNo당 : ", cmntNo);

    var data = {
      cmntNo: cmntNo,
    };

    console.log("삭제할 할 data : ", data);

    $.ajax({
      url: "/pms/project/delcomment",
      type: "post",
      data: JSON.stringify(data),
      contentType: "application/json;charset=utf-8",
      beforeSend: function (xhr) {
        xhr.setRequestHeader(header, token);
      },
      success: function (res) {
        console.log("삭제할 res", res);

        Swal.fire("삭제 완료", "코멘트가 삭제 되었습니다!", "success");

        CmntList(data);
      },

      error: function (xhr) {
        cosole.log("aaa" + xhr.status);
      },
    });
  });

  /* 이슈 내용 수정 데이터 보내기 모달 */
  $("#UpModal").on("click", "#mUpBtn2", function () {
    var uIssueNo = $("#dIssueNo").val();
    console.log("uIssueNo", uIssueNo);

    var data = {
      issueNo: uIssueNo,
      issueTtl: $("#uIssueTitle").val(),
      issueCd: $("#uIssueCd").val(),
      issueSttsCd: $("#uIssueSttsCd").val(),
      issueAsg: $("#issueAsg").val(),
      issueCn: $("#uIssueCn").val(),
    };

    console.log("업데이트 내용들  : ", data);

      $.ajax({
        url: "/pms/project/update",
        type: "post",
        data: JSON.stringify(data),
        contentType: "application/json;charset=utf-8",
        beforeSend: function (xhr) {
          xhr.setRequestHeader(header, token);
        },
        dataType: "text",
        success: function (res) {
          console.log("변경될 res: ", res);

          Swal.fire("수정 완료", "이슈 내용이 변경 되었습니다!", "success");

          $("#UpModal").modal("hide");
          issueList(projNo, page, searchType, searchWord);
        },
        error: function (xhr) {
          console.log(xhr.status);
        },
      })
  });

  /* 이슈 수정 데이터 받아오기 */
  $("#modalDetail").on("click", "#mUpBtn", function () {
    $("#detailModal").modal("hide");

    var uIssueNo = $("#dIssueNo").val();

    data = {
      issueNo: uIssueNo,
    };

    console.log(uIssueNo);

    let updateModal = `
             <div class="modal-header">
                <h5 class="modal-title font-weight-normal" id="detailModalLabel">이슈 수정하기</h5>
              </div>

              <div class="modal-body">
                 <form>
                      <div class="d-flex justify-content-start mb-3">
                          <label class="w-20 pt-2 form-label" for="uIssueTitle">이슈제목</label>
                          <input type="text" class="ps-3 form-control line w-100" id="uIssueTitle" >
                      </div>

                      <div class="d-flex justify-content-start mb-3">
                          <label class="w-20 pt-2 form-label" for="uIssueCd">이슈코드</label>
                          <select class="ps-3 form-select mem" id="uIssueCd" name="issueCd">
                        </select>
                      </div>

                     <div class="d-flex justify-content-start mb-3">
                        <label class="w-20 pt-2 form-label" for="uIssueSttsCd">이슈상태</label>
                          <select class="ps-3 form-select mem" id="uIssueSttsCd" name="issueCd">
                          </select>
                     </div>

                     <div class="d-flex justify-content-start mb-3">
                        <label class="w-20 pt-2 form-label" for="issueAsg">담당자</label>
                        <select class="ps-3 form-select" id="issueAsg">

                      </select>

                    </div>

                      <div class="d-flex justify-content-start mb-3">
                      <label class="w-20 pt-2 form-label" for="uIssueCn">이슈내용</label>

                      <textarea class="form-control mb-2 ps-3" id="uIssueCn"></textarea>

                      </div>

                    <div class="modal-footer">
                      <button type="button" class="btn bg mUpBtn" id="mUpBtn2">변경</button>
                      <button type="button" class="btn bg mdelBtn" id="mDelBtn2">삭제</button>
                      <button type="reset" class="btn bg mcanBtn" data-bs-dismiss="modal" id="mcanBtn2">취소</button>
                    </div>
                 </form>
              </div>
         `;
    $.ajax({
      url: "/pms/project/detail",
      type: "get",
      data: data,
      success: function (res) {
        console.log("res zz : ", res);

        $("#modalUpdate").html(updateModal);
        $("#UpModal").modal("show");

        $("#uIssueTitle").val(res.issueTtl);
        $("#uIssueCd").val(res.issueCd);
        $("#uIssueSttsCd").val(res.issueSttsCd);
        $("#issueAsg").val(res.issueAsg);
        $("#uIssueCn").val(res.issueCn);

        getTeamMemTaskList(projNo, res.issueAsg, "issueAsg");
        getCodeOptionOneSelected("P007", "uIssueCd", res.issueCd);
        getCodeOptionOneSelected("P006", "uIssueSttsCd", res.issueSttsCd);
      },
      error: function (xhr) {
        console.log(xhr.status);
      },
    });
  });

  /* 이슈 삭제 */
  $("#UpModal").on("click", "#mDelBtn2", function () {
    var uIssueNo = $("#dIssueNo").val();
    console.log("del uIssueNo: ", uIssueNo);

    Swal.fire({
      title: "삭제하시겠습니까?",
      text: "삭제 후 되돌릴 수 없습니다!",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "이슈 삭제",
    }).then((result) => {
      if (result.value) {
        $.ajax({
          url: "/pms/project/del",
          type: "post",
          data: JSON.stringify({
            issueNo: uIssueNo,
          }),
          dataType: "text",
          contentType: "application/json;charset=utf-8",
          beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
          },
          success: function (res) {
            console.log("del res :", res);
            Swal.fire({
              icon: "success",
              title: "이슈 삭제 성공!",
              showConfirmButton: false,
              timer: 1200,
            });

            $("#UpModal").modal("hide");

            setTimeout(() => {
              //화면에 적용
              issueList(projNo, page, searchType, searchWord);
            }, 1300);
          },
          error: function (xhr) {
            console.log(xhr.status);
          },
        });
      }
    });
  });

  function validateForm() {
    const issueTtl = document.getElementById("missueTtl");
    const issueCd = document.getElementById("mIssueCd");
    const issueAsg = document.getElementById("missueAsg");
    const issueCn = document.getElementById("mCon");
    const issueSttsCd = document.getElementById("mIssueSttsCd");

    const uIssueTitle = document.getElementById("uIssueTitle");
    const uIssueCn = document.getElementById("uIssueCn");


    if (issueTtl.value.trim() === "") {
      Swal.fire({
        icon: "error",
        title: "제목을 입력하세요.",
      });
      return false;
    } else if (issueCd.value === "") {
      Swal.fire({
        icon: "error",
        title: "이슈코드를 선택하세요.",
      });
      return false;
    } else if (issueAsg.value === "") {
      Swal.fire({
        icon: "error",
        title: "담당자를 선택하세요.",
      });
      return false;
    } else if (issueCn.value.trim() === "") {
      Swal.fire({
        icon: "error",
        title: "내용을 입력하세요.",
      });
      return false;
    } else if (issueSttsCd.value === "") {
      Swal.fire({
        icon: "error",
        title: "이슈상태를 선택하세요.",
      });
      return false;
    }
    return true;
  }

  const autoComplete = () => {
    $(document).keydown(function (event) {
      if (event.keyCode == "220") {
    	  issueAutoComplete();
      } else if(event.keyCode == "221") {
    	  commentAutoComplete();
      }
    });
  };

  const issueAutoComplete = () => {
    document.getElementById("missueTtl").value = "메인 헤더 로그인 정보 오류 문제"; // 나중에 고쳐야함
    document.getElementById("mIssueCd").value = "P007-1";
    document.getElementById("missueAsg").value = "S2302101";
    document.getElementById("mCon").value = "로그인 시 학생 이름이 아니고 학생 번호로 뜹니다."; // 나중에 고쳐야함
    document.getElementById("mIssueSttsCd").value = "P006-1";
  };

  const commentAutoComplete = () => {
	document.getElementById("commentCn").value = "이슈 내용을 좀 더 자세하게 알려주세요."; // 나중에 고쳐야함
  }


  autoComplete();
</script>
