<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>

</style>
<body>

<div id="mainContainer">
	<div class="col-md-12" style="text-align: center">
		<label>연수과정 명</label>
		<h1>${svlfVO.svlfNm }</h1>
	</div>
	<div class="row justify-content-center">
		<div class="col-md-6">
			<label>시작일</label><h1>${svlfVO.svlfBgngDt }</h1>
		</div>
		<div class="col-md-6">
			<label>수료일</label><h1>${svlfVO.svlfDdlbDt }</h1>
		</div>
	</div>
	<div class="row justify-content-center">
		<div class="col-md-6">
			<label>강의실</label>
			<h1>${svlfVO.lectureRoomNm }</h1>
		</div>
		<div class="col-md-6">
			<label>담임</label>
			<h1>${svlfVO.userNm }</h1>
		</div>
	</div>
	<div>
		<label>연수과정 내용</label><br>
		<h2>${svlfVO.svlfCn }</h2>
	</div>
</div>
<div class="btn-group" role="group" aria-label="Basic outlined example">
	<input type="button" id="modifyBtn" value="수정" class="btn btn-outline-primary"/>
	<input type="button" id="delBtn" value="삭제" class="btn btn-outline-primary"/>
	<input type="button" id="listBtn" value="목록" class="btn btn-outline-primary"/>
</div>

<script type="text/javascript">
$(function(){
	var modifyBtn = $("#modifyBtn");
	var delBtn = $("#delBtn");
	var listBtn = $("#listBtn");

	modifyBtn.on("click", function(){
		location.href = "/emp/svlf/svlfUpdateForm?svlno=${svlfVO.svlfNo }";
	})

	/*
		문제 : 연수과정을 막 생성했을 떄는 삭제 가능
			  하지만 연수과정과 연관된 원생이 한명이라도 있을 경우 삭제 불가
			  삭제 기능은 일단 만들어기 때문에 놔두기
	*/
	delBtn.on("click", function(){
		location.href = "/emp/svlf/svlfDel?svlno=${svlfVO.svlfNo }";
	})

	listBtn.on("click", function(){
		location.href = "/emp/svlf/svlfList";
	})
})
</script>
</body>
