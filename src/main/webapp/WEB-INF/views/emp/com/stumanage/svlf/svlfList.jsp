<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
#mainDiv, #mainDiv2{
	height: 330px;
}

.svModal{
	width: 115px;
}

#mainTable1, #mainTable2{
	display: block;
}

#mainTable1 tbody, #mainTable2 tbody{
	display: block;
	max-height: 250px;
	overflow: auto;
}

#mainTable1 tbody tr{
	cursor: pointer;
}

/* 현재 width의 총 길이는 1100px로 1100px에 맞추면은 들어맞는다 */
#mainTable1 th:nth-of-type(1), #mainTable1 td:nth-of-type(1) { width: 110px; text-align: center }
#mainTable1 th:nth-of-type(2), #mainTable1 td:nth-of-type(2) { width: 170px; text-align: center; }
#mainTable1 th:nth-of-type(3), #mainTable1 td:nth-of-type(3) { width: 170px; text-align: center; }
#mainTable1 th:nth-of-type(4), #mainTable1 td:nth-of-type(4) { width: 400px; }
#mainTable1 th:nth-of-type(5), #mainTable1 td:nth-of-type(5) { width: 100px;  text-align: center;}

#mainTable2 th:nth-of-type(1), #mainTable2 td:nth-of-type(1) { width: 110px; text-align: center }
#mainTable2 th:nth-of-type(2), #mainTable2 td:nth-of-type(2) { width: 170px; text-align: center; }
#mainTable2 th:nth-of-type(3), #mainTable2 td:nth-of-type(3) { width: 170px; text-align: center; }
#mainTable2 th:nth-of-type(4), #mainTable2 td:nth-of-type(4) { width: 400px; }
#mainTable2 th:nth-of-type(5), #mainTable2 td:nth-of-type(5) { width: 100px;  text-align: center;}

#mainTable1 th:last-child, #mainTable2 th:last-child{
	width: 150px;
	text-align: center;
}

#mainTable1 td:last-child,  #mainTable2 td:last-child{
	text-align: center;
	width: 150px;
}

.card{
	margin-bottom: 10px;
}
</style>
<div class="row">
	<div class="col-12">

		<div class="card">
			<div class="card-body">
				<div class="row align-items-end" style="height: 35px;">
					<div class="col-6" style="padding: 0;">
						<label class="col-form-label col-form-label-sm">전체 과정 </label>
						<label class="col-form-label col-form-label-sm" style="font-weight: bold;color: red;">${fn:length(svlfList)}</label>
						<label class="col-form-label col-form-label-sm">건</label>
					</div>
					<div class="col-6" style="text-align: right; padding: 0; padding-bottom: 5px;">
						<button type="button" class="btn btn-dark btn-sm" id="svlfBtn">연수과정 생성</button>
					</div>
				</div>
				<div id="mainDiv" class="row">
					<div class="col" style="padding: 0;">
						<table id="mainTable1" class="table table-bordered table-hover">
							<thead class="table-secondary">
								<tr>
									<th colspan="6" class="p-2" style="text-align: center;">진행중인 연수과정</th>
								</tr>
								<tr>
									<th class="p-2">연수과정번호</th>
									<th class="p-2">시작일</th>
									<th class="p-2">종료일</th>
									<th class="p-2" style="text-align: center;">이름</th>
									<th class="p-2">호실</th>
									<th class="p-2">담임</th>
								</tr>
							</thead>
							<tbody id="svlfBody" class="table">
								<c:set value="${svlfList }" var="svlfList"/>
								<c:choose>
									<c:when test="${empty svlfList }">
										<tr>
											<td colspan="6">조회할 게시물이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${svlfList }" var="svlf">
											<tr>
												<td class="p-2">${svlf.svlfNo }</td>
												<td class="p-2">${svlf.svlfBgngDt }</td>
												<td class="p-2">${svlf.svlfDdlbDt }</td>
												<td class="p-2">${svlf.svlfNm }</td>
												<td class="p-2">${svlf.lectureRoomNm }</td>
												<td class="p-2">${svlf.userNm }</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

		<div class="card">
			<div class="card-body">
				<div class="row align-items-end">
					<div class="col" style="padding: 0;">
						<label class="col-form-label col-form-label-sm">전체 과정 </label>
						<label class="col-form-label col-form-label-sm" style="font-weight: bold;color: red;">${fn:length(noSvlfList)}</label>
						<label class="col-form-label col-form-label-sm">건</label>
					</div>
				</div>

				<div id="mainDiv2" class="row">
					<div class="col" style="padding: 0;">
						<table class="table table-bordered" id="mainTable2">
							<thead class="table-secondary">
								<tr>
									<th colspan="6" class="p-2" style="text-align: center;">종료된 연수과정</th>
								</tr>
								<tr>
									<th class="p-2">연수과정번호</th>
									<th class="p-2">시작일</th>
									<th class="p-2">종료일</th>
									<th class="p-2" style="text-align: center;">이름</th>
									<th class="p-2">호실</th>
									<th class="p-2">담임</th>
								</tr>
							</thead>
							<tbody id="endSvlfBody" class="table">
								<c:set value="${noSvlfList }" var="noSvlfList"/>
								<c:choose>
									<c:when test="${empty noSvlfList }">
										<tr>
											<td colspan="6">조회할 게시물이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${noSvlfList }" var="nosvlf">
											<tr>
												<td class="p-2">${nosvlf.svlfNo }</td>
												<td class="p-2">${nosvlf.svlfBgngDt }</td>
												<td class="p-2">${nosvlf.svlfDdlbDt }</td>
												<td class="p-2">${nosvlf.svlfNm }</td>
												<td class="p-2">${nosvlf.lectureRoomNm }</td>
												<td class="p-2">${nosvlf.userNm }</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

	</div>
</div>

<!-- 연수과정 등록 모달 -->
<div class="modal fade" id="svlfModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="staticBackdropLabel">연수과정 등록</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div id="mBody" class="modal-body">
				<!-- 숨겨져 있는 연수과정 번호 -->
				<input id="svlNo" type="hidden" class="form-control">

				<div class="input-group mb-3 text-center">
					 <label class="input-group-text svModal" for="inputGroupSelect01" style="width: 100px;">시작일</label>
					 <input id="svlStart" type="date" class="form-control">
				</div>
				<div class="input-group mb-3 text-center">
					 <label class="input-group-text svModal" for="inputGroupSelect01" style="width: 100px;">수료일</label>
					 <input id="svlEnd" type="date" class="form-control">
				</div>
				<div class="input-group mb-3 text-center">
					 <label class="input-group-text svModal" for="inputGroupSelect01" style="width: 100px;">연수과정명</label>
					 <input id="svlName" type="text" class="form-control">
				</div>
				<div class="input-group mb-3 text-center">
					 <label class="input-group-text svModal" for="inputGroupSelect01" style="width: 100px;">호실</label>
					 <select id="roomNo" class="form-select">
					 	<option>--선택하세요--</option>
					 </select>
				</div>
				<div class="input-group mb-3 text-center">
					 <label class="input-group-text svModal" for="inputGroupSelect01" style="width: 100px;">담임</label>
					 <select id="teachNo" class="form-select">
					 	<option>--선택하세요--</option>
					 </select>
				</div>
				<div class="input-group mb-3 text-center">
					 <label class="input-group-text svModal" for="inputGroupSelect01" style="width: 100px;">연수내용</label>
					 <textarea id="svlfText" class="form-control" aria-label="With textarea" rows="5"></textarea>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" id="addBtn" class="btn btn-primary">등록</button>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="svlDetailModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="staticBackdropLabel">연수과정 상세보기</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div id="detailBody" class="modal-body">

			</div>
			<!-- <div class="modal-footer">
				<button type="button" id="modiBtn" class="btn btn-primary">수정</button>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			</div> -->
		</div>
	</div>
</div>

<!-- <div class="modal fade" id="modiModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="staticBackdropLabel">연수과정 수정</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div id="modiBody" class="modal-body">

			</div>
			<div class="modal-footer">
				<button type="button" id="modiAddBtn" class="btn btn-primary">수정완료</button>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div> -->

<script type="text/javascript">
var header = '${_csrf.headerName}';
var token =  '${_csrf.token}';
$(function(){
	var svlfBtn = $("#svlfBtn");

	svlfBtn.on("click", function(){
		$("#svlfModal").modal("show");
	})

	$("#svlfBody").on("click", "tr", function(){
		let no = $(this).find("td:eq(0)").text();

		if(no != "조회할 게시물이 없습니다."){
			svlfInfo(no);

			$("#svlDetailModal").modal("show");
		}
	})

	$("#svlStart").on("change", function(){
		$("#svlEnd").val("");
		$("#roomNo").val("");
	})

	$("#svlEnd").on("change", function(){
		$("#roomNo").val("");

		let sDay = $("#svlStart").val();
		let eDay = $("#svlEnd").val();

		data = {
			"svlfBgngDt" : sDay,
			"svlfDdlbDt" : eDay
		}

		roomList(data)
	})

	$("#roomNo").on("change", function(){
		$("#teachNo").val("");

		let sDay = $("#svlStart").val();
		let eDay = $("#svlEnd").val();

		data = {
			"svlfBgngDt" : sDay,
			"svlfDdlbDt" : eDay
		}

		teachList(data);
	})

	$("#addBtn").on("click", function(){
		let svlfBgngDt = $("#svlStart").val();
		let svlfDdlbDt = $("#svlEnd").val();
		let svlfNm = $("#svlName").val();
		let lectureRoomCd = $("#roomNo").val();
		let svlfCn = $("#svlfText").val();
		let empNo = $("#teachNo").val();


		let svlfNo = svlfBgngDt.replace(/-/g, "");

	    if (svlfBgngDt === '') {
	      Swal.fire({
	    	  icon:'warning',
	    	  title:'다시 입력하세요',
	    	  text:'시작날이 선택되지 않았습니다.'
	      })
	      $("#svlStart").focus();
	      return false;
	    }

	    if (svlfDdlbDt === '') {
    	 Swal.fire({
	    	  icon:'warning',
	    	  title:'다시 입력하세요',
	    	  text:'수료날이 선택되지 않았습니다.'
	      })
	      $("#svlEnd").focus();
	      return false;
	    }

	    if (svlfDdlbDt < svlfBgngDt){
	    	Swal.fire({
			     icon:'warning',
			     title:'다시 입력하세요',
			     text:'수료일이 시작일보다 앞에 있습니다.'
		    })
	    	$("#svlEnd").focus();
	    	return false;
	    }

	    if (svlfNm === '') {
	    	Swal.fire({
			     icon:'warning',
			     title:'입력해주세요',
			     text:'연구과정명을 입력해주세요.'
		    })
		    $("#svlName").focus();
		    return false;
	    }

	    if (lectureRoomCd === 'empty') {
	    	Swal.fire({
			     icon:'warning',
			     title:'선택해주세요',
			     text:'호실을 선택해주세요.'
		    })
	      $("#roomNo").focus();
	      return false;
	    }

	    if (empNo === 'empty') {
	    	Swal.fire({
			     icon:'warning',
			     title:'선택해주세요',
			     text:'담임선생님을 선택해주세요.'
		    })
	      $("#teachNo").focus();
	      return false;
	    }

	    if (svlfCn === '') {
	    	Swal.fire({
			     icon:'warning',
			     title:'입력해주세요',
			     text:'연수내용을 선택해주세요.'
		    })
	      $("#svlfText").focus();
	      return false;
	    }

	    data = {
	    	"svlfNo" : svlfNo,
	    	"svlfBgngDt" : svlfBgngDt,
	    	"svlfDdlbDt" : svlfDdlbDt,
	    	"svlfNm" : svlfNm,
	    	"lectureRoomCd" : lectureRoomCd,
	    	"svlfCn" : svlfCn,
	    	"empNo" : empNo
	    }

	    svlfInsert(data);
	})



	//svlfBody의 높이를 넘었을 때 스크롤 생성에 대비하여 스크롤의 너비를 뺴준다.
	var listLength = "${fn:length(svlfList) }";
	if(listLength >= 7){
		$("#svlfBody").find("td:last-child").css("width", "calc(150px - 17px)");
	}

	//svlfBody의 높이를 넘었을 때 스크롤 생성에 대비하여 스크롤의 너비를 뺴준다.
	var listLength = "${fn:length(noSvlfList) }";
	if(listLength >= 7){
		$("#endSvlfBody").find("td:last-child").css("width", "calc(150px - 17px)");
	}

	var num = 0;

	$(document).keydown(function(event) {
	     if (event.keyCode == '220') {

	    	 //svlfauto();
	    	if(num === 0){
		    	num += 1;

		    	$("#svlStart").val("2023-08-10")
				$("#svlEnd").val("2024-04-08")
				$("#svlName").val("풀스택 개발자 양성과정 8회차")

				let sDay = $("#svlStart").val();
				let eDay = $("#svlEnd").val();

				data = {
					"svlfBgngDt" : sDay,
					"svlfDdlbDt" : eDay
				}

				roomList(data)
	    	}else if(num === 1){
		    	 num += 1;
		    	 $("#roomNo").prop('selectedIndex', $("#roomNo")[0].options.length - 1);

		    	 let ssDay = $("#svlStart").val();
		 		 let eeDay = $("#svlEnd").val();

		 		 data = {
		 		 	"svlfBgngDt" : ssDay,
		 			"svlfDdlbDt" : eeDay
		 		 }

		 		 teachList(data);
		    }else if(num === 2){
		    	$("#teachNo").prop('selectedIndex', $("#teachNo")[0].options.length - 1);
				$("#svlfText").text("백앤드, 프론트앤드, SQL, DB를 배워 풀스택 개발자가 될 수 있습니다.");
		    }
	     }
	})

	/* $("#modiBtn").on("click", function(){
		$("#svlDetailModal").modal("hide");
		$("#modiModal").modal("show");

		let no = $("#svlfInfoNo").val();

		svlfModi(no)
	}) */

	/*$("#svlfBody").on("click", "tr", function(){
		let no = $(this).find("td:eq(0)").text();

		location.href = "/emp/svlf/svlfDetail?svlfno="+no;
	})

	$("#endSvlfBody").on("click", "tr", function(){
		let no = $(this).find("td:eq(0)").text();

		location.href = "/emp/svlf/svlfDetail?svlfno="+no;
	}) */
})

function roomList(data){
	$.ajax({
		url : "/emp/svlf/roomList",
		type : "get",
		data : data,
		dataType : "json",
		success : function(res){
			str = "";

			if(res.length == 0){
				str +=`
					<option>선택 가능한 강의실이 없습니다.</option>
				`
			}else{
				str +=`
					<option value="empty">--강의실을 선택해주세요--</option>
				`
				for(let i=0; i<res.length; i++){
					str +=`
						<option value="\${res[i].lectureRoomCd}">\${res[i].lectureRoomNm}</option>
					`
				}
			}

			$("#roomNo").html(str);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function teachList(data){
	$.ajax({
		url : "/emp/svlf/teachList",
		type : "get",
		data : data,
		dataType : "json",
		success : function(res){
			str = "";

			if(res.length == 0){
				str +=`
					<option>선택 가능한 강의실이 없습니다.</option>
				`
			}else{
				str +=`
					<option value="empty">--강사를 선택해주세요--</option>
				`
				for(let i=0; i<res.length; i++){
					str +=`
						<option value="\${res[i].empNo}">\${res[i].userNm}</option>
					`
				}
			}

			$("#teachNo").html(str);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function svlfInsert(data){
	$.ajax({
		url : "/emp/svlf/svlfInsert",
		type : "post",
		contentType : "application/json;charset=utf-8",
		beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
		},
		data : JSON.stringify(data),
		dataType : "text",
		success : function(res){
			if(res == "성공"){
				$("#svlfModal").modal("hide");
				Swal.fire({
                    icon: 'success',
                    title: '등록 성공',
                    text: '연수과정이 정상적으로 등록되었습니다.',
                }).then((result) => {
                    if (result.isConfirmed) {
                    	location.href = "/emp/svlf/svlfList";
                    }
                });
			}else if(res == "실패"){
				alert("등록에 실패했습니다.")
			}
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function svlfInfo(no){
	$.ajax({
		url : "/emp/svlf/svlfInfo",
		type : "get",
		data : {"no" : no},
		dataType : "json",
		success : function(res){
			str = "";

			str += `
				<div class="input-group mb-3">
					 <label class="input-group-text" for="inputGroupSelect01" style="width: 115px;">연수과정번호</label>
					 <input type="text" id="svlfInfoNo" value="\${res.svlfNo}" class="form-control" readonly>
				</div>
				<div class="input-group mb-3">
					 <label class="input-group-text" for="inputGroupSelect01" style="width: 115px;">시작일</label>
					 <input type="text" value="\${res.svlfBgngDt}" class="form-control" readonly>
				</div>
				<div class="input-group mb-3">
					 <label class="input-group-text" for="inputGroupSelect01" style="width: 115px;">수료일</label>
					 <input type="text" value="\${res.svlfDdlbDt}" class="form-control" readonly>
				</div>
				<div class="input-group mb-3">
					 <label class="input-group-text" for="inputGroupSelect01" style="width: 115px;">연수과정명</label>
					 <input type="text" value="\${res.svlfNm}" class="form-control" readonly>
				</div>
				<div class="input-group mb-3">
					 <label class="input-group-text" for="inputGroupSelect01" style="width: 115px;">호실</label>
					 <input type="text" value="\${res.lectureRoomNm}" class="form-control" readonly>
				</div>
				<div class="input-group mb-3">
					 <label class="input-group-text" for="inputGroupSelect01" style="width: 115px;">담임</label>
					 <input type="text" value="\${res.userNm}" class="form-control" readonly>
				</div>
				<div class="input-group mb-3">
					 <label class="input-group-text" for="inputGroupSelect01" style="width: 115px;">연수내용</label>
					 <textarea class="form-control" aria-label="With textarea" rows="5" readonly>\${res.svlfCn}</textarea>
				</div>`

				$("#detailBody").html(str);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

/* function svlfModi(no){
	$.ajax({
		url : "/emp/svlf/svlfInfo",
		type : "get",
		data : {"no" : no},
		dataType : "json",
		success : function(res){
			str = "";

			str += `
				<div class="input-group mb-3">
					 <label class="input-group-text" for="inputGroupSelect01">연수과정번호</label>
					 <input type="text" id="svlfInfoNo" value="\${res.svlfNo}" class="form-control" readonly>
				</div>
				<div class="input-group mb-3">
					 <label class="input-group-text" for="inputGroupSelect01">시작일</label>
					 <input type="text" value="\${res.svlfBgngDt}" class="form-control" readonly>
				</div>
				<div class="input-group mb-3">
					 <label class="input-group-text" for="inputGroupSelect01">수료일</label>
					 <input type="text" value="\${res.svlfDdlbDt}" class="form-control" readonly>
				</div>
				<div class="input-group mb-3">
					 <label class="input-group-text" for="inputGroupSelect01">연수과정명</label>
					 <input type="text" value="\${res.svlfNm}" class="form-control" readonly>
				</div>
				<div class="input-group mb-3">
					 <label class="input-group-text" for="inputGroupSelect01">호실</label>
					 <input type="text" value="\${res.lectureRoomNm}" class="form-control" readonly>
				</div>
				<div class="input-group mb-3">
					 <label class="input-group-text" for="inputGroupSelect01">담임</label>
					 <input type="text" value="\${res.userNm}" class="form-control" readonly>
				</div>
				<div class="input-group mb-3">
					 <label class="input-group-text" for="inputGroupSelect01">연수내용</label>
					 <textarea class="form-control" aria-label="With textarea" rows="5" readonly>\${res.svlfCn}</textarea>
				</div>`

				$("#modiBody").html(str);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
} */
</script>