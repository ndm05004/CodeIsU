<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<style>
	.avatar-sm {
		width: 50px;
		height: 50px;
	}

	.more {
		font-weight: bold;
		cursor: pointer;
	}

	.more2 {
		font-weight: bold;
		cursor: pointer;
	}

	.mpoint {
		cursor: pointer;
	}

	/* 프로젝트내용 마우스오버 */
	.hover-text-container {
		position: relative;
	}

	.hover-text {
	display: none;
	position: absolute;
	width: 600px;
	top: 10%;
	left: 0;
	background-color: #444444;
	color: #ffffff;
	padding: 5px;
	white-space: normal;
	border-radius: 5px;
	transition: all ease 0.5s;
	overflow: hidden;
	overflow-y: auto;
	max-height: 200px; /* 최대 높이를 200px로 설정 */
	}

	.hover-text-container:hover .hover-text {
		display: inline-block;

	}
</style>
<form action="/stu/classroom/assign/sbmsn/result?${_csrf.parameterName }=${_csrf.token}" method="get" id="sbmsnResultForm">
	<input type="hidden" name="asmtNo" value="" id="asmtNo">
	<input type="hidden" name="sbjctCd" value="" id="sbjctCd">
</form>
<div class="row">
	<!--시간표-->
	<div class="col-4">
		<div class="card mb-4">
			<div class="card-body">
				<div class="text-muted" id="dateBox"></div>
				<h2 class="" id="timeBox"></h2>
			</div>
		</div>
		<div class="card mb-4" style="height: 156px;">
			<div class="card-body">
				<div class="row mb-3">
          <div class="col-6">
            <h4 class="card-title mb-0">출석</h4>
            <div id="dDay" class="fs-6 text-muted"></div>
          </div>
          <div class="col-6 text-end">
            <button id="sBtn" class="btn btn-primary" type="button">입실</button>
            <button id="eBtn"  class="btn btn-primary" type="button" disabled>퇴실</button>
          </div>
				</div>
        <input type="hidden" id="clock">
				<div class="row">
          <div class="col-4">
            <div id="" class="text-muted">입실</div>
          </div>
          <div class="col-5">
            <div id="" class="text-muted">퇴실</div>
          </div>
          <div class="col-3">
            <div id="" class="text-muted">상태</div>
          </div>
				</div>
				<div class="row">
          <div class="col-4">
            <div id="sTime"></div>
          </div>
          <div class="col-5">
            <div id="eTime"></div>
          </div>
          <div class="col-3">
            <div id="attdStatus"></div>
          </div>
				</div>
			</div>
		</div>
		<div class="card">
			<div class="card-body">
				<div class="row mb-2">
					<h4 class="card-title">시간표</h4>
				</div>
				<div class="row" style="margin-bottom: 2px;">
					<div class="col-9">오전 &nbsp;&nbsp;&nbsp;<span id="amSbjctNm">-</span></div>
					<div class="col-3" id="amEmpNo">-</div>
				</div>
				<div class="row">
					<div class="col-9">오후 &nbsp;&nbsp;&nbsp;<span id="pmSbjctNm">-</span></div>
					<div class="col-3" id="pmEmpNo">-</div>
				</div>
			</div>
		</div>
	</div>
	<div class="col-8">
		<div class="card" style="height: 462px;">
			<div class="card-body">
				<div class="row mb-2">
					<h4 class="card-title">과제</h4>
				</div>
				<div id="asmtListContainer"></div>
			</div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-4">
		<!-- 내 프로젝트 리스트 -->
		<div class="card" style="height: 240px;">
			<div class="card-body">
				<div class="row mb-2">
					<div class="col-8 h3" style="font-weight: bold;">
						<h4>내 프로젝트</h4>
					</div>
					<div class="col-4 text-xs more2 text-end">
						<a href="javascript:goToMenu('pms_myprojects')">+더보기</a>
					</div>
				</div>
				<div class="row">
					<div class="col scroll-Wrap" id="projectList"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="col-8">
		<!-- 이슈 리스트 -->
		<div class="card" style="height: 240px;">
			<div class="card-body">
				<div class="row mb-2">
					<div class="col-8 h3" style="font-weight: bold;">
						<h4>이슈</h4>
					</div>
					<div class="col-4 text-xs text-end more">
						<a href="javascript:goToMenu('pms_issue')">+더보기</a>
					</div>
				</div>
				<div class="row">
					<table>
						<tr class="col text-center">
							<th>제목</th>
							<th>담당자</th>
							<th>등록자</th>
							<th>등록일</th>
							<th>상태</th>
						</tr>

						<tbody class="text-center" id="issueList">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 프로젝트 리스트 -->

<script>
	var currDt = "";
	// 날짜 넣기
	function currentDateTime() {
		var currentDate = new Date();

		var year = currentDate.getFullYear(); //년
		var month = currentDate.getMonth() + 1; // 월
		var date = currentDate.getDate(); // 일
		currDt = year + "-" + (month < 10 ? "0" + month : month) + "-" + (date < 10 ? "0" + date : date); // 오늘날짜

		// 시간
		var hours = currentDate.getHours();
		var minutes = currentDate.getMinutes();
		// 시간, 분, 초를 두 자리 숫자 형태로 조합
		var currTime = (
			(hours < 10 ? "0" + hours : hours) + ":" +
			(minutes < 10 ? "0" + minutes : minutes) + ""
			);
		const dateBox = document.querySelector('#dateBox');
		const timeBox = document.querySelector('#timeBox');
		dateBox.innerText = currDt;
		timeBox.innerText = currTime;
	}
	// 최초 페이지 로딩시 시간 표시
	currentDateTime();
	// 1초마다 시간 업데이트
	setInterval(currentDateTime, 1000);


	// 글자수 자르는 함수
	function stringSlice(str, maxLength) {
        if (str.length > maxLength) {
            return str.substring(0, maxLength) + "...";
        }
        return str;
    }


	var stuNo = "${userNo}";

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

	/* 프로젝트 리스트  */
	function projectList(stuNo) {
		$.ajax({
			url: "/stu/projlist",
			data: {
				stuNo: stuNo,
			},
			type: "get",
			dataType: "json",
			success: function (res) {
				console.log("ProjList", res);

				var projList = "";
				if (res.length === 0) {
					projList += `
				<div class="row pb-2">
					<p></p>
					<p colspan="2" class="col text-center fs-6 font-weight-bolder pt-4 pb-3"> 가입된 프로젝트가 없습니다. </p>
				</div>
					`;
				} else {

					for (let i = 0; i < res.length; i++) {
						projList += `
						<div class="row pb-2 mpoint" id="proj">
							<div class="col-3 text-center d-flex align-items-center">
								<img src="../pms/assets/img/small-logos/github.svg" class="avatar rounded-circle me-2" width="40px" height="40px">
							</div>
							<div class="col-9 d-flex align-items-center">
								<div class="mb-0 text-xs" id="projNm" data-value="\${res[i].projNo}">\${res[i].projNm}</div>
							</div>
						</div>
			`;
					}
				}
				$("#projectList").html(projList);
			}
		});
	};

	projectList(stuNo);

	$("#projectList").on("click", "#proj", function () {
		var projNo = $(this).find("#projNm").data("value");
		console.log("projNo ", projNo)

		location.href = "/pms/project/dashBoard?projNo=" + projNo;
	})

	/* 이슈 리스트 */
	function issueList(stuNo) {
		$.ajax({
			url: "/stu/issuelist",
			data: {
				stuNo: stuNo,
			},
			type: "get",
			dataType: "json",
			success: function (res) {
				console.log("issueList", res);

				var issueList = "";
				if (res.length === 0) {
					issueList += `
						<tr class="pb-2">
							<td colspan="5" class="text-center fs-6 font-weight-bolder pt-4 pb-3"> 등록된 이슈가 없습니다. </td>
						</tr>
							`;
				} else {

					for (let i = 0; i < res.length; i++) {
						issueList += `
							<tr>
								<td>\${res[i].issueTtl}</td>
								<td>\${res[i].issueAsg}</td>
								<td>\${res[i].stuNo}</td>
								<td>\${convertDate(res[i].issueRegDt)}</td>
								<td>\${res[i].issueSttsCd}</td>
							</tr>
						`;
					}
				}
				$("#issueList").html(issueList);
			}
		});
	};

	issueList(stuNo);

	// 시간표
	timetableAjax()
	function timetableAjax() {
		$.ajax({
			url: "/stu/timetable",
			type: "get",
			dataType: "json",
            success: function(res) {
                console.log("시간표",res);
				res.forEach(function(sbjct) {
					if(sbjct.scduHr == "오전"){
						$("#amSbjctNm").text(sbjct.sbjctNm);
						$("#amEmpNo").text(sbjct.empNo);
					} 
					if(sbjct.scduHr == "오후"){
						$("#pmSbjctNm").text(sbjct.sbjctNm);
						$("#pmEmpNo").text(sbjct.empNo);
					} 
				});

            },
            error: function(xhr, status, error) {
                // 요청이 실패했을 때 처리할 코드 작성
            }
        });
	}

	// 과제 리스트
	asmtAjax()
	function asmtAjax() {
		$.ajax({
			url: "/stu/asmt",
			type: "get",
			dataType: "json",
            success: function(res) {
                console.log("과제",res);
				var asmtStr = "";
				res.forEach(function(asmt, index) {
					var textColor = "";
					var submitYn = "";
					var margin = "";
					if(index > 0){
						margin = "mt-4"
					}
					if(asmt.qstSbmsnYn == "Y"){
						textColor = "text-primary";
						submitYn = "제출완료";
						asmtStr += '<div class="row asmtResult '+ margin +'" data-asmtNo="' + asmt.asmtNo +'" data-sbjctCd="' + asmt.sbjctCd +'">';
                    } else if(asmt.asmtDdln <currDt) {
						textColor = "text-muted";
						submitYn = "기간만료"
						asmtStr += '<div class="row '+ margin +'">';
                    } else {
						textColor = "text-danger";
						submitYn = "미제출"
						asmtStr += '<div class="row asmtNoResult '+ margin +'" data-asmtNo="' + asmt.asmtNo + '" data-sbjctCd = "' + asmt.sbjctCd +'">';
                    }
						asmtStr += `	<div class="col-1 d-flex align-items-center">`;
						asmtStr += `		<img src="${pageContext.request.contextPath}/resources/img/classroom/asmtIcon.png" alt="user" width="40" height="40">`;
						asmtStr += `	</div>`;
						asmtStr += `	<div class="col-9">`;
						asmtStr += '		<div class="card-title fs-3 mb-0">';
						asmtStr += 				stringSlice(asmt.asmtTtl, 20)
						asmtStr += '		</div>';
						asmtStr += `		<div class="text-muted">`;
						asmtStr += 				asmt.asmtDdln + ' 까지';
						asmtStr += `		</div>`;
						asmtStr += `	</div>`;

						asmtStr += '	<div class="col-2 align-middle '+ textColor +'">';
						asmtStr += 			submitYn
						asmtStr += `	</div>`;
						asmtStr += `</div>`;
				});
				document.querySelector("#asmtListContainer").innerHTML = asmtStr;

            },
            error: function(xhr, status, error) {
                // 요청이 실패했을 때 처리할 코드 작성
            }
        });
	}

	// 과제 제출완료시 이동
	$(document).on("click", ".asmtNoResult", function(e) {
        //console.log("asmtNo " , asmtNo);
		var sbjctCd = $(this).attr("data-sbjctCd");
		var asmtNo = $(this).attr("data-asmtNo");
		console.log("쳍킁 :" , sbjctCd);
        location.href = "/stu/classroom/assign/sbmsn?asmtNo=" + asmtNo + "&sbjctCd=" + sbjctCd;
    })
	
	// 과제 제출시 이동
    $(document).on("click", ".asmtResult", function(e) {
        //console.log("asmtNo " , asmtNo);
		var asmtNo = $(this).attr("data-asmtNo");
		var sbjctCd = $(this).attr("data-sbjctCd");
        document.querySelector("#asmtNo").value = asmtNo;
        document.querySelector("#sbjctCd").value = sbjctCd;
        document.querySelector("#sbmsnResultForm").submit();

    })




	// 출석체크
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
			let dayInfo = $("#dDay").text();

			time = time.substring(0,5);
			$("#sTime").text(time);

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
			let dayInfo = $("#dDay").text();

			time = time.substring(0,5);
			$("#eTime").text(time);

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

		$("#dDay").text(formattedDate);
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
				let dayInfo = $("#dDay").text();

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
						$("#sTime").text(res.attdAbmiYmd)
						$("#eTime").text(res.attdLeaveYmd)
					}else{
						$("#sTime").text(res.attdAbmiYmd)
					}
					$("#attdStatus").text(res.attdCd);
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
					$("#dDay").text(res);
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
				let dayInfo = $("#dDay").text();

				data = {
					"stuNo" : userNo,
					"attdDt" : dayInfo
				}

				if(res === "OK"){
          // 입실 성공
          Swal.fire(
          '출석',
          '입실이 완료되었습니다!',
          'success'
          ).then((result) => {
            let sBtn = $("#sBtn");
            let eBtn = $("#eBtn");

            selectData(data)
            // 입실 스타일 변경

          })


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

				let dayInfo = $("#dDay").text();

				data = {
					"stuNo" : userNo,
					"attdDt" : dayInfo
				}
				if(res === "OK"){
          Swal.fire(
          '출석',
          '퇴실이 완료되었습니다!',
          'success'
          ).then((result) => {
            selectData(data)

          })
				}
			}
		})
	}
</script>