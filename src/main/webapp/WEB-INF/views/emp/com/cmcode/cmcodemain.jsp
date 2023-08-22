<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
#mainCont{
	width: 100%;
	height: 85vh;
	display: flex;
	justify-content: space-evenly;
}

.mainContainer{
	height: 650px;
	overflow: auto;
}

.table thead th {
  position: sticky;
  top: 0;
  z-index: 1; /* 필요에 따라 z-index 값을 설정하여 다른 요소 위로 겹치게 할 수 있습니다. */
}

#mainTr{
	cursor: pointer;
}

#mainTr:hover {
	background-color: lightgray;
}

#indiv{
	display: flex;
	justify-content: flex-end;
}

.impolTd{
	display: flex;
	align-items: center;
	justify-content: space-between;
}

tbody td{
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
</style>


<div id="mainCont">
	<div style="width: 45%;">
		<div id="firstBox" class="mainContainer">
			<table class="table mTb">
				<thead class="table-secondary">
					<tr>
						<th style="text-align: center;" colspan="3" class="p-2">코드 그룹</th>
					</tr>
					<tr>
						<th class="p-2" style="width:100px">코드 유형ID</th>
						<th class="p-2" style="width:80px">사용여부</th>
						<th class="p-2">코드 유형명</th>
					</tr>
				</thead>
				<tbody class="tbBody">
					<c:set value="${cmtyList }" var="cmtylist"/>
					<c:choose>
						<c:when test="${empty cmtylist }">
							<tr>
								<td class="p-2" colspan="2">조회할 그룹이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${cmtylist }" var="cmty">
								<tr id="mainTr" data-cdtypeid="${cmty.cdTypeId }">
									<td id="firstTd" class="p-2">${cmty.cdTypeId }</td>
									<td class="p-2">${cmty.cdTUseYn }</td>
									<td id="secondTd" class="impolTd p-2">
										<font>${cmty.cdTypeNm }</font>
										<div>
											<button value="modiCodeType" class="btn btn-secondary btn-sm mainBtn" data-bs-toggle="modal" data-bs-target="#firstModal">수정</button>
			    						</div>
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		<div>
			<button type="button" id="addCodeType" value="addCodeType" class="btn btn-secondary mainBtn btn-sm" data-bs-toggle="modal" data-bs-target="#firstModal">등록</button>
		</div>
	</div>
	<div style="width: 45%;">
		<div id="secondBox" class="mainContainer">
			<table class="table mTb">
				<thead class="table-secondary">
					<tr>
						<th style="text-align: center;" colspan="4" class="p-2">코드 목록</th>
					</tr>
					<tr>
						<th class="p-2" style="width:80px">코드값</th>
						<th class="p-2" style="width:80px">사용여부</th>
						<th class="p-2" style="width:100px">코드명</th>
						<th class="p-2">코드 설명</th>
					</tr>
				</thead>
				<tbody class="tbBody">
				</tbody>
			</table>
		</div>
		<div>
			<button type="button" id="addCode" value="addCode" class="btn btn-secondary mainBtn btn-sm" data-bs-toggle="modal" data-bs-target="#secondModal">등록</button>
		</div>
	</div>
</div>

<div id="firstModal" class="modal fade" tabindex="-1" aria-labelledby="dark-header-modalLabel" aria-modal="true" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header modal-colored-header bg-secondary">
				<h4 class="modal-title" id="dark-header-modalLabel"></h4>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
			</div>

			<div class="modal-body" id="cmcdBody">
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-dark" id="cmcdFoot"></button>
				<button type="button" class="btn btn-light" data-bs-dismiss="modal">취소</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<div id="secondModal" class="modal fade" tabindex="-1" aria-labelledby="dark-header-modalLabel" aria-modal="true" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header modal-colored-header bg-secondary">
				<h4 class="modal-title" id="dark-header-modalLabel2"></h4>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
			</div>

			<div class="modal-body" id="cdBody">
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-dark" id="cmcdFoot2"></button>
				<button type="button" class="btn btn-light" data-bs-dismiss="modal">취소</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<script type="text/javascript">
var header = '${_csrf.headerName}';
var token =  '${_csrf.token}';

$(function(){

	// 테이블 안에 들어있는 tr row를 눌렀을때 발생하는 이벤트
	$("#mainCont").on("click", "#mainTr", function(){
	 	var cdTypeId = $(this).data("cdtypeid");

	 	var cdTypeData = {
	 		"cdTypeId" : cdTypeId
	 	}
	 	codeInfo(cdTypeData);
	});

	// mainCont 안에 tbody안에 버튼 클릭했을때 발생하는 이벤트
	$("#mainCont").on("click", "button", function(event){
		event.stopPropagation();
		console.log("button클릭!");

		var check = $(this).val();

		if(check === 'addCodeType'){//코드 그룹 등록
			$("#dark-header-modalLabel").text("코드그룹 등록")

			var str = "";
			str += `
				<div class="form-group mb-3">
					<label class="form-label">코드 유형ID</label>
					<input type="text" name="cdTypeId" id="cdTypeId" class="form-control" placeholder="코드 유형ID를 입력해주세요"/>
				</div>
				<div class="form-group mb-3">
					<label class="form-label">코드 유형명</label>
					<input type="text" name="cdTypeNm" id="cdTypeNm" class="form-control" placeholder="코드 유형을 입력해 주세요"/>
				</div>
				`;

			$("#cmcdBody").html(str);
			$("#cmcdFoot").text("등록");

			$("#cmcdFoot").attr("id", "codeTypeAddBtn");
			$("#codeTypeUpBtn").attr("id", "codeTypeAddBtn");
			//$("#cmcdFoot").val("코드그룹등록");

			$("#codeTypeAddBtn").off("click").on("click", function(){
				let cdTypeId = $("#cdTypeId").val();
				let cdTypeNm = $("#cdTypeNm").val();

				data = {
					"cdTypeId" : cdTypeId,
					"cdTypeNm" : cdTypeNm
				}

				codeTypeInsert(data);
			})

		} else if(check === 'modiCodeType'){//코드 그룹 수정
			var firstTd = $(this).parents("tr").find("#firstTd");
			var secondTd = $(this).parents("tr").find("#secondTd");
			var firstTdText = firstTd[0].innerText;
			var secondTdText = secondTd[0].children[0].innerText;

			$("#dark-header-modalLabel").text("코드그룹 수정")

			var str = "";
			str += `
				<div class="form-group mb-3">
					<label class="form-label">코드 유형ID</label>
					<input type="text" name="cdTypeId" id="cdTypeId" value="`+firstTdText+`" class="form-control" style="background-color:lightgray" readonly/>
				</div>
				<div class="form-group mb-3">
					<label class="form-label">코드 유형명</label>
					<input type="text" name="cdTypeNm" id="cdTypeNm" value="`+secondTdText+`" class="form-control" placeholder="코드 유형을 입력해 주세요"/>
				</div>
				<div class="form-group mb-3">
				<label class="form-label">사용 여부</label>
				<select id="cdTUseYn" name="cdTUseYn" class="form-select">
					<option value="Y">Y</option>
					<option value="N">N</option>
				</select>
				</div>
				`;

			$("#cmcdBody").html(str)
			$("#cmcdFoot").text("수정")

			$("#cmcdFoot").attr("id", "codeTypeUpBtn");
			$("#codeTypeAddBtn").attr("id", "codeTypeUpBtn");
			//$("#cmcdFoot").val("코드그룹수정");

			//코드그룹 수정 파트
			$("#codeTypeUpBtn").off("click").on("click", function(){
				let cdTypeId = $("#cdTypeId").val();
				let cdTypeNm = $("#cdTypeNm").val();
				let cdTUseYn = $("#cdTUseYn").val();

				data = {
					"cdTypeId" : cdTypeId,
					"cdTypeNm" : cdTypeNm,
					"cdTUseYn" : cdTUseYn
				}

				codeTypeUpdate(data);
			})

		} else if(check === 'addCode'){//코드 등록
			var cdTypeId = $("#cdTypeId").val();

			$("#dark-header-modalLabel2").text("코드등록")

			var str = "";
			str += `
				<div class="form-group mb-3">
					<label class="form-label">코드 유형ID</label>
					<input type="text" name="cdTypeId" id="cdTypeId" value="`+cdTypeId+`" class="form-control" style="background-color:lightgray" readonly/>
				</div>
				<div class="form-group mb-3">
					<label class="form-label">코드명</label>
					<input type="text" name="cdNm" id="cdNm" class="form-control" placeholder="코드명을 입력해 주세요"/>
				</div>
				<div class="form-group mb-3">
					<label class="form-label">코드 설명</label>
					<textarea rows="3" id="cdExpln" name="cdExpln" class="form-control" placeholder="코드 설명을 해주세요"></textarea>
				</div>
				`;

			$("#cdBody").html(str);
			$("#cmcdFoot2").text("등록");

			$("#cmcdFoot2").attr("id", "codeAddBtn");
			$("#codeUpBtn").attr("id", "codeAddBtn");
			//$("#cmcdFoot").val("코드등록");

			$("#codeAddBtn").off("click").on("click", function(){
				let cdVl = $("#codeNo").val();
				let cdTypeId = $("#cdTypeId").val();
				let cdNm = $("#cdNm").val();
				let cdExpln = $("#cdExpln").val();

				console.log("cdVl : " + cdVl);

				if(cdVl == 0){
					data = {
						"cdTypeId" : cdTypeId,
						"cdVl" : 1,
						"cdNm" : cdNm,
						"cdExpln" : cdExpln
					}

					console.log("noneCodeInsert");

					noneCodeInsert(data);

				}else{
					data = {
						"cdTypeId" : cdTypeId,
						"cdNm" : cdNm,
						"cdExpln" : cdExpln
					}

					console.log("codeInsert");

					codeInsert(data);
				}
			})

		} else if(check === 'modiCode'){//코드 수정

			var codevl = $(this).parents("tr").find("#codevl");
			var codeName = $(this).parents("tr").find("#codeName");
			var codecn = $(this).parents("tr").find("#codecn");

			var codevlText = codevl[0].childNodes[0].data;		//내가 누른 버튼이 속한 부모 td에서 가져온 코드값
			var codeNameText = codeName[0].childNodes[0].data;	//내가 누른 버튼이 속한 부모 td에서 가져온 코드명
			var codecnText = codecn[0].children[0].innerText;	//내가 누른 버튼이 속한 부모 td에서 가져온 코드 설명
			var cdTypeId = $("#cdTypeId").val();

			$("#dark-header-modalLabel2").text("코드수정")

			var str = "";
			str += `
				<div class="form-group mb-3">
					<label class="form-label">코드 유형ID</label>
					<input type="text" name="cdTypeId" id="cdTypeId2" value="`+cdTypeId+`" class="form-control" style="background-color:lightgray" readonly/>
				</div>
				<div class="form-group mb-3">
				<label class="form-label">코드값</label>
				<input type="text" name="cdVl" id="cdVl" class="form-control" value="`+codevlText+`" style="background-color:lightgray" readonly/>
				</div>
				<div class="form-group mb-3">
					<label class="form-label">코드명</label>
					<input type="text" name="cdNm" id="cdNm" class="form-control" value="`+codeNameText+`"/>
				</div>
				<div class="form-group mb-3">
				<label class="form-label">사용 여부</label>
				<select id="cdCUseYn2" name="cdCUseYn" class="form-select">
					<option value="Y">Y</option>
					<option value="N">N</option>
				</select>
				</div>
				<div class="form-group mb-3">
					<label class="form-label">코드 설명</label>
					<textarea rows="3" id="cdExpln" name="cdExpln" class="form-control" placeholder="코드 설명을 해주세요">`+codecnText+`</textarea>
				</div>
				`;

			$("#cdBody").html(str);
			$("#cmcdFoot2").text("수정");

			$("#cmcdFoot2").attr("id", "codeUpBtn");
			$("#codeAddBtn").attr("id", "codeUpBtn");
			//$("#cmcdFoot").val("코드수정");

			$("#codeUpBtn").off("click").on("click", function(){
				let cdTypeId = $("#cdTypeId2").val();
				let cdVl = $("#cdVl").val();
				let cdNm = $("#cdNm").val();
				let cdCUseYn = $("#cdCUseYn2").val();
				let cdExpln = $("#cdExpln").val();

				data = {
					"cdTypeId" : cdTypeId,
					"cdVl" : cdVl,
					"cdNm" : cdNm,
					"cdCUseYn" : cdCUseYn,
					"cdExpln" : cdExpln
				};

				codeUpdate(data);
			})
		}

	});
})

//코드 그룹 비동기 화면
function cmcdList(){
	$.ajax({
		url : "/emp/cmcode/cmcdList",
		type : "get",
		dataType : "json",
		success : function(res){
			$('#firstModal').modal('hide');
			var str = "";

			str +=`
				<table class="table mTb">
				<thead class="table-secondary">
					<tr>
						<th style="text-align: center;" colspan="3" class="p-2">코드 그룹</th>
					</tr>
					<tr>
						<th class="p-2" style="width:100px">코드 유형ID</th>
						<th class="p-2" style="width:80px">사용여부</th>
						<th class="p-2">코드 유형명</th>
					</tr>
				</thead>
				<tbody class="tbBody">`

				if(res.length == 0){
					str += `
						<tr>
							<td class="p-2" colspan="2">조회할 그룹이 없습니다.</td>
						</tr>`
				}else{
					for(var i=0; i<res.length;i++){
						str +=`
							<tr id="mainTr" data-cdtypeid="\${res[i].cdTypeId }">
								<td id="firstTd" class="p-2">\${res[i].cdTypeId }</td>
								<td class="p-2">\${res[i].cdTUseYn }</td>
								<td id="secondTd" class="impolTd p-2">
									<font>\${res[i].cdTypeNm }</font>
									<div>
										<button value="modiCodeType" class="btn btn-secondary btn-sm mainBtn" data-bs-toggle="modal" data-bs-target="#firstModal">수정</button>
		    						</div>
								</td>
							</tr>`
					}
				}
			str +=`
				</tbody>
			</table>
			`

			$("#firstBox").html(str);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

//코드 목록 비동기 화면
function codeInfo(cdTypeData){

	$.ajax({
		url:"/emp/cmcode/codelist",
		type:"get",
		data:cdTypeData,
		dataType:"json",
		success:function(res){
			$('#secondModal').modal('hide');

			var str = `
				<input type="hidden" id="cdTypeId" name="cdTypeId" value="\${res[0].cdTypeId}"/>
				<input type="hidden" id="codeNo" value="\${res[0].cdVl}"/>
				<table class="table mTb">
				<thead class="table-secondary">
					<tr>
						<th style="text-align: center;" class="p-2" colspan="4">코드 목록</th>
					</tr>
					<tr>
						<th class="p-2" style="width:80px">코드값</th>
						<th class="p-2" style="width:80px">사용여부</th>
						<th class="p-2" style="width:100px">코드명</th>
						<th class="p-2">코드 설명</th>
					</tr>
				</thead>
				<tbody class="tbBody">`

			if(res[0].cdVl == 0){
				str += `
					<tr>
						<td colspan="3">조회할 코드가 없습니다.</td>
					</tr>`
			}else{
				for(var i=0; i<res.length; i++){
					str += `
						<tr>
							<td id="codevl" class="p-2" style="width:8px">\${res[i].cdVl}</td>
							<td id="cdCUseYn" class="p-2" style="width:80px">\${res[i].cdCUseYn}</td>
							<td id="codeName" class="p-2" style="width:100px">\${res[i].cdNm}</td>
							<td id="codecn" class="impolTd p-2">
								<font>\${res[i].cdExpln}</font>
								<div>
									<button class="btn btn-secondary btn-sm mainBtn" value="modiCode" data-bs-toggle="modal" data-bs-target="#secondModal">수정</button>
	    						</div>
							</td>
						<tr>`
				}
			}

			str +=	`
				</tbody>
			</table>`

			$("#secondBox").html(str);
		},
		error:function(xhr){

		}
	})
}

function codeTypeInsert(data){

	$.ajax({
		url : "/emp/cmcode/codeTypeInsert",
		type : 'post',
		contentType : "application/json;charset=utf-8",
		beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
		},
		dataType : 'text',
		data : JSON.stringify(data),
		success : function(res){

			if(res == "아이디"){
				alert("유형 아이디가 이미 존재합니다.");
				$('#firstModal').modal('hide');
			}else if(res == "이름"){
				alert("코드 유형명이 이미 존재합니다.")
				$('#firstModal').modal('hide');
			}else if(res == "성공"){
				cmcdList();
			}else{
				alert("등록에 실패했습니다.")
			}
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function codeTypeUpdate(data){

	$.ajax({
		url : "/emp/cmcode/codeTypeUpdate",
		type : 'post',
		contentType : "application/json;charset=utf-8",
		beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
		},
		dataType : 'text',
		data : JSON.stringify(data),
		success : function(res){
			if(res == "이름"){
				alert("코드 유형명이 이미 존재합니다.");
				$('#firstModal').modal('hide');
			}else{
				cmcdList();
			}
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function codeInsert(data){

	$.ajax({
		url : "/emp/cmcode/codeInsert",
		type : 'post',
		contentType : "application/json;charset=utf-8",
		beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
		},
		dataType : 'text',
		data : JSON.stringify(data),
		success : function(res){

			if(res == "중복"){
				alert("코드명이 이미 존재합니다.");
				$('#secondModal').modal('hide');
			}else if(res == "성공"){
				cdTypeId = data["cdTypeId"];

				cdTypeData = {
					"cdTypeId" : cdTypeId
				};

				codeInfo(cdTypeData);
			}else{
				alert("등록에 실패했습니다.")
			}
		},
		error : function(xhr){
			alert("상태코드 : " + xhr.status);
		}
	})
}

function noneCodeInsert(data){

	$.ajax({
		url : "/emp/cmcode/noneCodeInsert",
		type : 'post',
		contentType : "application/json;charset=utf-8",
		beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
		},
		dataType : 'text',
		data : JSON.stringify(data),
		success : function(res){

			if(res == "중복"){
				alert("코드명이 이미 존재합니다.");
				$('#secondModal').modal('hide');
			}else if(res == "성공"){
				cdTypeId = data["cdTypeId"];

				cdTypeData = {
					"cdTypeId" : cdTypeId
				};

				codeInfo(cdTypeData);
			}else{
				alert("등록에 실패했습니다.")
			}
		},
		error : function(xhr){
			alert("상태코드 : " + xhr.status);
		}
	})
}

function codeUpdate(data){

	$.ajax({
		url : "/emp/cmcode/codeUpdate",
		type : 'post',
		contentType : "application/json;charset=utf-8",
		beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
		},
		dataType : 'text',
		data : JSON.stringify(data),
		success : function(res){

			if(res == "중복"){
				alert("코드명이 이미 존재합니다.");
				$('#secondModal').modal('hide');
			}else{
				cdTypeId = data["cdTypeId"];

				cdTypeData = {
					"cdTypeId" : cdTypeId
				};

				codeInfo(cdTypeData);
			}
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}
</script>
</body>
