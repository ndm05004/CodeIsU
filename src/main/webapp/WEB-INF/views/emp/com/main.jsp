<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib  uri="http://www.springframework.org/security/tags" prefix="sec"%>
<style>
.img{
	height: 80px;
	width: 80px;
}

table tbody tr{
	cursor: pointer;
}

.btnGroup{
	background: none;
    border: none;
    padding: 0;
    cursor: pointer;
}

.inLabel{
	font-weight: bold;
	color: black;
}

thead{
	text-align: center;
}

th{
	color: black;
	font-weight: bold;
}

.table tbody{
	text-align: center;
	color: black;
}

.table-bordered td:first-child,
.table-bordered th:first-child{
	border-left: none;
}

.table-bordered td:last-child,
.table-bordered th:last-child {
    border-right: none;
}

.table thead th,
.table tbody td{
    border-bottom: 1.5px solid black;
}

.fon, .table thead th{
	font-weight: bold;
	color: black;
}
</style>

<div class="row justify-content-evenly">
	<div class="row" style="width: 555px;">
		<div class="card" style="margin-bottom: 10px;background-color: black;color: white;text-align: center;">
			<div class="card-body" style="padding: 0;">
				<h1 id="currentDate" style="font-weight: bold;"></h1>
				<h1 id="clock" style="font-weight: bold;"></h1>
			</div>
		</div>

		<div class="card" style="margin-bottom: 10px;">
			<div class="card-body" style="padding: 0;">
				<div class="col" style="height: 50px;">
					<h2 style="font-weight: bold;color: black;">상담</h2>
				</div>
				<div class="row" style="padding-top: 20px;">
					<div class="col-4" style="height: 100px;text-align: center;">
						<h4 class="fon">미승인 상담</h4>
						<h2 class="fon" id="dscsn1">-건</h2>
					</div>

					<div class="col-4" style="height: 100px;text-align: center;">
						<h4 class="fon">오늘 상담</h4>
						<h2 class="fon" id="dscsn2">-건</h2>
					</div>

					<div class="col-4" style="height: 100px;text-align: center;">
						<h4 class="fon">내일 상담</h4>
						<h2 class="fon" id="dscsn3">-건</h2>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="card" style="height: 300px; width: 570px; margin-bottom: 10px;">
		<div class="card-body" style="padding: 0;">
			<div class="row">
				<div class="col-12" style="height: 30px;">
					<p style="font-weight: bold;">바로가기</p>
				</div>
			</div>
		<div class="row align-items-center" style="height: 135px;">
			<div class="col-3 text-center">
			<!-- 공지사항 -->
			<button class="btnGroup" id="hntcBtn"><img src="${pageContext.request.contextPath}/resources/img/emp/free-icon-noticeboard-10001797.png" class="img"/></button>
               <br><label class="inLabel">공지사항</label>
            </div>
            <div class="col-3 text-center">
               <!-- 상담 -->
               <button class="btnGroup" id="dscsnBtn"><img src="${pageContext.request.contextPath}/resources/img/emp/free-icon-discussion-4596176.png" class="img"/></button>
               <br><label class="inLabel">상담</label>
            </div>
            <div class="col-3 text-center">
               <!-- 연수과정 -->
               <button class="btnGroup" id="svlfBtn"><img src="${pageContext.request.contextPath}/resources/img/emp/free-icon-design-process-10150306.png" class="img"/></button>
               <br><label class="inLabel">연수과정</label>
            </div>
            <div class="col-3 text-center">
               <!-- 수업목록 -->
               <button class="btnGroup" id="sbjctBtn"><img src="${pageContext.request.contextPath}/resources/img/emp/free-icon-open-book-2702172.png" class="img"/></button>
               <br><label class="inLabel">수업목록</label>
            </div>
         </div>

         <div class="row align-items-center" style="height: 135px;">
            <div class="col-3 text-center">
               <!-- 공통코드 -->
               <button class="btnGroup" id="cmCodeBtn"><img src="${pageContext.request.contextPath}/resources/img/emp/free-icon-browser-1137216.png" class="img"/></button>
               <br><label class="inLabel">공통코드</label>
            </div>
            <div class="col-3 text-center">
               <!-- 시간표 -->
               <button class="btnGroup" id="scheduleBtn"><img src="${pageContext.request.contextPath}/resources/img/emp/free-icon-schedule-2655034.png" class="img"/></button>
               <br><label class="inLabel">시간표</label>
            </div>
            <div class="col-3 text-center">
               <!-- 학생출결 -->
               <button class="btnGroup" id="attdBtn"><img src="${pageContext.request.contextPath}/resources/img/emp/free-icon-attendance-3448601.png" class="img"/></button>
               <br><label class="inLabel">학생출결</label>
            </div>
            <div class="col-3 text-center">
               <!-- 조퇴/외출 -->
               <button class="btnGroup" id="kalleaveBtn"><img src="${pageContext.request.contextPath}/resources/img/emp/free-icon-absent-4753119.png" class="img"/></button>
               <br><label class="inLabel">조퇴/외출</label>
				</div>
			</div>
		</div>
	</div>
</div>



<div class="card" style="height: 410px; margin-bottom: 10px;">
	<div class="card-body" style="padding: 0;">
		<div class="row" style="padding-left: 15px;padding-right: 15px;">
			<div class="col-6 px-3" style="padding: 0;">
				<table class="table table-hover">
					<thead class="table" style="font-weight: bold;">
						<tr>
							<th colspan="3" class="p-2" style="text-align: center;">조퇴/외출 신청 목록</th>
						</tr>
						<tr>
							<th class="p-2" style="text-align: center;">분류</th>
							<th class="p-2" style="text-align: center;">신청일</th>
							<th class="p-2" style="text-align: center;">신청자</th>
						</tr>
					</thead>
					<tbody id="attdanBody">
					</tbody>
				</table>
			</div>

			<div class="col-6 px-3" style="padding: 0;">
				<table class="table table-bordered border-dark table-hover">
					<thead class="table" style="font-weight: bold;">
						<tr>
							<th class="p-2" style="text-align: center;">공지사항</th>
						</tr>
					</thead>
					<tbody id="hntcBody">
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<script>
feather.replace();
var userNo = '<sec:authentication property="principal.member.userNo"/>'

$(function(){

	$("#attdanBody").on("click", "tr", function(){
		location.href = "/emp/stuman/attend";
	})

	$("#hntcBody").on("click", "tr", function(){
		let no = $(this).find("#hNo").text();

		console.log(no)

		location.href = "/emp/hntc/mainHntcDetail?bono="+no;
	})

	function updateDate() {
		const now = new Date();
		const year = now.getFullYear();
		const month = (now.getMonth() + 1).toString().padStart(2, '0');
		const day = now.getDate().toString().padStart(2, '0');

		// 날짜를 표시하는 div 요소에 현재 날짜를 설정
		$("#currentDate").text(year + "년" + month + "월" + day + "일");
	}
	setInterval(updateDate, 1000);
	updateDate();

	noapprovdscsn(userNo);
	todaydscsn(userNo);
	tomorrowdscsn(userNo);

	startTime();
	mainhntc();
	mainattdan();

	var hntcBtn = $("#hntcBtn");
	var dscsnBtn = $("#dscsnBtn");
	var svlfBtn = $("#svlfBtn");
	var sbjctBtn = $("#sbjctBtn");
	var cmCodeBtn = $("#cmCodeBtn");
	var scheduleBtn = $("#scheduleBtn");
	var attdBtn = $("#attdBtn");
	var kalleaveBtn = $("#kalleaveBtn");

	hntcBtn.on("click", function(){
		location.href = "/emp/hntc/hntcBoard"
	})

	dscsnBtn.on("click", function(){
		location.href = "/emp/dscsn/dscsnBoard"
	})

	svlfBtn.on("click", function(){
		location.href = "/emp/svlf/svlfList"
	})

	sbjctBtn.on("click", function(){
		location.href = "/emp/sbjct/sbjctList"
	})

	cmCodeBtn.on("click", function(){
		location.href = "/emp/cmcode"
	})

	scheduleBtn.on("click", function(){
		location.href = "/emp/class/schedule"
	})

	attdBtn.on("click", function(){
		location.href = "/emp/stuman/attend"
	})

	kalleaveBtn.on("click", function(){
		location.href = "/emp/stuman/kalleave"
	})
})

function startTime() {
    var today = new Date();
    var h = today.getHours();
    var m = today.getMinutes();
    var s = today.getSeconds();
    h = checkTime(h);
    m = checkTime(m);
    s = checkTime(s);
    document.getElementById('clock').innerHTML = h + ":" + m + ":" + s;
    var t = setTimeout(startTime, 500);
}
function checkTime(i) {
    if (i < 10) {i = "0" + i}; // 숫자가 10보다 작을 경우 앞에 0을 붙여줌
    return i;
}

function noapprovdscsn(userNo){
	$.ajax({
		url : "/emp/dscsn/noapprovdscsn",
		type : "get",
		data : {"userNo":userNo},
		dataType : "text",
		success : function(res){
			$("#dscsn1").text(res+"건");
		},
		error : function(xhr){
			console.log("1"+res);
			alert("상태 : " + xhr.status);
		}
	})
}

function todaydscsn(userNo){
	$.ajax({
		url : "/emp/dscsn/todaydscsn",
		type : "get",
		data : {"userNo":userNo},
		dataType : "text",
		success : function(res){
			$("#dscsn2").text(res+"건");
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function tomorrowdscsn(userNo){
	$.ajax({
		url : "/emp/dscsn/tomorrowdscsn",
		type : "get",
		data : {"userNo":userNo},
		dataType : "text",
		success : function(res){
			$("#dscsn3").text(res+"건");
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function mainhntc(){
	$.ajax({
		url : "/emp/hntc/hntcList",
		type : "get",
		dataType : "json",
		success : function(res){
			var str = "";

			if(res.length == 0){
				str += `
				<tr>
					<td class="p-1">조회할 공지사항이 없습니다.</td>
				</tr>`
			}else{
				if(res.length > 5){
					for(let i=0; i<5; i++){
						str += `
							<tr>
								<td style="padding: 0;">
									<div class="row align-items-center" style="height: 70px;padding-top: 0;padding-bottom: 0;">
										<div class="col-1">`
						str +=				`<img src="${pageContext.request.contextPath}/resources/img/emp/free-icon-annoucement-10798011.png">`
						str +=			`</div>
										<div class="col-9 text-center">
											<label style="font-weight: bold;font-size: 20px;text-align: left;">\${res[i].hntcNm}</label><br>
											<div class="row align-items-center">
												<div class="col-6 text-center">
													<label>번호 : </label><label id="hNo">\${res[i].hntcNo}</label>
												</div>
												<div class="col-6 text-center">
													<label>작성일 : \${res[i].hntcDt}</label>
												</div>
											</div>
										</div>
									</div>
								</td>
							</tr>`
						}
				}else{
					for(let i=0; i<res.length; i++){
						str += `
						<tr>
							<td style="padding: 0;">
								<div class="row align-items-center" style="height: 70px;padding-top: 0;padding-bottom: 0;">
									<div class="col-2">`
						str +=				`<img src="${pageContext.request.contextPath}/resources/img/emp/free-icon-annoucement-10798011.png">`
						str +=			`</div>
									<div class="col-6">
										<div style="font-weight: bold;font-size: 20px;text-align: left;">\${res[i].hntcNm}</div>
									</div>
									<div class="col-4 text-end text-muted">
										<label style="padding-right:10px;">작성일 : \${res[i].hntcDt}</label>
									</div>
								</div>
							</td>
						</tr>`
						}
				}
			}

			console.log(str);
			$("#hntcBody").html(str);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function mainattdan(){
	$.ajax({
		url : "/emp/stuman/attdanAllList",
		type : "get",
		dataType : "json",
		success : function(res){
			var str = "";

			if(res.length == 0){
				str += `
				<tr>
					<td class="p-1" colspan="3">조퇴/외출을 신청한 글이 없습니다.</td>
				</tr>`
			}else{
				if(res.length > 8){
					for(let i=0; i<8; i++){
						str += `
							<tr class="p-2">
								<td class="p-2">\${res[i].cdNm}</td>
								<td class="p-2">\${res[i].attdanDt}</td>
								<td class="p-2">\${res[i].userNm}</td>
							</tr>`
					}
				}else{
					for(let i=0; i<res.length; i++){
						str += `
							<tr class="p-2">
								<td class="p-2">\${res[i].cdNm}</td>
								<td class="p-2">\${res[i].attdanDt}</td>
								<td class="p-2">\${res[i].userNm}</td>
							</tr>`
					}
				}
			}

			$("#attdanBody").html(str);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}
</script>
