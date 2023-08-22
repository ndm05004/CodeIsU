<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<body>
<h1>수업 상세보기 페이지입니다.</h1>
<div id="container">
	<div class="col-md-12" style="text-align: center">
		<label>수업이름</label><h1>${sbjctVO.sbjctNm }</h1>
	</div>
	<div class="row justify-content-center">
		<div class="col-md-4">
			<label>시작일</label><h1>${sbjctVO.sbjctBgng }</h1>
		</div>
		<div class="col-md-4">
			<label>종료일</label><h1>${sbjctVO.sbjctDdlb }</h1>
		</div>
		<div class="col-md-4">
			<label>시간대</label><h1>${sbjctVO.scduHr }</h1>
		</div>
	</div>
	<div class="row justify-content-center">
		<div class="col-md-6">
			<label>연수과정명</label><h1>${sbjctVO.svlfNm }</h1>
		</div>
		<div class="col-md-6">
			<label>담당 선생님</label><h1>${sbjctVO.userNm }</h1>
		</div>
	</div>
</div>
<div>
	<button type="button" id="sbjctUpBtn" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modifyModal">수정</button>
	<button type="button" id="sbjctDel" class="btn btn-secondary">삭제</button>
	<button type="button" id="sbjctList" class="btn btn-secondary">목록</button>
</div>

<div class="modal fade" tabindex="-1" style="display: none" id="modifyModal">
  <div class="modal-dialog modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">${sbjctVO.sbjctNm }</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="sbjctForm">
        	<div class="mb-3">
        		<label class="form-label">연수과정</label>
        		<input type="text" name="svlfNm" id="svlfNm" value="${sbjctVO.svlfNm }" class="form-control" readonly>
        		<input type="hidden" name="svlfNo" id="svlfNo" value="${sbjctVO.svlfNo }">
        	</div>

        	<div class="mb-3">
        		<label class="form-label">시간대</label>
        		<select id="scduHr" name="scduHr" class="form-select" aria-label="Default select example">
        			<option>--선택하세요--</option>
        			<option>오전</option>
        			<option>오후</option>
        		</select>
        	</div>

        	<div id="startAndEnd">
				<div class="mb-3">
					<label class="form-label">시작일</label>
					<input type="text" id="startDatepicker" class="form-control datepicker" placeholder="날짜를 선택하세요" />
				</div>
				<div class="mb-3">
					<label class="form-label">종료일</label>
					<input type="text" id="endDatepicker" class="form-control datepicker" placeholder="날짜를 선택하세요" />
				</div>
			</div>

        	<div class="mb-3">
        		<label class="form-label">수업명</label>
        		<input id="sbjctNm" name="sbjctNm" type="text" value="${sbjctVO.sbjctNm }" class="form-control"/>
        	</div>
        	<div class="mb-3" id="teachContainer">
        		<c:set value="${empNmList }" var="empNmList"/>
        		<label class="form-label">강사</label>
        		<select id="empNo" name="empNo" class="form-select" aria-label="Default select example">
        			<option>--선택하세요--</option>
        			<c:forEach items="${empNmList }" var="empNm">
	        			<option value="${empNm.empNo }">${empNm.userNm }</option>
        			</c:forEach>
        		</select>
        	</div>
        	<input type="hidden" id="sbjctCd" name="sbjctCd" value="${sbjctVO.sbjctCd }"/>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" id="modifyBtn" class="btn btn-secondary" data-bs-dismiss="modal">수정 완료</button>
        <button type="button" id="cencleBtn" class="btn btn-primary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
var header = '${_csrf.headerName}';
var token =  '${_csrf.token}';

$(function(){
	var modifyBtn = $("#modifyBtn");
	var sbjctDel = $("#sbjctDel");
	var sbjctList = $("#sbjctList");
	datepickerSet();

	modifyBtn.on("click", function(){

		let sbjctBgng = $("#startDatepicker").val();
		let sbjctDdlb = $("#endDatepicker").val();
		let scduHr = $("#scduHr").val();
		let sbjctNm = $("#sbjctNm").val();
		let empNo = $("#empNo").val();
		let sbjctCd = $("#sbjctCd").val();

		data = {
			sbjctBgng : sbjctBgng,
			sbjctDdlb : sbjctDdlb,
			scduHr : scduHr,
			sbjctNm : sbjctNm,
			empNo : empNo,
			sbjctCd : sbjctCd
		}

		$.ajax({
			url : "/emp/sbjct/sbjctUpdate",
		    type: 'post',
	    	contentType:"application/json;charset=utf-8",
	        beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token);
	        },
			dataType: 'text',
			data:JSON.stringify(data),
			success:function(res){
				location.reload();
			},
			error : function(xhr){
				alert("상태 : "+xhr.status);
			}
		})
	})

	sbjctDel.on("click",function(){
		location.href = "/emp/sbjct/sbjctDel?sbjctCd=${sbjctVO.sbjctCd }";
	})

	sbjctList.on("click",function(){
		location.href = "/emp/sbjct/sbjctList";
	})
})

$("#sbjctUpBtn").on("click", function(){
	let svlfNo = ${sbjctVO.svlfNo};
	var svlOlbj = {
		"svlfNo" : svlfNo
	}
	as(svlOlbj);

	$("#scduHr").on("change", function(){
		//시간대 변경 시 시작일, 종료일 초기화
		$("#startDatepicker").val("");
		$("#endDatepicker").val("");

		let svlfNo = "${sbjctVO.svlfNo}";
		let sbjctCd = $("#sbjctCd").val();
		let scduHr = $("#scduHr").val();


		var svlData = {
			"svlfNo" : svlfNo,
			"sbjctCd" : sbjctCd,
			"scduHr" : scduHr
		}
		sbjctTimeInfo2(svlData);

		$("#startDatepicker").on("change", function(){
			$("#endDatepicker").val("");

			$("#endDatepicker").on("change", function(){
				$("#empNo").val($("#empNo option:first").val());

				let startDate = $("#startDatepicker").val();
				let endDate = $("#endDatepicker").val();
				let teachName = "${sbjctVO.userNm }";

				var scduData = {
					"startDate" : startDate,
					"endDate" : endDate,
					"teachName" : teachName
				}

				scduInfo(scduData);
			})
		})
	})
});

function as(obj){
	$.ajax({
		url :"/emp/sbjct/svlfTime",
		type:"get",
		data: obj,
		dataType:"json",
		success:function(res){

			var str= `
	        	<div class="mb-3">
		    		<label class="form-label">시작일</label>
		    		<input type="text" name="sbjctBgng" id="startDatepicker" class="form-control datepicker" placeholder="날짜를 선택하세요"/>
		    	</div>
		    	<div class="mb-3">
		    		<label class="form-label">종료일</label>
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

function sbjctTimeInfo2(svlData){
	console.log(svlData);

	$.ajax({
		url:"/emp/sbjct/sbjcttimeinfo2",
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
		url:"/emp/sbjct/scduinfo2",
		type:"get",
		data:scduData,
		dataType:"json",
		success:function(res){
			console.log("res", res);

			var str = `
				<label class="form-label">강사</label>
				<select id="empNo" name="empNo" class="form-select" aria-label="Default select example">
					<option>--선택하세요--</option>
					`

					for(var i=0; i<res.length; i++){
						str += `<option value=\${res[i].empNo}>\${res[i].userNm}</option>`
					}
			str += `</select>`;

			$("#teachContainer").html(str);

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
</script>
</body>
