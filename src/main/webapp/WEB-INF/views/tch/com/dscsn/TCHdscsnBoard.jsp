<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<style>
#topDiv, #topDiv2{
	height: 70vh;
}

#oneBoxBody tr, #twoBoxBody1 tr, #resultBody tr{
	cursor: pointer;
}

.menu_title {
margin: 3px 0 15px;
padding: 0 0 0 13px;
background: url(/resources/img/h4.png) no-repeat 0 4px;
font-size: 22px;
font-weight: 700;
color: #000;
}

</style>

<div class="card" style="height: 80vh;margin-bottom: 0;">
	<div class="card-body">
		<ul class="nav nav-tabs mb-3" role="tablist">
			<li class="nav-item" role="presentation">
				<a href="#home" data-bs-toggle="tab" aria-expanded=true class="nav-link active">
					<i class="mdi mdi-home-variant d-lg-none d-block me-1"></i>
					<span class="d-none d-lg-block">상담 승인 페이지</span>
				</a>
			</li>
			<li class="nav-item" role="presentation">
				<a href="#profile" data-bs-toggle="tab" aria-expanded="false" class="nav-link">
					<i class="mdi mdi-account-circle d-lg-none d-block me-1"></i>
					<span class="d-none d-lg-block">상담 결과</span>
				</a>
			</li>
		</ul>

		<div class="tab-content">
			<div class="tab-pane show active" id="home" role="tabpanel">
				<div id="topDiv" class="row">
					<div id="oneBox" class="col-12" style="height: 320px;">
						<div class="row align-items-end" style="height: 50px;">
							<div class="col-6">
								<h4 class="menu_title">미승인 상담 목록</h4>
							</div>
							<div class="col-6" style="text-align: right;">
								<a href="/tch/dscsn/goDscsnList">+더보기</a>
							</div>
						</div>
						<table id="mainTable" class="table table-hover">
							<thead class="table-secondary">
								<tr>
									<th style="text-align: center;" colspan="4" class="p-1">미승인 상담</th>
								</tr>
								<tr>
									<th class="p-1">분류</th>
									<th class="p-1">상담일</th>
									<th class="p-1">상담원</th>
									<th class="p-1">상담자</th>
								</tr>
							</thead>
							<tbody class="table" id="oneBoxBody">
							</tbody>
						</table>
					</div>

					<div id="twoBox" class="col-12" style="height: 320px;">
						<div class="row"  style="height: 100%;">
							<div class="col-6">
								<div class="row align-items-end" style="height: 50px;">
									<div class="col-6">
										<h4 class="menu_title">승인 상담 목록</h4>
									</div>
									<div class="col-6" style="text-align: right;">
										<a href="/tch/dscsn/approlist">+더보기</a>
									</div>
								</div>
								<table id="approvalTable" class="table table-hover">
									<thead class="table-secondary">
										<tr>
											<th style="text-align: center;" colspan="5" class="p-1">승인 상담</th>
										</tr>
										<tr>
											<th class="p-1">분류</th>
											<th class="p-1">상담일</th>
											<th class="p-1">상담원</th>
											<th class="p-1">상담자</th>
											<th class="p-1">상담 호실</th>
										</tr>
									</thead>
									<tbody class="table" id="twoBoxBody1">
									</tbody>
								</table>
							</div>

							<div class="col-6">
								<div class="row align-items-end" style="height: 50px;">
									<div class="col-6">
										<h4 class="menu_title">반려 상담 목록</h4>
									</div>
									<div class="col-6" style="text-align: right;">
										<a href="/tch/dscsn/unapprolist">+더보기</a>
									</div>
								</div>
								<table id="unApprovalTable" class="table">
									<thead class="table-secondary">
										<tr>
											<th style="text-align: center;" colspan="4" class="p-1">반려 상담</th>
										</tr>
										<tr>
											<th class="p-1">분류</th>
											<th class="p-1">상담일</th>
											<th class="p-1">상담원</th>
											<th class="p-1">상담자</th>
										</tr>
									</thead>
									<tbody class="table" id="twoBoxBody2">
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="tab-pane" id="profile" role="tabpanel">
				<div id="topDiv2" class="row">
					<div class="col-12">
						<table id="resulTable" class="table table-hover">
							<thead class="table-secondary">
								<tr>
									<th style="text-align: center;" colspan="4" class="p-1">상담 완료 목록</th>
								</tr>
								<tr>
									<th class="p-1">분류</th>
									<th class="p-1">상담일</th>
									<th class="p-1">상담원</th>
									<th class="p-1">상담자</th>
								</tr>
							</thead>
							<tbody class="table" id="resultBody">
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

	</div>
	<!-- end card-body-->
</div>


<div class="modal fade" id="dscnInfo" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="staticBackdropLabel">상담 신청 정보</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div id="dscnInfoBody" class="modal-body">
			</div>
			<div class="modal-footer" style="text-align: center;">
				<button type="button" id="approBtn" class="btn btn-primary">승인</button>
				<button type="button" id="unApproBtn" class="btn btn-danger">반려</button>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="approvalModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="staticBackdropLabel">상담 승인 후 상담실 선택</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>

			<div id="mBody" class="modal-body">
				<div class="input-group mb-3">
					<label class="input-group-text" style="width: 90px;">상담 날짜</label>
					<input type="text" id="dscsnDay" class="form-control" value="" readonly/>
				</div>
				<div class="input-group mb-3">
					<label class="input-group-text" style="width: 90px;">시작 시간</label>
					<select id="sTime" class="form-select">
						<option>--시간 선택--</option>
						<option>09:00</option>
						<option>10:00</option>
						<option>11:00</option>
						<option>12:00</option>
						<option>13:00</option>
						<option>14:00</option>
						<option>15:00</option>
						<option>16:00</option>
						<option>17:00</option>
						<option>18:00</option>
						<option>19:00</option>
						<option>20:00</option>
						<option>21:00</option>
					</select>
					<label class="input-group-text" style="width: 90px;">종료 시간</label>
					<select id="eTime" class="form-select">
						<option>--시간 선택--</option>
						<option>10:00</option>
						<option>11:00</option>
						<option>12:00</option>
						<option>13:00</option>
						<option>14:00</option>
						<option>15:00</option>
						<option>16:00</option>
						<option>17:00</option>
						<option>18:00</option>
						<option>19:00</option>
						<option>20:00</option>
						<option>21:00</option>
						<option>22:00</option>
					</select>
				</div>
				<div class="input-group mb-3">
					<label class="input-group-text" style="width: 90px;">상담실</label>
					<select id="dscRoom" class="form-select">
						<option>--상담실을 선택하세요--</option>
					</select>
				</div>
				<input type="hidden" id="dscsnNo" name="dscsnNo" value="">
			</div>

			<div class="modal-footer">
				<button type="button" id="approvalBtn" class="btn btn-primary">승인</button>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="unApprovalModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="staticBackdropLabel">상담 반려</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>

			<div id="unBody" class="modal-body">
				<div class="input-group mb-3">
					<label class="input-group-text" style="width: 90px;">상담구분</label>
					<input type="text" id="noDscsnType" class="form-control" value="" readonly/>
				</div>
				<div class="input-group mb-3">
					<label class="input-group-text" style="width: 90px;">상담일</label>
					<input type="text" id="noDscsnDay" class="form-control" value="" readonly/>
				</div>
				<div class="input-group mb-3">
					<label class="input-group-text" style="width: 90px;">상담자</label>
					<input type="text" id="noDscsnJa" class="form-control" value="" readonly/>
				</div>
				<div class="input-group mb-3">
					<label class="input-group-text" style="width: 90px;">상담원</label>
					<input type="text" id="noDscsnOne" class="form-control" value="" readonly/>
				</div>
				<div class="input-group mb-3">
					<label class="input-group-text" style="width: 90px;">반려 사유</label>
					<textarea class="form-control" id="noDscsnCn" aria-label="With textarea"></textarea>
				</div>
				<input type="hidden" id="noDscsnNo" name="dscsnNo" value="">
			</div>

			<div class="modal-footer">
				<button type="button" id="unApprovalBtn" class="btn btn-danger">반려</button>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>
<script>
var header = '${_csrf.headerName}';
var token =  '${_csrf.token}';
var userNo = '<sec:authentication property="principal.member.userNo"/>'

$(function(){

	dscsnNoList(userNo);
	dscsnApprovList(userNo);
	dscsnUnApprovList(userNo);

	dscsnClearList(userNo);

	//상담 완료 tr클릭시
	$("#resultBody").on("click", "tr", function(){
		var ddscNo = $(this).find("#ddscsnNo").val();
		var dscsnStatus = $(this).find("#dscStatus").val();
		var Name = $(this).find("td:eq(3)").text();

		location.href = "/tch/dscsn/resultPage?no="+ddscNo+"&name="+Name+"&status="+dscsnStatus;

	})

	$("#twoBoxBody1").on("click", "tr", function(){
		var ddscNo = $(this).find("#ddscNo").val();
		var dscsnStatus = $(this).find("#dscsnStatus").val();
		var stuName = $(this).find("td:eq(3)").text();

		location.href = "/tch/dscsn/resultPage?no="+ddscNo+"&name="+stuName+"&status="+dscsnStatus;
	})

	$("#oneBoxBody").on("click", "tr", function(){
		var str = "";

		var dscsnType = $(this).find("td:eq(0)").text();
		var dt = $(this).find("td:eq(1)").text();
		var consultant = $(this).find("td:eq(3)").text();
		var counselor = $(this).find("td:eq(2)").text();
		var cm = $(this).find("#dscCn").val();
		var no = $(this).find("#dscNo").val();

		str += `
			<div class="input-group mb-3">
				<label class="input-group-text" style="width: 90px;">상담 종류</label>
				<input type="text" id="dscsnType" class="form-control" value="\${dscsnType}" readonly/>
			</div>
			<div class="input-group mb-3">
				<label class="input-group-text" style="width: 90px;">상담일</label>
				<input type="text" id="dscDay" class="form-control" value="\${dt}" readonly/>
			</div>
			<div class="input-group mb-3">
				<label class="input-group-text" style="width: 90px;">상담자</label>
				<input type="text" id="dscsnJa" class="form-control" value="\${consultant}" readonly/>
			</div>
			<div class="input-group mb-3">
				<label class="input-group-text" style="width: 90px;">상담원</label>
				<input type="text" id="dscsnOne" class="form-control" value="\${counselor}" readonly/>
			</div>
			<div class="input-group mb-3">
				<label class="input-group-text" style="width: 90px;">상담 내용</label>
				<textarea class="form-control" aria-label="With textarea" readonly>\${cm}</textarea>
			</div>
			<input type="hidden" id="dsNo" value="\${no}"/>
		`
		$("#dscnInfoBody").html(str);

		$("#dscnInfo").modal("show");
	})


	//승인 버튼 클릭시
	$("#approBtn").on("click", function(){
		let day = $("#dscDay").val();
		let no = $("#dsNo").val();

		$("#dscnInfo").modal("hide");

		$("#dscsnDay").val(day);
		$("#dscsnNo").val(no);

		$("#approvalModal").modal("show");
	})

	$("#sTime").on("change", function(){
		$("#eTime").val($("#eTime option:first").val());

		//상담 종료시간 선택시
		$("#eTime").on("change", function(){
			let no = $("#dscsnNo").val();
			let day = $("#dscsnDay").val();
			let sTime = $("#sTime").val();
			let eTime = $("#eTime").val();

			let sNum = parseInt(sTime.substring(0,2));
			let eNum = parseInt(eTime.substring(0,2));

			if(sNum >= eNum){
				$("#eTime").val("");
				Swal.fire({
				  icon: 'warning',
				  title: '종료시간을 다시 선택해주세요.',
				  text: '종료시간이 시작시간보다 앞에 시간으로 선택되었습니다.',
				});
			}else{
				//시간이 정상적이므로 함수 실행
				data = {
					"dscsnNo" : no,
					"consulDt" : day,
					"consulBgngHr" : sTime,
					"consulDdlbHr" : eTime
				}

				viewConsulRoom(data);
			}
		})
	})

	$("#approvalBtn").on("click", function(){
		let no = $("#dscsnNo").val();
		let dscsnDay = $("#dscsnDay").val();
		let startT = $("#sTime").val();
		let endT = $("#eTime").val();
		let dscRoom = $("#dscRoom").val();

		if(sTime === ""){
			Swal.fire({
			  icon: 'warning',
			  title: '시작시간을 선택해주세요',
			  text: '시작시간을 선택해주세요.',
			});
			$("#sTime").focus();
		}else if(eTime === ""){
			Swal.fire({
			  icon: 'warning',
			  title: '종료시간을 선택해주세요',
			  text: '종료시간을 선택해주세요.',
			});
			$("#eTime").focus();
		}else if(dscRoom == "empty"){
			Swal.fire({
			  icon: 'warning',
			  title: '상담실을 선택해주세요',
			  text: '상담실을 선택해주세요.',
			});
			$("#dscRoom").focus();
		}else{
			data = {
				"dscsnNo" : no,
				"consulDt" : dscsnDay,
				"consulBgngHr" : startT,
				"consulDdlbHr" : endT,
				"consulCd" : dscRoom
			}

			insertReservation(data);
		}
	})

	//반려 버튼 클릭시
	$("#unApproBtn").on("click", function(){
		let noType = $("#dscsnType").val()
		let noDay = $("#dscDay").val()
		let noDscJa = $("#dscsnJa").val()
		let noDscOne = $("#dscsnOne").val()
		let no = $("#dsNo").val();


		$("#dscnInfo").modal("hide");

		$("#noDscsnType").val(noType);
		$("#noDscsnDay").val(noDay);
		$("#noDscsnJa").val(noDscJa);
		$("#noDscsnOne").val(noDscOne);
		$("#noDscsnNo").val(no)

		$("#unApprovalModal").modal("show");
	})

	//반려 사유 등록하고 반려 버튼 클릭
	$("#unApprovalBtn").on("click", function(){

		let noDscsnCn = $("#noDscsnCn").val()

		if(noDscsnCn === ""){
			alert("반려 사유를 입력해주세요")
		}else{
			let no = $("#noDscsnNo").val()

			data = {
				"dscsnNo" : no,
				"rejectCn" : noDscsnCn
			}

			insertReject(data);
		}
	})
})

function dscsnNoList(userNo){

	$.ajax({
		url : "/tch/dscsn/dscsnNoList",
		type : "get",
		data : {"userNo":userNo},
		success : function(res){
			str = "";

			if(res.length == 0){
				str += `
					<tr>
						<td colspan="4" class="p-2" style="text-align: center;">조회할 정보가 없습니다.</td>
					</tr>
				`
				$("#mainTable").removeClass("table-hover").css("pointer-events", "none");
			}else{
				if(res.length < 5){
					for(let i=0; i<res.length; i++){
						str += `
							<tr>
								<td class="p-2">\${res[i].dscsnCd}</td>
								<td class="p-2">\${res[i].dscsnDt}</td>
								<td class="p-2">\${res[i].empNo}</td>
								<td class="p-2">\${res[i].stuNo}</td>
								<input type="hidden" id="dscCn" value="\${res[i].dscsnCn}"/>
								<input type="hidden" id="dscNo" value="\${res[i].dscsnNo}"/>
							</tr>
						`
					}
				}else{
					for(let i=0; i<5; i++){
						str += `
							<tr>
								<td class="p-2">\${res[i].dscsnCd}</td>
								<td class="p-2">\${res[i].dscsnDt}</td>
								<td class="p-2">\${res[i].empNo}</td>
								<td class="p-2">\${res[i].stuNo}</td>
								<input type="hidden" id="dscCn" value="\${res[i].dscsnCn}"/>
								<input type="hidden" id="dscNo" value="\${res[i].dscsnNo}"/>
							</tr>
						`
					}
				}
				$("#mainTable").addClass("table-hover").css("pointer-events", "pointer");
			}

			$("#oneBoxBody").html(str);

		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function dscsnApprovList(userNo){
	$.ajax({
		url : "/tch/dscsn/dscsnApprovList",
		type : "get",
		data : {"userNo":userNo},
		dataType : "json",
		success : function(res){
			str = "";

			if(res.length == 0){
				str += `
					<tr>
						<td colspan="5" class="p-2" style="text-align: center;">조회할 정보가 없습니다.</td>
					</tr>`
				$("#approvalTable").removeClass("table-hover").css("pointer-events", "none");
			}else{
				if(res.length < 5){
					for(let i=0; i<res.length; i++){
						str += `
							<tr>
								<td class="p-2">\${res[i].dscsnCd}</td>
								<td class="p-2">\${res[i].dscsnDt}</td>
								<td class="p-2">\${res[i].empNo}</td>
								<td class="p-2">\${res[i].stuNo}</td>
								<td class="p-2">\${res[i].consulNm}</td>
								<input type="hidden" id="ddscNo" value="\${res[i].dscsnNo}"/>
								<input type="hidden" id="dscsnStatus" value="\${res[i].dscsnYn}"/>
							</tr>`
					}
				}else{
					for(let i=0; i<5; i++){
						str += `
							<tr>
								<td class="p-2">\${res[i].dscsnCd}</td>
								<td class="p-2">\${res[i].dscsnDt}</td>
								<td class="p-2">\${res[i].empNo}</td>
								<td class="p-2">\${res[i].stuNo}</td>
								<td class="p-2">\${res[i].consulNm}</td>
								<input type="hidden" id="ddscNo" value="\${res[i].dscsnNo}"/>
								<input type="hidden" id="dscsnStatus" value="\${res[i].dscsnYn}"/>
							</tr>`
					}
				}
				$("#approvalTable").addClass("table-hover").css("pointer-events", "pointer");
			}

			$("#twoBoxBody1").html(str);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function dscsnUnApprovList(userNo){
	$.ajax({
		url : "/tch/dscsn/dscsnUnApprovList",
		type : "get",
		data : {"userNo":userNo},
		dataType : "json",
		success : function(res){
			str = "";

			if(res.length == 0){
				str += `
					<tr>
						<td colspan="4" class="p-2" style="text-align: center;">조회할 정보가 없습니다.</td>
					</tr>`
			}else{
				if(res.length < 5){
					for(let i=0; i<res.length; i++){
						str += `
							<tr>
								<td class="p-2">\${res[i].dscsnCd}</td>
								<td class="p-2">\${res[i].dscsnDt}</td>
								<td class="p-2">\${res[i].empNo}</td>
								<td class="p-2">\${res[i].stuNo}</td>
							</tr>`
					}
				}else{
					for(let i=0; i<5; i++){
						str += `
							<tr>
								<td class="p-2">\${res[i].dscsnCd}</td>
								<td class="p-2">\${res[i].dscsnDt}</td>
								<td class="p-2">\${res[i].empNo}</td>
								<td class="p-2">\${res[i].stuNo}</td>
							</tr>`
					}
				}
			}

			$("#twoBoxBody2").html(str);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function dscsnClearList(userNo){

	$.ajax({
		url : "/tch/dscsn/dscsnClearList",
		type : "get",
		data : {"userNo":userNo},
		dataType : "json",
		success : function(res){
			str = "";

			if(res.length == 0){
				str += `
					<tr>
						<td colspan="4" class="p-2" style="text-align: center;">조회할 정보가 없습니다.</td>
					</tr>`
					$("#resulTable").removeClass("table-hover").css("pointer-events", "none");
			}else{
				for(let i=0; i<res.length; i++){
				str += `
					<tr>
						<td class="p-2">\${res[i].dscsnCd}</td>
						<td class="p-2">\${res[i].dscsnDt}</td>
						<td class="p-2">\${res[i].empNo}</td>
						<td class="p-2">\${res[i].stuNo}</td>
						<input type="hidden" id="ddscsnNo" value="\${res[i].dscsnNo}"/>
						<input type="hidden" id="dscStatus" value="\${res[i].dscsnYn}"/>
					</tr>`
				}
				$("#resulTable").addClass("table-hover").css("pointer-events", "pointer");
			}


			$("#resultBody").html(str);

		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})

}

function viewConsulRoom(data){

	$.ajax({
		url : "/tch/dscsn/viewConsulRoom",
		type : "get",
		data : data,
		dataTYpe : "json",
		success : function(res){
			str = "";

			if(res.length == 0){
				alert("선택 가능한 상담실이 없습니다.")
			}else{
				str += `<option value="empty">--상담실을 선택하세요--</option>`
				for(let i=0; i<res.length; i++){
					str += `
						<option value="\${res[i].consulCd}">\${res[i].consulNm}</option>
					`
				}

				$("#dscRoom").html(str);
			}
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function insertReservation(data){

	$.ajax({
		url : "/tch/dscsn/insertReservation",
		type : "post",
		contentType : "application/json;charset=utf-8",
		beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
		},
		dataType : "text",
		data : JSON.stringify(data),
		success : function(res){
			if(res === "성공"){
				$("#approvalModal").modal("hide");

				setTimeout(() => {
					dscsnNoList(userNo);
					dscsnApprovList(userNo);
					dscsnUnApprovList(userNo);
				}, 200);
			}else if(res === "실패"){
				alert("예약에 실패했습니다.")
			}
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function insertReject(data){

	$.ajax({
		url : "/tch/dscsn/insertReject",
		type : "post",
		contentType : "application/json;charset=utf-8",
		beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
		},
		dataType : "text",
		data : JSON.stringify(data),
		success : function(res){
			if(res === "성공"){
				$("#unApprovalModal").modal("hide");

				setTimeout(() => {
					dscsnNoList(userNo);
					dscsnApprovList(userNo);
					dscsnUnApprovList(userNo);
				}, 200);
			}else if(res === "실패"){
				alert("예약에 실패했습니다.")
			}
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}
</script>