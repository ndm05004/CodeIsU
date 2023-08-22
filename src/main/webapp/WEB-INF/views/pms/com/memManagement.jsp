<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>


<!-- 공통코드 -->
<script src="${pageContext.request.contextPath}/common/sw/js/CommonCode.js"></script>

<style>
table{
    border-collapse: inherit;
}
#uProjBtn{
	margin-left: 85px;
    margin-top: 15px;
    cursor: pointer;
}
.persent{
    top: 5px;
    right: 37px;
}
.aplyCn {
    border: 1px solid #f2f2f2;
}
.aplyTech {
    border: 1px solid #f2f2f2;
}
#aplyCn, #aplyTech {
	background: #f2f2f2;
}
#projTitle, #projExpln, #projTech, #projTech2 {
	/* padding-left:20px; */
	margin-bottom:0px;
}

.projTech {
	padding-left:20px;
	margin-bottom:0px;
}

.btnStyle {
    background-color: #465b8a;
    color: white;
}
#cancleBtn {
	border: 1px solid #465b8a;
}

#mProjStatus, #memStatus{
    border: 1px solid #f2f2f2;
}

.progress-bar{
	background-color: #D71923;
}
.card {
	background-color: #ffffff;
}
.nameStyle {
	cursor: pointer;
	color: #465b8a;
    font-weight: 500;
}

#okBtn {
	background-color: #465b8a;
    color: white;
}

#noBtn {
	border: 1px solid #465b8a;
}

/* 무한 스크롤 시작 영역 */
.scroll-Wrap {
	max-height: 50px;
	overflow-y: auto;
	direction: ltr;
	scrollbar-color: #d4aa70 #e4e4e4;
}

.scroll-Wrap::-webkit-scrollbar {
 	width: 10px;  /* 세로축 스크롤바 폭 너비 */
    height: 20px;  /* 가로축 스크롤바 폭 너비 */
}

.scroll-Wrap::-webkit-scrollbar-track {
	background-color: #e4e4e4;
	border-radius: 100px;
}

.scroll-Wrap::-webkit-scrollbar-thumb {
	border-radius: 50px;
	border-left: 0;
	border-right: 0;
	background-color: #CEC8C7;
}




</style>


<!-- 프로젝트 상태 조회  -->

<div class="card mt-3 ps-3 mb-2" id="projUpdate">
	<div class="table-responsive container">
		<div class="row pt-3">
			<div class="col-10">
				<span class="h4" id="projTitle"></span>
				<span class="fs-6 ms-0 ps-2 pe-2 pt-1 pb-0" style="font-size: 12px;" id="projSttsCd"></span>
			</div>
			<div class="col-2">
				<svg id="uProjBtn" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="float-end mt-0 me-3 bi bi-pencil-square" viewBox="0 0 16 16">
		 		 <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
		 		 <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z" />
		  		</svg>
			</div>
		</div>
		<div class="row">
			<div class="col" style="color:#979797;">
				<span class="fs-6" id="projDate1"></span> ~ <span class="fs-6" id="projDate2"></span>
			</div>
		</div>
		<div class="row pt-2 mb-2">
				<div class="col fs-6" id="projExpln"></div>
		</div>

		<div class="row pt-2 mb-2">
			<div class="col-5">
				<span class="fs-6 float-start" id="projTech2">
					<i class="mt-2 fas fa-laptop-code"></i>
				</span>
				<span class="fs-6 ps-2" id="projTech"></span>
			</div>
			<div class="col-3 ps-0">
				<span class="card-text fs-6">
	   				<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="me-1 bi bi-people-fill" viewBox="0 0 16 16">
	   				  <path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1H7Zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm-5.784 6A2.238 2.238 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.325 6.325 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1h4.216ZM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5Z"/>
	   				</svg>
	  					<span id="cnt"></span>명 &nbsp;/&nbsp;
  				</span>
 				<span class="fs-6 fw-bold" id="projStatus" ></span>
			</div>
			<div class="col-1 text-end text-xs pe-0 mb-0 pt-2">
				<p class="mb-0 text-sm">진행도</p>
			</div>
			<div class="col-3 ps-0">
				<div class="position-relative" id="projectProgress"></div>
			</div>
		</div>
	</div>
</div>

<!-- 프로젝트 수정  Modal 시작-->
<div class="modal fade" id="updateProjModal" role="dialog" aria-labelledby="updateProjModalLabel" aria-hidden="true">
  <div class="modal-dialog d-flex justify-content-center" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title font-weight-normal" id="updateProjModalLabel">프로젝트 수정</h5>
        </div>

      <div class="modal-body">
         <form>
          <h5 class="modal-title font-weight-normal mb-2" id="updateProjModalLabel"></h5>

	      <label class="form-label mb-0" for="mProjNm">프로젝트명</label>
          <input type="text" class="form-control aplyCn mb-2 ps-2" id="mProjNm">
		  <label class="form-label mb-0" for="mProjExpln">프로젝트 내용</label>
          <input type="text" class="form-control aplyTech mb-2 ps-2" id="mProjExpln">
		  	<label class="form-label w-30 pt-2" for="mProjBgngDt">프로젝트 기간</label>
		  <div class="d-flex justify-content-start mb-2">
          	<input type="date" class="form-control ps-2 inputColor" id="mProjBgngDt" style="border:1px solid #E6E3E2">
		  	<span class="ps-1 pe-1 pt-2">-</span>
         	 <input type="date" class="form-control ps-2 inputColor" id="mProjDdlnDt" style="border:1px solid #E6E3E2">
		  </div>
		  <label class="form-label mb-0" for="mProjStatus">프로젝트 상태</label>
		  <select class="form-select mem mb-2" id="mProjStatus" name="mProjStatus">
		  </select>
		  <label class="form-label mb-0" for="mProjTech">기술 스택</label>
          <input type="text" class="form-control aplyTech mb-2 ps-2" id="mProjTech">


          <label class="form-label mb-0" for="taskDetailSttrDiv" style="background:#ffffff;">진행도</label>
 		  <div class="progress" style="background:#ffffff;">
		        <input class="progress-bar bg-info w-100" type="range" min="1" max="100" id="progress">
		        <div id="progressPer"></div>
		  </div><br>
		  <button type="button" class="btn btn-sm mt-2 w-100 btnStyle"
		  		  style="height:35px; border:1px solid #5f76e8;" id="projDel">프로젝트 삭제</button>
	      <div class="modal-footer">
	        <button type="button" class="btn bg msubBtn btnStyle" id="proConUpBtn">변경</button>
	        <button type="button" class="btn bg mcanBtn" data-bs-dismiss="modal" id="cancleBtn">취소</button>
	      </div>
        </form>
		</div>
      </div>
    </div>
  </div>


<!-- 프로젝트 수정  Modal 끝 -->

<!-- progress bar 이벤트 시작-->
<script>
    document.querySelector('#progress').addEventListener('input',e=>{
        document.querySelector('#progressPer').innerHTML= e.target.value+'%';
    });
</script>
<!-- progress bar 이벤트 끝-->

<script>

stuNo = "${userNo}";
const projNo = "${projNo}";
const userVO = "${userVO}";


console.log("userVO 정보 : ", userVO)
console.log("로그인 한 사람 해당 프로젝트 번호:  ", projNo)
console.log("로그인 한 사람 프로젝트 학번:  ", stuNo)
//날짜 수정
function convertDate(Cdate) {
  const year = Cdate.substring(0, 4);
  const month = Cdate.substring(4, 6);
  const day = Cdate.substring(6, 8);
  const formattedDate = year + "-" + month + "-" + day;
  return formattedDate;
}
//날짜 수정 하이픈 제거
function converDate2(Cdate){
	const formattedDate = Cdate.replaceAll("-", "");
	return formattedDate;
}

//휴대폰번호 하이픈 추가
function convertPhone(cPhone) {
  const phone1 = cPhone.substring(0, 3);
  const phone2 = cPhone.substring(3, 7);
  const phone3 = cPhone.substring(7, 11);
  const phone = phone1 + "-" + phone2 + "-" + phone3;
  return phone;
}

/*  프로젝트 내용 (맨 위 상단에 위치)   */
//서버에서 발행된 헤더네임과 토큰갑사 저장
var header = '${_csrf.headerName}';
var token =  '${_csrf.token}';

function projStatus(){
	$(function(){

		/* var projNo = 'a005'; */

			$.ajax({
				url : "/pms/projstatus",
				data: JSON.stringify({
					projNo: projNo
				}),

		    	type: 'post',
	    	    contentType:"application/json;charset=utf-8",
	            beforeSend: function(xhr) {
	                xhr.setRequestHeader(header, token);
	        	},
		    	success: function(res) {

					console.log("이것은 vo리스트:",res);
					console.log("projSttsCd 상태~~~~~~~~~~~:",res.projSttsCd);
					console.log("플젝 시작일~~~~~~~~~~~:",res.projBgngDt);


					let str ="";
					str += `
					  	<div class="progress mb-3 ms-4 mt-3" style="width:75%;">
				  		 <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: `

					str += res.projSttr
					str += `%;"></div></div>`
					str += `
					<sapn class="text-sm position-absolute persent" style="top: -8px;right: 10px;}"></span>`
					str += res.projSttr
					str +=`%
					</div>
					`
					console.log("이것은 진행률:",res.projSttr)
					$("#projectProgress").html(str);

					$("#projTitle").text(res.projNm);
					$("#projSttsCd").text(res.projSttsCd);
					$("#projExpln").text(res.projExpln);
					$("#projTech").text(res.projTech);
					$("#progress").text(res.projSttr);
					$("#projDate1").text(convertDate(res.projBgngDt));
					$("#projDate2").text(convertDate(res.projDdlnDt));
					$("#projStatus").text(res.projSttsCd);
					$("#cnt").text(res.projTnope);




		    	},

		    	    error: function(xhr) {
		    	      alert("상태: " + xhr.status);
		    	    },
		    	    dataType: 'json'
		    	  });

	})


};
projStatus();


/* 프로젝트 수정 버튼 */
$("#projUpdate").on("click", "#uProjBtn", function() {

  	/* var projNo = 'a005';
    console.log("projNotestttttttt", projNo); */

	$.ajax({
			url: "/pms/projupdate",
			type: "post",
			data: JSON.stringify({
				projNo:projNo
			}),
		    contentType:"application/json;charset=utf-8",
		       beforeSend: function(xhr) {
		           xhr.setRequestHeader(header, token);
		       },
		       success : function(res) {
		       	console.log("이것은 1: ",res)
		       	console.log("이것은 플젝제목: ",res.projNm)
		       	console.log("이것은 플젝소개: ",res.projExpln)
		       	console.log("이것은 플젝상태코드: ",res.projSttsCd)
		       	console.log("이것은 기술스택: ",res.projTech)
		       	console.log("이것은 시작일: ",res.projBgngDt)
		       	console.log("이것은 종료일: ",res.projDdlnDt)

		       	var mProjNm = res.projNm;
		       	var mProjExpln = res.projExpln;
		       	var mProjSttsCd = res.projSttsCd;
		       	var mProjTech = res.projTech;
		       	var progress = res.projSttr;
		       	var mProjBgngDt = convertDate(res.projBgngDt);
		       	var mProjDdlnDt = convertDate(res.projDdlnDt);

		       	console.log("시작일 문자 변환 : ", mProjBgngDt)
		       	console.log("종료일 문자 변환 : ", mProjDdlnDt)

		       	getCodeOptionOneSelected("P002", "mProjStatus", mProjSttsCd)

		   	    $("#updateProjModal").modal("show");
					$("#mProjNm").val(mProjNm);
					$("#mProjExpln").val(mProjExpln);
					$("#mProjStatus").val(mProjStatus);
					$("#mProjTech").val(mProjTech);
					$("#progress").val(progress);
					$("#mProjBgngDt").val(mProjBgngDt);
					$("#mProjDdlnDt").val(mProjDdlnDt);
					$("#progressPer").html(progress+"%");

		       },
	            error : function(xhr) {
	            	alert(xhr.status)
	            },
	})
});

/* 프로젝트 삭제 버튼 */
$("#updateProjModal").on("click", "#projDel", function() {

 	Swal.fire({
 		  title: '삭제하시겠습니까?',
 		  text: "삭제 후 되돌릴 수 없습니다!",
 		  icon: 'warning',
 		  showCancelButton: true,
 		  confirmButtonColor: '#3085d6',
 		  cancelButtonColor: '#d33',
 		  confirmButtonText: '프로젝트 삭제'

		}).then((result) => {
 			if (result.value) {
 				$.ajax({
 					url: "/pms/projdelete",
 					type: "post",
 					data: JSON.stringify({
 						projNo:projNo
 					}),
 					    contentType:"application/json;charset=utf-8",
 					    beforeSend: function(xhr) {
 				           xhr.setRequestHeader(header, token);
 				       },
 				       dataType: "text",
 				       success : function(res) {
 				       	console.log("이것은 삭제할 프로젝트vo: ",res)
 					    Swal.fire({
 				          icon: "success",
 				          title: "프로젝트 삭제 성공!",
 				          showConfirmButton: false,
 				          timer: 1500,
 				        });

 				       	/* 삭제 후 페이지 이동 */
						setTimeout(() => {
 				       		location.href = "javascript:goToMenu('pms_myprojects')"

						}, 1600);

 						$("#updateProjModal").modal("hide");
 				       },
 			            error : function(xhr) {
 			            	alert(xhr.status)
 			            },
 			})

 			}

	 	})

});

/* 프로젝트 내용 변경 버튼 (프로젝트 수정 버튼 누르고 들어가서 변경) */
$("#updateProjModal").on("click", "#proConUpBtn", function() {

    var data = {
			projNo:projNo,
			projNm :$("#mProjNm").val(),
			projExpln :$("#mProjExpln").val(),
			projSttsCd :$("#mProjStatus").val(),
			projTech :$("#mProjTech").val(),
			projSttr :$("#progress").val(),
			projBgngDt :converDate2($("#mProjBgngDt").val()),
			projDdlnDt :converDate2($("#mProjDdlnDt").val())

    };
	console.log("dataaaaaaaaaa:", data)

		$.ajax({
				url: "/pms/proj/conupdate",
				type: "post",
				data: JSON.stringify(data),
				contentType:"application/json;charset=utf-8",
				beforeSend: function(xhr) {
			         xhr.setRequestHeader(header, token);
			    },
			    dataType: "text",
			    success : function(res) {
			      console.log("이것은 변경할 프로젝트vo: ",res)
			      Swal.fire(
            			  '수정 완료',
            			  '프로젝트 내용이 변경되었습니다!',
            			  'success'
            			)

			       	//화면에 적용
			       	projStatus();


					$("#updateProjModal").modal("hide");
			       },
		            error : function(xhr) {
		            	alert(xhr.status)
		            },
		})



});





/* 멤버관리 직책 수정 완료 */
$.positionUpdate = function(jbttlCd, stuNo, projNo){

    $.ajax({
            url : "/pms/memupdate?${_csrf.parameterName }=${_csrf.token}",
            type : 'post',
            data : {
            	jbttlCd:jbttlCd,
            	stuNo:stuNo,
            	projNo:projNo
            },
            dataType : 'text',
            success : function(res) {
            	Swal.fire(
            			  '수정 완료',
            			  '직책 변경이 완료 되었습니다!',
            			  'success'
            			)
            //화면(본문의 내용) 바꾸기
               memManage();


            },
            error : function(xhr) {
            	alert(xhr.status)
            },
    })

}

</script>


<!-- 프로젝트 가입 신청 리스트  -->
<sapn class="fs-6">&nbsp; 가입 신청 리스트</span>
<div class="card mb-2">
  <div class="table-responsive"><br>
    <table class="table align-items-center mb-0" id="memJoinTable">
    </table>
  </div>
</div>

<!-- 가입 신청 멤버 승인 Modal 시작-->
<div class="modal fade" id="joinMemModal" role="dialog" aria-labelledby="joinMemModalLabel" aria-hidden="true">
  <div class="modal-dialog d-flex justify-content-center" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title font-weight-normal" id="joinMemModalLabel"></h5>
        </div>

      <div class="modal-body">
         <form>
          <h5 class="modal-title font-weight-normal mb-2" id="joinMemModalLabel">신청 내용</h5>
		  <div class="container">
		  	<div class="row">
		  		<div class="col-3 pt-2 ps-0">
	     			<label class="form-label" for="aplyCn">자기소개</label>
	     		</div>
	     		<div class="col-9">
        		    <p class="form-control aplyCn mb-2 ps-2" id="aplyCn"></p>
        		</div>
        	</div>
		  	<div class="row">
		  		<div class="col-3 pt-2 ps-0">
		 		    <label class="form-label" for="aplyTech">기술스택</label>
	     		</div>
	     		<div class="col-9">
         		    <p class="form-control aplyTech mb-2 ps-2" id="aplyTech"></p>
        		</div>
        	</div>
          	</div>
	      <div class="modal-footer">
	        <button type="button" class="btn bg msubBtn" id="okBtn">승인</button>
	        <button type="button" class="btn bg msubBtn" id="noBtn">거절</button>
	      </div>
        </form>
      </div>
    </div>
  </div>
</div>
<!-- 가입 신청 멤버 승인 Modal 끝-->

<script>


/* 가입신청 멤버 리스트 출력  */
function joinMemList(){
	$(function(){

		/* var projNo = 'a005'; */

			$.ajax({
				url : "/pms/memjoinaply?${_csrf.parameterName }=${_csrf.token}",
				data: {
					projNo: projNo
				},

		    	type: 'post',

		    	success: function(res) {

		    		code = "";
		    		code += `
		    	        <tr>
		    	          <th class="text-center text-uppercase text-secondary fs-6 font-weight-bolder opacity-5 mb-2">이름</th>
		    	          <th class="text-center text-uppercase text-secondary fs-6 font-weight-bolder opacity-5 mb-2">신청일</th>
		    	        </tr>
		    		`;

		    		if(res.length === 0){
		    			code += `
				           <tr>
		    				  <td colspan="2" class="text-center fs-6 font-weight-bolder pt-4 pb-3"> 가입 신청 내역이 없습니다. </td>
		    			   </tr>
		    			   `;
		    		} else{
			    		$.each(res, function(i, v){
			    		code +=`
			    			  <tr>
			    				  <td class="align-middle text-center text-sm">
						            <p class="fs-6 font-weight-border nameStyle" name="userNm" idx=\${v.stuNo} id="userNm2">\${v.userNm}</p>
						          </td>
						          <td class="align-middle text-center text-sm">
						            <p class="text-secondary fs-6 font-weight-normal" name="applyDate" id="applyDate">\${v.applyDate.substring(0, 10)}</p>
						          </td>
						          <td>
						            <input type="hidden" class="stuNo" name="stuNo" id="stuNo" value="\${v.stuNo}">
								  </td>
					          </tr>
			    			`;
			    		})
		    		}
		    	    $('#memJoinTable').html(code);

		    	},
		        error: function (request, status, error) {
		            console.log("code: " + request.status)
		            console.log("message: " + request.responseText)
		            console.log("error: " + error);
		        },
		    	    dataType: 'json'
		    	  });

	})


}

/*  가입신청 멤버 모달 이벤트 */
//서버에서 발행된 헤더네임과 토큰갑사 저장
var header = '${_csrf.headerName}';
var token =  '${_csrf.token}';

$(document).ready(function() {
	  $("#memJoinTable").on("click", "p[name='userNm']", function() {

	    /* var stuNo = $(this).closest("tr").find(".stuNo").val(); */
	    var stuNo = $(this).attr("idx");
	    var userNm = $(this).text();
	    console.log("userNm : ", userNm)


	    console.log("stuNo: test idx ", stuNo);

	     $.ajax({
	    	 url : "/pms/memjoindetail",
	            type : 'post',
	            data :  JSON.stringify({
	            	stuNo:stuNo,
	            	projNo:projNo
	            }),
	            contentType:"application/json;charset=utf-8",
	            beforeSend: function(xhr) {
	                xhr.setRequestHeader(header, token);
	        	},
	            success : function(res) {
					console.log("이건가",res)
	            	$("#joinMemModalLabel").text(userNm+"님의 지원서");

	            	var aplyCn = res.aplyCn;
	            	var aplyTech = res.aplyTech;
	            	console.log('memjoin ',aplyCn)
	            	console.log('memjoin ',aplyTech)


	            	$("#joinMemModal").modal("show");
	         	    $("#stuNo").val(stuNo);
	         	    $("#aplyCn").text(aplyCn);
	         	    $("#aplyTech").text(aplyTech);

	         	   // 내용에 대해 줄바꿈 처리 추가
	    	        var content = res.aplyCn.replace(/<br>/g, "\n");
	    	        $("#aplyCn").html(content);

	            },
	            error: function (request, status, error) {
	                console.log("code: " + request.status)
	                console.log("message: " + request.responseText)
	                console.log("error: " + error);
	            }
	    })

	    })


joinMemList();


/*  가입신청 멤버 승인 */
	$("#okBtn").on("click", function(){

		var stuNo = $("#stuNo").val();


		console.log("okMemStuNo",stuNo);

        Swal.fire(
           			  '승인 완료',
           			  '지원서 승인이 완료 되었습니다!',
           			  'success'
           			)

	 	//서버로 보내기
		addMemManage(stuNo);
	 	//memCount(stuNo);

		$("#joinMemModal").modal("hide");

	})


/*  가입신청 멤버 거절  */
	$("#noBtn").on("click", function(){

		var stuNo = $("#stuNo").val();

		console.log("noMemStuNo",stuNo);

		Swal.fire(
       			  '거절 완료',
       			  '지원서 거절이 완료 되었습니다!',
       			  'success'
       			)


	 /* 서버로 보내기 */
		delMemManage(stuNo);

		$("#joinMemModal").modal("hide");
	})




})

/* 승인 클릭시 멤버관리에 추가 */
 function addMemManage(stuNo){

	 $.ajax({
            url : "/pms/meminsert",
            type : 'post',
            data : JSON.stringify({
            	stuNo:stuNo,
            	projNo:projNo
            }),
            contentType:"application/json;charset=utf-8",
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);
        	},
            success : function(res) {
				console.log("이것은stuNoㅎㅎ",res);

                //화면(본문의 내용) 바꾸기
                joinMemList();
                memManage();
            },
            dataType:"text",
	        error: function (request, status, error) {
	            console.log("code: " + request.status)
	            console.log("message: " + request.responseText)
	            console.log("error: " + error);
	        }
    });

};

/* 승인 클릭시 가입신청 리스트에 삭제  */

function delMemManage(stuNo){

	 $.ajax({
           url : "/pms/memdel",
           type : 'post',
           data : JSON.stringify({
           	stuNo:stuNo,
           	projNo:projNo
           }),
           contentType:"application/json;charset=utf-8",
           beforeSend: function(xhr) {
               xhr.setRequestHeader(header, token);
       	   },
           success : function(res) {
           //화면(본문의 내용) 바꾸기
              joinMemList();

           },
           dataType:"text",
           error : function(xhr) {
           	console.log(xhr.status);
           }
   });

};

</script>





<!-- 프로젝트 멤버 리스트 출력 -->
<sapn class="mt-2 fs-6">&nbsp; 멤버 리스트</sapn>
<div class="card mb-5">
  <div class="table-responsive"><br>
<!-- <button class="btn btn-primary btn-sm" style="float: right; margin-right:30px;" type="button">자료등록</button> <br> -->
    <table class="table align-items-center mb-0" id="memManage">
    </table>
  </div>
</div>


<!-- Modal 시작-->
<div class="modal fade" id="positionUpdateModal" role="dialog" aria-labelledby="memUpdateModalLabel" aria-hidden="true">
  <div class="modal-dialog d-flex justify-content-center" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title font-weight-normal" id="memUpdateModalLabel">직책 변경</h5>
        </div>

      <div class="modal-body">
         <form>
		<div class="d-flex justify-content-start mb-3">
	      <label class="w-20 form-label pt-2" for="memStatus">직책</label>
	      <select class="ps-3 form-select mem" id="memStatus" name="memStatus">

		  </select>
		</div>
	      <div class="modal-footer">
	        <button type="button" class="btn bg msubBtn btnStyle" id="updateBtn">수정</button>
	        <button type="button" class="btn bg mcanBtn" data-bs-dismiss="modal" id="cancleBtn">취소</button>
	      </div>
        </form>
      </div>
    </div>
  </div>
</div>
<!-- Modal 끝-->

<script>


/* 멤버관리 리스트 조회 */
function memManage(){
	$(function(){

	/* 	var projNo = 'a005'; */

			$.ajax({
				url : "/pms/mem",
				data: projNo,
			    contentType:"application/json;charset=utf-8",
	            beforeSend: function(xhr) {
	                xhr.setRequestHeader(header, token);
	        	},
		    	type: 'post',

		    	success: function(res) {
		    		code = "";
		    		code += `
		    	        <tr>
		    			  <th class="text-center text-uppercase text-secondary fs-6 font-weight-bolder opacity-5">이름</th>
		    			  <th class="text-center text-uppercase text-secondary fs-6 font-weight-bolder opacity-5">이메일</th>
		    	          <th class="text-center text-uppercase text-secondary fs-6 font-weight-bolder opacity-5">전화번호</th>
		    	          <th class="text-center text-uppercase text-secondary fs-6 font-weight-bolder opacity-5">가입일</th>
		    	          <th class="text-center text-uppercase text-secondary fs-6 font-weight-bolder opacity-5">직책</th>
		    	        </tr>

		    		`;
		    		$.each(res, function(i, v){
		    		code += `
				           <tr>
		    				  <td>
					            <div class="text-center">
					              <div class="d-flex flex-column justify-content-center">
					                <h6 class="text-secondary text-center fs-6 font-weight-border" name="userNm" id="userNm">\${v.userNm}</h6>
					              </div>
					            </div>
					          </td>
					          <td class="align-middle text-left text-sm w-30">
					            <span class="text-secondary fs-6 font-weight-normal ps-7" name="userEmlAddr" id="userEmlAddr">\${v.userEmlAddr}</span>
					          </td>
					          <td class="align-middle text-center text-sm">
					            <span class="text-secondary fs-6 font-weight-normal" name="userPhoneno" id="userPhoneno">\${convertPhone(v.userPhoneno)}</span>
					          </td>
					          <td class="align-middle text-center">
					            <span class="text-secondary fs-6 font-weight-normal" name="teamJoinDt" id="teamJoinDt">\${v.teamJoinDt.substring(0,10)}</span>
					          </td>
					          <td class="align-middle text-center">
					            <span class="fs-6 font-weight-normal" style="color: #5f76e8;"
					            			data-bs-toggle="modal" data-bs-target="#positionUpdateModal" name="jbttlCd" id="jbttlCd">\${v.jbttlCd}
						            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down" viewBox="0 0 16 16">
						            <path d="M3.204 5h9.592L8 10.481 3.204 5zm-.753.659 4.796 5.48a1 1 0 0 0 1.506 0l4.796-5.48c.566-.647.106-1.659-.753-1.659H3.204a1 1 0 0 0-.753 1.659z"/>
						            </svg>
					            </span>
					          </td>
					          <td>
					            <input type="hidden" name="stuNo" id="stuNo" value="\${v.stuNo}">
							  </td>
					        </tr>
		    			`;
		    		})
		    	    $('#memManage').html(code);
		    	},

		        error: function (request, status, error) {
		            console.log("code: " + request.status)
		            console.log("message: " + request.responseText)
		            console.log("error: " + error);
		        },
		    	    dataType: 'json'
		    	  });

	})


}
memManage();


/* 멤버 직책 변경 모달 이벤트 */
$(document).ready(function() {
	  $("#memManage").on("click", "#jbttlCd", function() {
	    var stuNo = $(this).closest("tr").find("#stuNo").val();
		var jbttlCd= $(this).text();

	    console.log("stuNo", stuNo);
	    console.log("jbttlCd", jbttlCd);

	    getCodeOptionOneSelected("P001", "memStatus", jbttlCd)

		//$("#memStatus").val(jbttlCd); //옵션 데이터 설정

		$("#positionUpdateModal").modal("show");
	    $("#stuNo").val(stuNo);
	  });

/* 멤버관리 직책 수정 */
	$("#updateBtn").on("click", function(){
		var jbttlCd = $("#memStatus").val();   //선택한 옵션 값 가져와서 저장하기
		var stuNo = $("#stuNo").val();

		console.log(jbttlCd+"직책");
		console.log(stuNo+"학번");

	 //서버로 보내기
		$.positionUpdate(jbttlCd, stuNo, projNo);

		$("#positionUpdateModal").modal("hide");
	})

})






</script>