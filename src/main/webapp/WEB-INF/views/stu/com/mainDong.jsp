<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<div>
	<h1>테스트 페이지 입니다.</h1>

	<button id="sBtn" type="button">입실 버튼</button>
	<button id="eBtn" type="button" disabled>퇴실 버튼</button>

	<div id="clock"></div>


	<input type="text" id="dDay" value="" placeholder="날짜">
	<input type="text" id="sTime" value="" placeholder="입실시간">
	<input type="text" id="eTime" value="" placeholder="퇴실시간">
	<input type="text" id="attdStatus" value="" placeholder="출결상태">
</div>
<script>
var header = '${_csrf.headerName}';
var token =  '${_csrf.token}';
var userNo = "<sec:authentication property='principal.member.userNo'/>"


$(function(){
	let sBtn = $("#sBtn");
	let eBtn = $("#eBtn");

	startTime()
	userCheck(userNo);

	//입실 버튼 클릭 시
	sBtn.on("click", function(){
		let time = $("#clock").text();
		let dayInfo = $("#dDay").val();

		time = time.substring(0,5);
		$("#sTime").val(time);

		data = {
			"attdAbmiYmd" : time,
			"stuNo" : userNo,
			"attdDt" : dayInfo
		}

		inClass(data);
	})

	//퇴실 버튼 클릭 시
	eBtn.on("click", function(){
		let time = $("#clock").text();
		let dayInfo = $("#dDay").val();

		time = time.substring(0,5);
		$("#eTime").val(time);

		data = {
			"attdLeaveYmd" : time,
			"stuNo" : userNo,
			"attdDt" : dayInfo
		}

		outClass(data);
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
    document.getElementById('clock').innerHTML =
    h + ":" + m + ":" + s;
    var t = setTimeout(startTime, 500);

    var yyyy = today.getFullYear();
    var mm = String(today.getMonth() + 1).padStart(2, '0');
    var dd = String(today.getDate()).padStart(2, '0');
    var formattedDate = yyyy + "-" + mm + "-" + dd;

    $("#dDay").val(formattedDate);
}

function checkTime(i) {
    if (i < 10) {i = "0" + i}; // 숫자가 10보다 작을 경우 앞에 0을 붙여줌
    return i;
}

function userCheck(userNo){
	$.ajax({
		url : "/stu/dong/usercheck",
		type : "get",
		data : {"userNo" : userNo},
		dataType : "text",
		success : function(res){
			let dayInfo = $("#dDay").val();

			data = {
				"stuNo" : userNo,
				"attdDt" : dayInfo
			}

			if(res == "inData"){
				selectData(data)
			}else{
				attdInsert(data);
			}
		}
	})
}

function selectData(data){
	$.ajax({
		url : "/stu/dong/selectData",
		type : "get",
		data : data,
		dataType : "json",
		success : function(res){

			//입실 정보가 있을 경우
			if(res.attdAbmiYmd != null){
				//퇴실 정보가 있을 경우
				if(res.attdLeaveYmd != null){
					$("#sTime").val(res.attdAbmiYmd)
					$("#eTime").val(res.attdLeaveYmd)
				}else{
					$("#sTime").val(res.attdAbmiYmd)
				}
				$("#attdStatus").val(res.attdCd);
				$("#sBtn").prop("disabled", true);
				$("#eBtn").prop("disabled", false);
			}else{
				$("#sBtn").prop("disabled", false);
				$("#eBtn").prop("disabled", true);
			}
		}
	})
}

function attdInsert(data){
	$.ajax({
		url : "/stu/dong/attdInsert",
		type : "post",
		contentType : "application/json;charset=utf-8",
		beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
		},
		data : JSON.stringify(data),
		dataType : "text",
		success : function(res){
			console.log(res)

			if(res == "실패"){
				alert("실패");
			}else{
				$("#dDay").val(res);
			}
		}
	})
}

function inClass(data){
	$.ajax({
		url : "/stu/dong/inClass",
		type : "post",
		contentType : "application/json;charset=utf-8",
		beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
		},
		data : JSON.stringify(data),
		dataType : "text",
		success : function(res){
			let dayInfo = $("#dDay").val();

			data = {
				"stuNo" : userNo,
				"attdDt" : dayInfo
			}

			if(res === "OK"){
				alert("입실하셨습니다.")

				selectData(data)
			}
		}
	})
}

function outClass(data){
	$.ajax({
		url : "/stu/dong/outClass",
		type : "post",
		contentType : "application/json;charset=utf-8",
		beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
		},
		data : JSON.stringify(data),
		dataType : "text",
		success : function(res){

			let dayInfo = $("#dDay").val();

			data = {
				"stuNo" : userNo,
				"attdDt" : dayInfo
			}
			if(res === "OK"){
				selectData(data)
			}
		}
	})
}
</script>