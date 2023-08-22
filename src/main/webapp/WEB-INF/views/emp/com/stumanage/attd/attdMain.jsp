<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
#topDiv{
	width: 100%;
	height: 285px;
	margin: 0;
}

#middleBox, #footBox, #box3, #box4{
	height: 280px;
}

#box1{
	height: 285px;
	padding-left: 0;
}

#box2{
	height: 285px;
}

#attdStuTable{
	display:block;
}

#attdStuTable tbody{
	display: block;
	max-height: 200px;
	overflow: auto;
}

#attdStuTable th:nth-of-type(1), #attdStuTable td:nth-of-type(1) {width: 125px;}
#attdStuTable th:nth-of-type(2), #attdStuTable td:nth-of-type(2) {width: 155px;}
#attdStuTable th:nth-of-type(3), #attdStuTable td:nth-of-type(3) {width: 155px;}

#attdStuTable th:last-child{
	width: 125px;
	text-align: center
}

#attdStuTable td:last-child{
	width: 125px;
	text-align: center;
}

#mBoxBody tr{
	cursor: pointer;
}

#mBoxBody tr:hover{
	background-color: lightgray;
}

.ui-datepicker-inline{
	width: auto;
	height: auto;
}
.table{
	color: black;
}

.table th {
  padding: 0px;
}

.attdCheck{
	cursor: pointer;
}

.attdCheck:hover {
	background-color: lightgray;
}

.card{
	margin-bottom: 10px;
}

.card-body{
	padding: 10px;
}

</style>

<div class="card">
	<div class="card-body">
		<div id="topDiv" class="row">
			<div id="box1" class="col-6">
				<div id="datepicker">
				</div>
			</div>

			<div id="box2" class="col-6">
				<input type="hidden" id="attdDt" name="attdDt" value="날짜" class="form-control" style="text-align: center; font-weight: bolder;" readonly/>
				<div id="boxtoBox">
					<table id="attdStuTable" class="table">
						<thead class="table-light">
							<tr>
								<th style="text-align: center;" colspan="4">연수과정
									<select id="svlfNo" name="svlfNo" class="form-select" style="display: inline; width:250px;border: none;">
									<option value = "empty">-- 선택하세요 --</option>
									</select>
								</th>
							</tr>
							<tr style="text-align: center;">
								<th>이름</th>
								<th>입실</th>
								<th>퇴실</th>
								<th>출결상태</th>
							</tr>
						</thead>
						<tbody id="taBody">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="card">
	<div class="card-body">
		<div id="middleBox" class="row">
			<div class="col-6 aalign-self-end" style="height: 30px;">
				<h3>조퇴/외출 신청</h3>
			</div>
			<div class="col-6 align-self-end" style="text-align: right;height: 30px;">
				<a href="/emp/stuman/allList">+더보기</a>
			</div>
			<div class="col-12" style="height: 250px;">
				<table class="table mTb">
					<thead class="table-secondary">
						<tr>
							<th style="text-align: center;" colspan="4" class="p-2">조퇴/외출 전체 목록</th>
						</tr>
						<tr>
							<th class="p-2">분류</th>
							<th class="p-2">작성일</th>
							<th class="p-2">신청일</th>
							<th class="p-2">신청자</th>
						</tr>
					</thead>
					<tbody class="table" id="mBoxBody">
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<div class="card">
	<div class="card-body">
		<div id="footBox" class="row">
			<div id="box3" class="col-6 parent-div">
				<div class="row align-items-end">
					<div class="col-9">
						<h3>조퇴/외출 허가</h3>
					</div>
					<div class="col-3" style="text-align: right;">
						<a href="/emp/stuman/approvalList">+더보기</a>
					</div>
				</div>
				<table class="table mTb">
					<thead class="table-secondary">
						<tr>
							<th style="text-align: center;" colspan="3" class="p-2">조퇴/외출 허가 목록</th>
						</tr>
						<tr>
							<th class="p-2">분류</th>
							<th class="p-2">신청일</th>
							<th class="p-2">신청자</th>
						</tr>
					</thead>
					<tbody class="table" id="box3Body">
					</tbody>
				</table>
			</div>

			<div id="box4" class="col-6">
				<div class="row align-items-end">
					<div class="col-9">
						<h3>조퇴/외출 미허가</h3>
					</div>
					<div class="col-3" style="text-align: right;">
						<a href="/emp/stuman/unapprovedList">+더보기</a>
					</div>
				</div>
				<table class="table mTb">
					<thead class="table-secondary">
						<tr>
							<th style="text-align: center;" colspan="3" class="p-2">조퇴/외출 미허가 목록</th>
						</tr>
						<tr>
							<th class="p-2">분류</th>
							<th class="p-2">신청일</th>
							<th class="p-2">신청자</th>
						</tr>
					</thead>
					<tbody class="table" id="box4Body">
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>


<!-- 학생들의 출결 변경 모달 -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="staticBackdropLabel">출결상태 수정</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div id="mBody" class="modal-body" style="text-align: center;">
				<button type="button" value="출석" class="btn btn-success">출석</button>
				<button type="button" value="지각" class="btn btn-warning">지각</button>
				<button type="button" value="결석" class="btn btn-danger">결석</button>
				<button type="button" value="외출" class="btn btn-primary">외출</button>
				<button type="button" value="조퇴" class="btn btn-secondary">조퇴</button>
			</div>
			<!-- <div class="modal-footer">
				<button type="button" class="btn btn-primary">수정</button>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			</div> -->
		</div>
	</div>
</div>

<!-- 조퇴/외출 승인 및 반려 모달 -->
<div class="modal fade" id="attdanModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="staticBackdropLabel">조퇴/외출 승인</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div id="mBody" class="modal-body">
				<div class="input-group mb-3">
					<input type="hidden" id="attNo" value="" />
					<span class="input-group-text" style="width: 90px;">원생 이름</span>
					<input type="text" class="form-control" value="" readonly/>
				</div>
				<div class="input-group mb-3">
					<span class="input-group-text" style="width: 90px;">신청 구분</span>
					<input type="text" id="cdName" class="form-control" value="" readonly/>
				</div>
				<div class="input-group mb-3">
					<span class="input-group-text" style="width: 90px;">신청일</span>
					<input type="text" id="nDay" class="form-control" value="" readonly/>
				</div>

				<div class="input-group mb-3" id="attdTDiv">
					<span class="input-group-text" style="width: 90px;">외출 시간</span>
					<input type="text" id="attdT" class="form-control" value="" readonly/>
				</div>

				<div class="mb-3">
					<span class="input-group-text">사유</span>
					<textarea class="form-control" rows="3" readonly></textarea>
				</div>

				<div style="text-align: center;">
					<button type="button" id="approval" value="승인" class="btn btn-primary">승인</button>
					<button type="button" id="unapproved" value="거부" class="btn btn-danger">거부</button>
				</div>
				<input type="hidden" id="sNo" value=""/>
			</div>
			<!-- <div class="modal-footer">
				<button type="button" class="btn btn-primary">수정</button>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			</div> -->
		</div>
	</div>
</div>

<script>
var header = '${_csrf.headerName}';
var token =  '${_csrf.token}';
$(function(){
	datepickerSet();
	attdanAllList();
	attdanapproval();
	attdanunapproved();

	$("#svlfNo").on("change", function(){
		var optionValue = this.value;
		var dateValue = $("#attdDt").val()

		if(optionValue != "empty"){
			var data = {
				"svlfNo" : optionValue,
				"attdDt" : dateValue
			}

			stuList(data)
		}else{
			alert("연수과정을 선택해주세요");
		}
	})

	$("#mBoxBody").on("click", "tr", function(){
		let cdNm = $(this).find("td:eq(0)").text();
		let outDay = $(this).find("td:eq(1)").text();
		let name = $(this).find("td:eq(3)").text();
		let cn = $(this).find("#attdanCn").val();
		let num = $(this).find("#attdanNo").val();
		let no = $(this).find("#studentNo").val();

		$("#attdanModal").find(".modal-body input:eq(1)").val(name);
		$("#attdanModal").find(".modal-body input:eq(2)").val(cdNm);
		$("#attdanModal").find(".modal-body input:eq(3)").val(outDay);
		$("#attdanModal").find(".modal-body textarea").text(cn);
		$("#attdanModal").find("#attNo").val(num);
		$("#attdanModal").find("#sNo").val(no);

		if(cdNm === "외출"){
			let startT = $(this).find("#attdanBgng").val();
			let endT = $(this).find("#attdanDdlb").val();

			let fullT = startT + " ~ " + endT;

			$("#attdanModal").find("#attdT").val(fullT);
			$("#attdTDiv").show();
		}else{
			$("#attdTDiv").hide();
		}

		$("#attdanModal").modal("show");
	})

	$("#approval").on("click",function(){
		let no = $("#attNo").val();
		let check = $("#cdName").val();
		let stuno = $("#sNo").val();
		let noDay = $("#nDay").val();

		data = {
			"attdanNo" : no,
			"attdanApproval" : 'Y'
		}
		approvalUpdate(data);

		if(check == "외출"){
			data = {
				"attdDt" : noDay,
				"stuNo" : stuno
			}
			//실행이 안됨
			outAttd(data);
		}else if(check == "조퇴"){
			data = {
				"attdDt" : noDay,
				"stuNo" : stuno
			}
			//실행이 안됨
			checkAttd(data);
		}

	})

	$("#unapproved").on("click",function(){
		let no = $("#attNo").val();
		console.log(no);
		data = {
			"attdanNo" : no,
			"attdanApproval" : 'N'
		}
		approvalUpdate(data);
	})

	var sList = $("#taBody tr").length;
	if(sList >=5){
		$("#taBody").find("td:last-child").css("width", "calc(125px - 19px");
	}

})

//------------------------------------------------------------------------------------------------------------------------

function startAttdTable(dateInfo){

	$.ajax({
		url : "/emp/stuman/startAttdTable",
		type : "get",
		data : dateInfo,
		dataType : "json",
		success : function(res){

			var str = `<option value = "empty">-- 선택하세요 --</option>`;

			for(let i=0; i<res.length; i++){
				str += `
					<option value="\${res[i].svlfNo}">\${res[i].svlfNm}</option>`
			}

			$("#svlfNo").html(str);

		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function stuList(data){

	$.ajax({
		url : "/emp/stuman/stuList",
		type : "get",
		data : data,
		dataType : "json",
		success : function(res){

			str = "";

			if(res.length == 0){
				str += `
				<tr>
					<td colspan="4" class="p-2">조회할 정보가 없습니다.</td>
				</tr>`
			}else{
				for(let i=0; i<res.length; i++){
					str += `
					<tr class="bTr" style="text-align: center;">
					<input type="hidden" class="stuNo" value="\${res[i].stuNo}" />
						<td class="stuName p-2">\${res[i].userNm}</td>
						<td class="p-2">`

						if(res[i].attdAbmiYmd == null){
							str += `--`
						}else{
							str += `\${res[i].attdAbmiYmd}`
						}

				str +=	`</td>
						<td class="p-2">`

						if(res[i].attdLeaveYmd == null){
							str += `--`
						}else{
							str += `\${res[i].attdLeaveYmd}`
						}

				str +=	`</td>
						<td class="attdCheck p-2">`

						if(res[i].cdNm == null){
							str += `--`
						}else{
							str += `\${res[i].cdNm}`
						}

				str +=	`</tr>`
				}
			}

			$("#taBody").html(str);

			//출결상태를 눌렀을 때
			$(".attdCheck").on("click", function(){
				var dateInfo = $("#attdDt").val();

				var clickTd = $(this);
				var upTr = clickTd.closest("tr");
				var stuNo = upTr.find(".stuNo").val();

				$("#staticBackdrop").modal("show");

				$("#mBody").off("click").on("click", "button", function(){
					var status = $(this).val();

					var code = "";

					if(status === "출석"){
						code = "S001-3";
					}else if(status === "지각"){
						code = "S001-5";
					}else if(status === "결석"){
						code = "S001-4";
					}else if(status === "외출"){
						code = "S001-1";
					}else if(status === "조퇴"){
						code = "S001-2";
					}

					var info = {
						"attdDt" : dateInfo,
						"stuNo" : stuNo,
						"attdCd" : code
					}

					attdStatus(info);
				})
			})

		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function attdStatus(info){

	$.ajax({
		url : "/emp/stuman/attdStatus",
		type : "post",
		contentType : "application/json;charset=utf-8",
		beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
		},
		data : JSON.stringify(info),
		dataType : "text",
		success : function(res){
			if(res == "성공"){
				$("#staticBackdrop").modal("hide");

				var optionVal = $("#svlfNo").val();
				var attdDate = $("#attdDt").val();

				var data = {
					"svlfNo" : optionVal,
					"attdDt" : attdDate
				}

				Swal.fire({
                    icon: 'success',
                    title: '수정 성공',
                    text: '출결이 정상적으로 수정되었습니다.',
                }).then((result) => {
                    if (result.isConfirmed) {
        				stuList(data);
                    }
                });

			}else if(res == "실패"){
				alert("수정 실패");
			}
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function datepickerSet(){
	$("#datepicker").datepicker({
		dateFormat : "yy-mm-dd",
		showMonthAfterYear:true,
		yearSuffix: "년",
		dayNames : ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
		dayNamesMin : ['일','월','화','수','목','금','토'],
		monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12'],
		monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		maxDate: 0,
		onSelect: function(dateText, datePicker) {

	    	var mm = (datePicker.selectedMonth + 1);
			var dd = datePicker.selectedDay;

			if(mm < 10){mm =  "0"+mm;}
			if(dd < 10){dd = "0"+dd;}

			$("#attdDt").val(datePicker.selectedYear + "-" + mm + "-" + dd);

	    	var dateInfo = {
	    		"dateInfo" : dateText
	    	}
	    	startAttdTable(dateInfo)
	    }
	});
}

function attdanAllList(){

	$.ajax({
		url : "/emp/stuman/attdanAllList",
		type : "get",
		dataType : "json",
		success : function(res){

			str = "";

			if(res.length == 0){
				str += `
				<tr>
					<td colspan="4" class="p-2" style="text-align: center;">조회할 정보가 없습니다.</td>
				</tr>
				`
			}else{
				if(res.length < 4){
					for(let i=0; i<res.length; i++){

						str += `
						<tr>
						/* 번호로 받아서 업데이트 */
							<input type="hidden" id="attdanCn" value="\${res[i].attdanCn}"/>
							<input type="hidden" id="attdanNo" value="\${res[i].attdanNo}"/>
							<input type="hidden" id="attdanBgng" value="\${res[i].attdanBgng}"/>
							<input type="hidden" id="attdanDdlb" value="\${res[i].attdanDdlb}"/>
							<input type="hidden" id="studentNo" value="\${res[i].stuNo}"/>
							<td class="p-2">\${res[i].cdNm}</td>
							<td class="p-2">\${res[i].attdanWriteDt.substring(0, 10)}</td>
							<td class="p-2">\${res[i].attdanDt}</td>
							<td class="p-2">\${res[i].userNm}</td>
						</tr>
						`
					}
				}else{
					for(let i=0; i<4; i++){

						str += `
						<tr>
							/* 번호로 받아서 업데이트 */
							<input type="hidden" id="attdanCn" value="\${res[i].attdanCn}"/>
							<input type="hidden" id="attdanNo" value="\${res[i].attdanNo}"/>
							<input type="hidden" id="attdanBgng" value="\${res[i].attdanBgng}"/>
							<input type="hidden" id="attdanDdlb" value="\${res[i].attdanDdlb}"/>
							<input type="hidden" id="studentNo" value="\${res[i].stuNo}"/>
							<td class="p-2">\${res[i].cdNm}</td>
							<td class="p-2">\${res[i].attdanWriteDt.substring(0, 10)}</td>
							<td class="p-2">\${res[i].attdanDt}</td>
							<td class="p-2">\${res[i].userNm}</td>
						</tr>
						`
					}
				}
			}

			$("#mBoxBody").html(str);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function attdanapproval(){
	$.ajax({
		url : "/emp/stuman/attdanapproval",
		type : "get",
		dataType : "json",
		success : function(res){
			str = "";

			if(res.length == 0){
				str += `
				<tr>
					<td colspan="3" class="p-2" style="text-align: center;">조회할 정보가 없습니다.</td>
				</tr>
				`
			}else{
				if(res.length < 4){
					for(let i=0; i<res.length; i++){

						str += `
						<tr>
							<td class="p-2">\${res[i].cdNm}</td>
							<td class="p-2">\${res[i].attdanWriteDt.substring(0, 10)}</td>
							<td class="p-2">\${res[i].userNm}</td>
						</tr>
						`
					}
				}else{
					for(let i=0; i<4; i++){

						str += `
						<tr>
							<td class="p-2">\${res[i].cdNm}</td>
							<td class="p-2">\${res[i].attdanWriteDt.substring(0, 10)}</td>
							<td class="p-2">\${res[i].userNm}</td>
						</tr>
						`
					}
				}
			}

			$("#box3Body").html(str);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function attdanunapproved(){
	$.ajax({
		url : "/emp/stuman/attdanunapproved",
		type : "get",
		dataType : "json",
		success : function(res){
			str = "";

			if(res.length == 0){
				str += `
				<tr>
					<td colspan="3" class="p-2" style="text-align: center;">조회할 정보가 없습니다.</td>
				</tr>
				`
			}else{
				if(res.length < 4){
					for(let i=0; i<res.length; i++){

						str += `
						<tr>
							<td class="p-2">\${res[i].cdNm}</td>
							<td class="p-2">\${res[i].attdanWriteDt.substring(0, 10)}</td>
							<td class="p-2">\${res[i].userNm}</td>
						</tr>
						`
					}
				}else{
					for(let i=0; i<4; i++){

						str += `
						<tr>
							<td class="p-2">\${res[i].cdNm}</td>
							<td class="p-2">\${res[i].attdanWriteDt.substring(0, 10)}</td>
							<td class="p-2">\${res[i].userNm}</td>
						</tr>
						`
					}
				}
			}

			$("#box4Body").html(str);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function approvalUpdate(data){
	$.ajax({
		url : "/emp/stuman/approvalUpdate",
		type : "post",
		contentType : "application/json;charset=utf-8",
		beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
		},
		dataType : 'text',
		data : JSON.stringify(data),
		success : function(res){
			if(res === "성공"){
				$("#attdanModal").modal("hide")

				setTimeout(() => {
					attdanAllList();
					attdanapproval();
					attdanunapproved();
				}, 200);
			}else{
				alert("업데이트 실패했습니다.")
			}
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function checkAttd(data){
	$.ajax({
		url : "/emp/stuman/checkAttd",
		type : "post",
		contentType : "application/json;charset=utf-8",
		beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
		},
		dataType : 'text',
		data : JSON.stringify(data),
		success : function(res){
			if(res == "성공"){
				console.log("조퇴성공");
			}
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function outAttd(data){
	$.ajax({
		url : "/emp/stuman/outAttd",
		type : "post",
		contentType : "application/json;charset=utf-8",
		beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
		},
		dataType : 'text',
		data : JSON.stringify(data),
		success : function(res){
			if(res == "성공"){
				console.log("외출성공");
			}
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}
</script>