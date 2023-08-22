<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
.datepicker{
	z-index:1151 !important;
}

#startDatepicker, #endDatepicker {
	cursor: pointer;
}

#mainDiv, #seconBox{
	height: 300px;
}

#sbjTable, #stuInfoTb{
	display: block;
}

#sbjTable tbody, #stuInfoTb tbody{
	display: block;
	max-height: 215px;
	overflow: auto;
}

.stModal{
	width: 85px;
}

.form-check-input{
	margin-left: 15px;
	cursor: pointer;
}

.form-check-label{
	cursor: pointer;
}


/* 현재 width의 총 길이는 1100px로 1100px에 맞추면은 들어맞는다 */
#sbjTable th:nth-of-type(1) {width: 350px;text-align: center;}
#sbjTable th:nth-of-type(2) {width: 350px;text-align: center;}
#sbjTable th:nth-of-type(3) {width: 175px;text-align: center;}
#sbjTable th:nth-of-type(4) {width: 175px;text-align: center;}

#sbjTable td:nth-of-type(1) {width: 350px;}
#sbjTable td:nth-of-type(2) {width: 350px;}
#sbjTable td:nth-of-type(3) {width: 175px;text-align: center;}
#sbjTable td:nth-of-type(4) {width: 175px;text-align: center;}

#sbjTable th:last-child{
	text-align: center;
	width: 100px;
}

#sbjTable td:last-child{
	text-align: center;
	width: 100px;
}

/* stuInfoTb테이블의 width의 총 길이는 400px */
#stuInfoTb th:nth-of-type(1), #stuInfoTb td:nth-of-type(1) {width: 225px; text-align: center;}

#stuInfoTb th:last-child{
	text-align: center;
	width: 225px;
}

#stuInfoTb td:last-child{
	text-align: center;
	width: 225px;
}

/* 테이블 스크롤 만들기 */
</style>
<div class="row">
	<div class="col-12">

		<div class="card" style="margin-bottom: 10px;">
			<div class="card-body" style="padding-top: 10px;padding-bottom: 5px;">
				<div class="row align-items-center justify-content-start" style="margin-bottom: 10px;">
					<div class="col-2" style="padding: 0;">
						<select class="form-select" id="meselect">
							<option value="empty">-선택-</option>
							<option value="svlf">과정</option>
							<option value="sbName">수업명</option>
							<option value="sTime">시작일</option>
							<option value="eTime">종료일</option>
							<option value="hour">시간대</option>
						</select>
					</div>
					<div class="col-5" id="checkDiv">
					</div>
				</div>
				<div id="mainDiv" class="row">
					<div class="col" style="padding: 0;">
						<table class="table table-bordered table-hover" id="sbjTable">
							<thead class="table-secondary">
								<tr>
									<th colspan="5" class="p-2" style="text-align: center;">수업 목록</th>
								</tr>
								<tr>
									<th class="p-2">과정</th>
									<th class="p-2">수업명</th>
									<th class="p-2">시작일</th>
									<th class="p-2">종료일</th>
									<th class="p-2">시간대</th>
								</tr>
							</thead>
							<tbody id="sbjctBody">
								<c:set value="${sbjctList }" var="sbjctList" />
								<c:choose>
									<c:when test="${empty sbjctList }">
										<tr>
											<td class="p-2" colspan="5">조회할 수업이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${sbjctList }" var="sbjct">
											<tr style="cursor: pointer" onclick="trClick('${sbjct.sbjctCd }')">
												<td class="p-2">${sbjct.svlfNm }</td>
												<td class="p-2">${sbjct.sbjctNm }</td>
												<td class="p-2">${sbjct.sbjctBgng }</td>
												<td class="p-2">${sbjct.sbjctDdlb }</td>
												<td class="p-2">${sbjct.scduHr }</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
				<div class="row" style="text-align: right; padding-top: 10px; padding-bottom: 5px;">
					<div class="col" style="padding: 0;">
						<button type="button" class="btn btn-dark btn-sm" id="sbjctBtn" data-bs-toggle="modal" data-bs-target="#modal">수업 등록</button>
					</div>
				</div>
			</div>
		</div>


		<div class="row justify-content-around">

			<div class="card" style="width: 600px;">
				<div class="card-body" style="padding: 10px;">
					<div>
						<div class="row">
							<div class="col" style="height: 30px; background-color: lightgray; text-align: center;">
								<label style="font-weight: bold;">수업 정보</label>
							</div>
						</div>
						<div class="row">
							<div class="col" style="padding: 0;">
								<div class="input-group">
									 <label class="input-group-text" for="inputGroupSelect01">수업명</label>
									 <input id="sName" type="text" class="form-control">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-4" style="padding: 0;">
								<div class="input-group">
									 <label class="input-group-text" for="inputGroupSelect01">시작일</label>
									 <input id="sSDay" type="text" class="form-control">
								</div>
							</div>

							<div class="col-4" style="padding: 0;">
								<div class="input-group">
									 <label class="input-group-text" for="inputGroupSelect01">종료일</label>
									 <input id="sEDay" type="text" class="form-control">
								</div>
							</div>
							<div class="col-4" style="padding: 0;">
								<div class="input-group">
									 <label class="input-group-text" for="inputGroupSelect01">시간대</label>
									 <input id="sTime" type="text" class="form-control">
								</div>
							</div>
						</div>
						<div class="row">

							<div class="col-8" style="padding: 0;">
								<div class="input-group">
									 <label class="input-group-text" for="inputGroupSelect01">연수과정명</label>
									 <input id="sSvlfName" type="text" class="form-control">
								</div>
							</div>

							<div class="col-4" style="padding: 0;">
								<div class="input-group">
									 <label class="input-group-text" for="inputGroupSelect01">담당 강사</label>
									 <input id="sEMP" type="text" class="form-control">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="card" style="width: 480px;">
				<div class="card-body" style="padding: 10px;">
					<div id="seconBox">
						<table id="stuInfoTb" class="table">
							<thead class="table-secondary">
								<tr>
									<th colspan="2" class="p-2" style="text-align: center;">수강 학생 목록</th>
								</tr>
								<tr>
									<th class="p-2">학생 번호</th>
									<th class="p-2">이름</th>
								</tr>
							</thead>
							<tbody id="stuBody">
							</tbody>
						</table>
					</div>
				</div>
			</div>

		</div>

	</div>
</div>
<!-- 데이트 피커가 모달 뒤에 나옴 해결할거 -->
<div class="modal fade" id="modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">수업 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
					<div class="input-group mb-3">
						<label class="input-group-text">연수과정</label>
						<c:set value="${svlfNmList }" var="svlfNmList" />
						<select id="svlfNo" name="svlfNo" class="form-select" aria-label="Default select example">
							<option value="empty">--선택하세요--</option>
							<c:forEach items="${svlfNmList }" var="svlfNm">
								<option value="${svlfNm.svlfNo }">${svlfNm.svlfNm }</option>
							</c:forEach>
						</select>
					</div>
					<div class="input-group mb-3">
						<label class="input-group-text stModal">시간대</label>
						<select id="scduHr" name="scduHr" class="form-select" aria-label="Default select example">
							<option value="empty">--선택하세요--</option>
							<option>오전</option>
							<option>오후</option>
						</select>
					</div>

					<div id="startAndEnd">
						<div class="input-group mb-3">
							<label class="input-group-text stModal">시작일</label>
							<input type="text" id="startDatepicker" class="form-control datepicker" placeholder="날짜를 선택하세요" />
						</div>
						<div class="input-group mb-3">
							<label class="input-group-text stModal">종료일</label>
							<input type="text" id="endDatepicker" class="form-control datepicker" placeholder="날짜를 선택하세요" />
						</div>
					</div>

					<div class="input-group mb-3">
						<label class="input-group-text stModal">수업명</label>
						<input id="sbjctNm" name="sbjctNm" type="text" class="form-control" />
					</div>
					<div class="input-group mb-3" id="teachContainer">
						<c:set value="${empNmList }" var="empNmList" />
						<label class="input-group-text stModal">강사</label>
						<select id="empNo" name="empNo" class="form-select" aria-label="Default select example">
							<option value="empty">--선택하세요--</option>
							<c:forEach items="${empNmList }" var="empNm">
								<option value="${empNm.empNo }">${empNm.userNm }</option>
							</c:forEach>
						</select>
					</div>
			</div>
			<div class="modal-footer">
				<button type="button" id="addSbjctBtn" class="btn btn-secondary">수업 등록</button>
				<button type="button" id="cencleBtn" class="btn btn-primary" data-bs-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
var header = '${_csrf.headerName}';
var token =  '${_csrf.token}';

$(function(){

	datepickerSet();

	//필터의 설정을 선택했을 때
	$("#meselect").on("change", function(){
		let val = $("#meselect").val();
		let selectOption = $("input[name='option']:checked").val();

		$("#checkDiv").empty();

		if(val == "svlf"){
			callsvlflist();
		}else if(val == "hour"){
			createradioBox("am", "오전");
			createradioBox("pm", "오후");
		}else if(val != "empty"){
			createradioBox("up", "오름차순");
			createradioBox("down", "내림차순");
		}

	})

	//오름차순 내림차순을 눌렀을 때
	$("#checkDiv").on("click", "input[type='radio'][name='option']", function() {
		var selectval = $(this).val();
		var menuval = $("#meselect").val();

		resbjctlist(selectval, menuval);

	})

	$("#addSbjctBtn").on("click", function(){
		let svlfNo = $("#svlfNo").val();
		let sbjctBgng = $("#startDatepicker").val();
		let sbjctDdlb = $("#endDatepicker").val();
		let scduHr = $("#scduHr").val();
		let sbjctNm = $("#sbjctNm").val();
		let empNo = $("#empNo").val();

		if(svlfNo === "empty"){
		Swal.fire({
	    	  icon:'warning',
	    	  title:'선택해 주세요',
	    	  text:'연수과정이 선택되지 않았습니다.'
	      })
	    $("#svlfNo").focus();
		return false;

		}else if(scduHr === "empty"){
			Swal.fire({
		    	  icon:'warning',
		    	  title:'선택해 주세요',
		    	  text:'시간대가 선택되지 않았습니다.'
		      })
		    $("#scduHr").focus();
			return false;

		}else if(sbjctBgng === ""){
			Swal.fire({
		    	  icon:'warning',
		    	  title:'선택해 주세요',
		    	  text:'시작일이 선택되지 않았습니다.'
		      })
			return false;

		}else if(sbjctDdlb === ""){
			Swal.fire({
		    	  icon:'warning',
		    	  title:'선택해 주세요',
		    	  text:'종료일이 선택되지 않았습니다.'
		      })
			return false;

		}else if(sbjctNm === ""){
			Swal.fire({
		    	  icon:'warning',
		    	  title:'입력해 주세요',
		    	  text:'수업명이 입력되지 않았습니다.'
		      })
		    $("#sbjctNm").focus();
			return false;

		}else if(empNo === "empty"){
			Swal.fire({
		    	  icon:'warning',
		    	  title:'선택해 주세요',
		    	  text:'강사가 선택되지 않았습니다.'
		      })
		    $("#empNo").focus();
			return false;
		}

		data = {
			svlfNo : svlfNo,
			sbjctBgng : sbjctBgng,
			sbjctDdlb : sbjctDdlb,
			scduHr : scduHr,
			sbjctNm : sbjctNm,
			empNo : empNo
		}
		console.log(JSON.stringify(data));

 		$.ajax({
			url : "/emp/sbjct/sbjctInsert",
		    type: 'post',
	    	contentType:"application/json;charset=utf-8",
	        beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token);
	        },
			dataType: 'text',
			data:JSON.stringify(data),
			success:function(res){
				Swal.fire({
                    icon: 'success',
                    title: '등록 성공',
                    text: '수업이 정상적으로 등록되었습니다.',
                }).then((result) => {
                    if (result.isConfirmed) {
                    	location.href = "/emp/sbjct/sbjctList";
                    }
                });
			},
			error : function(xhr){
				alert("상태 : "+xhr.status);
			}
		})
	})

	var sbjctList = "${fn:length(sbjctList)}";
	if(sbjctList >= 6){
		$("#sbjctBody").find("td:last-child").css("width", "calc(100px - 18px)");
	}

	var stuList = $("#stuBody tr").length;
	if(stuList >= 6){
		$("#stuBody").find("td:last-child").css("width", "calc(200px - 25px)");
	}
})

//연수과정 선택창이 바꼈을 때
$("#svlfNo").on("change", function(){
		var svlfNo = $(this).val();
		var svlObj = {
			"svlfNo" : svlfNo
		}
		as(svlObj);
		//연수과정 선택창이 바뀌면 시간대 초기화
		$("#scduHr").val($("#scduHr option:first").val());

		//시간대가 바꼈을 때
		$("#scduHr").off("change").on("change", function(){
			//시간대 변경 시 시작일, 종료일 초기화
			$("#startDatepicker").val("");
			$("#endDatepicker").val("");

			let svlfNo = $("#svlfNo").val();
			let scduHr = $("#scduHr").val();

			var svlData = {
				"svlfNo" : svlfNo,
				"scduHr" : scduHr
			}
			sbjctTimeInfo(svlData);

			$("#startDatepicker").off("change").on("change", function(){
				$("#endDatepicker").val("");

				$("#endDatepicker").off("change").on("change", function(){
					$("#empNo").val($("#empNo option:first").val());

					let startDate = $("#startDatepicker").val();
					let endDate = $("#endDatepicker").val();

					if(startDate > endDate){
						alert("날짜를 다시 확인해주세요")
						$("#endDatepicker").val("");
						$("#endDatepicker").focus();
					}else{
						var scduData = {
							"startDate" : startDate,
							"endDate" : endDate,
							"scduHr" : scduHr
						}

						scduInfo(scduData);
					}
				})
			})
	})
})

function resbjctlist(selectval, menuval){

	$.ajax({
		url : "/emp/sbjct/resbjctlist",
		type : "get",
		data : {
			"selectval" : selectval,
			"menuval" : menuval
		},
		dataType : "json",
		success : function(res){
			var str = "";

			for(let i=0; i<res.length; i++){
				str += `
					<tr style="cursor: pointer" onclick="trClick('\${res[i].sbjctCd }')">
						<td class="p-2">\${res[i].svlfNm }</td>
						<td class="p-2">\${res[i].sbjctNm }</td>
						<td class="p-2">\${res[i].sbjctBgng }</td>
						<td class="p-2">\${res[i].sbjctDdlb }</td>
						<td class="p-2">\${res[i].scduHr }</td>
					</tr>`

			}


			$("#sbjctBody").html(str);

			var resetsbjctList = $("#sbjctBody tr").length;
			if(resetsbjctList >= 6){
				$("#sbjctBody").find("td:last-child").css("width", "calc(100px - 18px)");
			}
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

//과목이 존재하는 연수과정이름 가져오기
function callsvlflist(){

	$.ajax({
		url : "/emp/sbjct/svlfList",
		type : "get",
		dataType : "json",
		success : function(res){
			var str = "";

			str += `
				<select class="form-select" id="svlfList" style="width: 230px; text-align: center;ma">
				<option value="empty">--연수과정 선택--</option>
			`

			for(let i=0; i<res.length; i++){
				str += `
					<option value="\${res[i].svlfNo}">\${res[i].svlfNm}</option>
				`
			}

			str +=`</select>`

			$("#checkDiv").html(str);

			$("#svlfList").on("change", function(){
				var choiceVal = $(this).val();
				var menuval = $("#meselect").val();

				resbjctlist(choiceVal, menuval);
			})
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

//필터 메뉴를 선택했을 때 라디오, 셀렉트 만들어주기
function createradioBox(id, label){

	var radio = $("<input>").attr({
		type : "radio",
		id : id,
		name : "option",
		value : id
	});

	radio.addClass('form-check-input');

	$("#checkDiv").append(radio);
	$("#checkDiv").append("<label class='form-check-label' for='"+id+"'>"+label+"</label>")
}

////목록 tr을 누르면 해당 목록 상세보기 페이지로 이동
function trClick(sbjCd){

	sbjctInfo(sbjCd);
	sbjctStuList(sbjCd);
}

function sbjctInfo(sbjCd){
	$.ajax({
		url : "/emp/sbjct/sbjctInfo",
		type : "get",
		data : {"sbjctCd" : sbjCd},
		dataType : "json",
		success : function(res){
			$("#sName").val(res.sbjctNm);
			$("#sSDay").val(res.sbjctBgng);
			$("#sEDay").val(res.sbjctDdlb);
			$("#sTime").val(res.scduHr);
			$("#sSvlfName").val(res.svlfNm);
			$("#sEMP").val(res.userNm);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function sbjctStuList(sbjCd){
	$.ajax({
		url : "/emp/sbjct/sbjctStuList",
		type : "get",
		data : {"sbjctCd" : sbjCd},
		dataType : "json",
		success : function(res){
			var str = "";

			if(res.length == 0){
				str += `
					<tr>
						<td colspan="2" class="p-2">조회할 수 있는 학생이 없습니다.</td>
					</tr>`
			}else{
				for(let i=0; i<res.length; i++){
					str += `
						<tr>
							<td class="p-2">\${res[i].stuNo}</td>
							<td class="p-2">\${res[i].userNm}</td>
						</tr>`
				}
			}

			$("#stuBody").html(str);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function as(obj){
	$.ajax({
		url :"/emp/sbjct/svlfTime",
		type:"get",
		data: obj,
		dataType:"json",
		success:function(res){

			var str= `
	        	<div class="input-group mb-3">
		    		<label class="input-group-text stModal">시작일</label>
		    		<input type="text" name="sbjctBgng" id="startDatepicker" class="form-control datepicker" placeholder="날짜를 선택하세요"/>
		    	</div>
		    	<div class="input-group mb-3">
		    		<label class="input-group-text stModal">종료일</label>
		    		<input type="text" name="sbjctDdlb" id="endDatepicker" class="form-control datepicker" placeholder="날짜를 선택하세요"/>
		    	</div>`;

			$("#startAndEnd").html(str);

			datepickerSet();

			var startDate = new Date(res.svlfBgngDt);
			var ebdDate = new Date(res.svlfDdlbDt);

			var sDate = formatDate(startDate);
			var eDate = formatDate(ebdDate);

			$("#startDatepicker").datepicker("option",{
				minDate : sDate,
				maxDate : eDate,
				beforeShowDay: function(date){
					var day = date.getDay();
					return [(day != 0 && day != 6)];
				}
			});

			$("#endDatepicker").datepicker("option",{
				minDate : sDate,
				maxDate : eDate,
				beforeShowDay: function(date){
					var day = date.getDay();
					return [(day != 0 && day != 6)];
				}
			});
		}
	})
}

function formatDate(date) {
	  var year = date.getFullYear();
	  var month = String(date.getMonth() + 1).padStart(2, '0');
	  var day = String(date.getDate()).padStart(2, '0');
	  return `\${year}-\${month}-\${day}`;
}

function datepickerSet(){
	$(".datepicker").datepicker({
		dateFormat : "yy-mm-dd",
		showMonthAfterYear:true,
		yearSuffix: "년",
		dayNames : ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
		dayNamesMin : ['일','월','화','수','목','금','토'],
		monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12'],
		monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		beforeShowDay: function(date){

			var day = date.getDay();
			return [(day != 0 && day != 6)];
		}
	});
}

function sbjctTimeInfo(svlData){
	console.log(svlData);

	$.ajax({
		url:"/emp/sbjct/sbjcttimeinfo",
		type:"get",
		data:svlData,
		dataType:"json",
		success:function(res){
			if(res != null && res !=""){
				$("#startDatepicker").datepicker("option", {
					beforeShowDay : function(date){
						var day = date.getDay();
						for(var i=0; i<res.length; i++){
							var disabledStartDate = new Date(res[i].sbjctBgng)
							var disabledEndtDate = new Date(res[i].sbjctDdlb)
							disabledStartDate.setDate(disabledStartDate.getDate() - 1);

							if((date >= disabledStartDate && date <= disabledEndtDate) || day === 6 || day === 0){
								return [false];
							}
						}
						return [true];
					}
				})

				$("#endDatepicker").datepicker("option", {
					beforeShowDay : function(date){
						var day = date.getDay();
						for(var i=0; i<res.length; i++){
							var disabledStartDate = new Date(res[i].sbjctBgng)
							var disabledEndtDate = new Date(res[i].sbjctDdlb)
							disabledStartDate.setDate(disabledStartDate.getDate() - 1);

							if((date >= disabledStartDate && date <= disabledEndtDate) || day === 6 || day === 0){
								return [false];
							}
						}
						return [true];
					}
				})
			}else{
				$("#startDatepicker").datepicker("option",{
					beforeShowDay: function(date){
						var day = date.getDay();
						return [(day != 0 && day != 6)];
					}
				});

				$("#endDatepicker").datepicker("option",{
					beforeShowDay: function(date){
						var day = date.getDay();
						return [(day != 0 && day != 6)];
					}
				});
			}
		}
	})
}

function scduInfo(scduData){
	console.log(scduData);

	$.ajax({
		url:"/emp/sbjct/scduinfo",
		type:"get",
		data:scduData,
		dataType:"json",
		success:function(res){
			console.log("res", res);

			var str = `
					<label class="input-group-text stModal">강사</label>
					<select id="empNo" name="empNo" class="form-select" aria-label="Default select example">
					<option value="empty">--선택하세요--</option>
					`

					for(var i=0; i<res.length; i++){
						str += `<option value=\${res[i].empNo}>\${res[i].userNm}</option>`
					}
			str += `</select>`;

				$("#teachContainer").html(str);
		}
	})
}
</script>