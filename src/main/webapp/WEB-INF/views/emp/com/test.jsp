<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<div>
	<h1>테스트 페이지 입니다.</h1>

	<button id="sBtn" type="button">입실 버튼</button>
	<button id="eBtn" type="button" disabled>퇴실 버튼</button>

	<div id="clock"></div>

	<input type="text" id="sTime" value="">
	<input type="text" id="eTime" value="">
</div>
<script>
let userNo = "<sec:authentication property="principal.member.userNo"/>"

userCheck(userNo);
startTime()

$(function(){
	let sBtn = $("#sBtn");
	let eBtn = $("#eBtn");

	//입실 버튼 클릭 시
	sBtn.on("click", function(){
		let time = $("#clock").text();

		$("#sTime").val(time);

		sBtn.prop("disabled", true);
		eBtn.prop("disabled", false);
	})

	//퇴실 버튼 클릭 시
	eBtn.on("click", function(){
		let time = $("#clock").text();

		$("#eTime").val(time);

		//시간, 날짜 가져오고 insert
	})

	//1초마다 시간과 분이 0인지 확인 즉 08시 00분인지를 확인
	//08시 00분인 되면 입실 버튼 활성화, 퇴실버튼 비활성화
	setInterval(function() {
		let today = new Date();
		let hours = today.getHours();
		let minutes = today.getMinutes();

		if (hours === 8 && minutes === 0) {
			sBtn.prop("disabled", false);
			eBtn.prop("disabled", true);
		}
	}, 1000); // 1초마다 확인
})

function startTime() {
    var today = new Date();
    var h = today.getHours();
    var m = today.getMinutes();
    var s = today.getSeconds();
    m = checkTime(m);
    s = checkTime(s);
    document.getElementById('clock').innerHTML =
    h + ":" + m + ":" + s;
    var t = setTimeout(startTime, 500);
}

function checkTime(i) {
    if (i < 10) {i = "0" + i}; // 숫자가 10보다 작을 경우 앞에 0을 붙여줌
    return i;
}

function userCheck(userNo){

	$.ajax({
		url
	})
}
</script>