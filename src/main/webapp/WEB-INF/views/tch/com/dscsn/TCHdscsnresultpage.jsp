<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
</style>

	<!-- 이름 상담 상태들어가는 div -->
	<div class="row align-items-end" style="height: 45px">
		<div class="col-3">
			<h3>${stuNm }</h3>
		</div>
		<div class="col-9" style="text-align: right;">
			<h5 style="margin: 0;">${dscsnYn }</h5>
		</div>
	</div>

	<!-- 상담결과창 입력하는 div -->
	<div class="row " style="height: 285px">
		<div class="col" style="height: 100px; padding: 0;">
			<table class="table">
				<thead class="table-secondary">
					<tr>
						<th style="text-align: center;" colspan="5" class="p-2">상담 내용</th>
					</tr>
				</thead>
				<tbody id="dscsnBody">
					<tr>
						<td style="padding: 0;">
							<c:if test="${not empty dscsnRslt }">
								<textarea id="dscsnResult" rows="10" style="width: 100%; height: 100%;">${dscsnRslt }</textarea>
							</c:if>
							<c:if test="${empty dscsnRslt }">
								<textarea id="dscsnResult" rows="10" style="width: 100%; height: 100%;" placeholder="상담 결과를 작성해주세요"></textarea>
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<!-- 결과 등록 버튼 올 div -->
	<div class="row align-items-center" style="height: 40px">
		<div class="col"  style="text-align: right; padding: 0;">
			<c:if test="${not empty dscsnRslt }">
				<button type="button" id="resultAddBtn" class="btn btn-dark btn-sm" style="width: 80px;">결과 수정</button>
			</c:if>
			<c:if test="${empty dscsnRslt }">
				<button type="button" id="resultAddBtn" class="btn btn-dark btn-sm" style="width: 80px;">결과 등록</button>
			</c:if>
		</div>
	</div>

	<!-- 이력서 버튼 올 div -->
	<div class="row align-items-center" style="height: 40px">
		<div class="col" style="text-align: right; padding: 0;">
			<button id="resuBtn" onclick="javascript:goPreview('${resumeNo}')" type="button" class="btn btn-dark btn-sm" style="width: 80px;">이력서</button>
		</div>
	</div>

	<!-- 상담자의 지금까지 모든 상담 목록 -->
	<div class="row" style="height: 300px">
		<div class="col" style="padding: 0;">
			<table class="table">
				<thead class="table-secondary">
					<tr>
						<th style="text-align: center;" colspan="5" class="p-1">상담 목록</th>
					</tr>
					<tr>
						<th class="p-1">분류</th>
						<th class="p-1">상담일</th>
						<th class="p-1">상담원</th>
						<th class="p-1">상담자</th>
						<th class="p-1">상담여부</th>
					</tr>
				</thead>
				<tbody id="listBody">
				</tbody>
			</table>
		</div>
	</div>

<script>
const stuName = "${stuNm }";
const dscsnNo = ${dscsnNo };
const dscsYn = "${dscsnYn }";

var header = '${_csrf.headerName}';
var token =  '${_csrf.token}';

$(function(){
	myDscsnList(stuName);

	$("#resultAddBtn").on("click", function(){
		let result = $("#dscsnResult").val()

		let currentDate = new Date();
	    let year = currentDate.getFullYear();
	    let month = String(currentDate.getMonth() + 1).padStart(2, '0');
	    let day = String(currentDate.getDate()).padStart(2, '0');

	    let formattedDate = year + '-' + month + '-' + day;

		data = {
			"dscsnNo" : dscsnNo,
			"dscsnRslt" : result,
			"dscsnRsltDt" : formattedDate
		}

		resultInsert(data);

	})

	$(document).keydown(function(event) {
	     if (event.keyCode == '220') {
	    	 $("#dscsnResult").text(`1. 이력서에 대해 첨삭지도 하였음. 개인적인 가치와 철학이 잘 드러나는 좋은 이력서지만, 이를 통해 어떤 직무나 회사에 지원하고자 하는지 명확하게 연결되지 않음. 지원하는 직무나 회사에 어떻게 기여할 수 있는지를 구체적으로 작성하도록 지도

2. 취업 장소에 대한 고민을 가지고 있었음: 서울과 고향인 대전 사이에서 선택해야 합니다. 다음 세 가지 주요 요소에 대해 고민해보는 것을 추천하였음 :
삶의 질: 서울의 다양한 문화적 기회와 대전의 가족 친화적인 환경 간의 균형을 고려해보았습니다.
직무 관련 기회: 서울의 IT나 금융 산업과 대전의 정부 지원 기관 등 각 지역의 산업 특성을 고려.
장기적인 목표: 서울의 대기업에서의 경력 혹은 대전에서의 안정적인 직장 생활 등 학생의 장기적인 목표를 고려
결정은 쉽지 않겠지만, 이런 요소들을 고려하면서 천천히 결정할 것을 권함. 가장 중요한 것은 학생의 행복과 직업적 목표 달성이라는 점을 강조`)
	     }
	})

})

function myDscsnList(stuName){
	$.ajax({
		url : "/tch/dscsn/myDscsnList",
		type : "get",
		data : { "stuName" : stuName },
		dataType : "json",
		success : function(res){
			str = "";

			if(res.length == 0){
				str += `
					<tr>
						<td colspan="5" class="p-2" style="text-align: center;">상담한 내역이 없습니다.</td>
					</tr>
				`
			}else{
				if(res.length < 5){
					for(let i=0; i<res.length; i++){
						str += `
							<tr>
								<td class="p-2">\${res[i].dscsnCd}</td>
								<td class="p-2">\${res[i].dscsnDt}</td>
								<td class="p-2">\${res[i].empNo}</td>
								<td class="p-2">\${res[i].stuNo}</td>
								<td class="p-2">\${res[i].dscsnYn}</td>
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
								<td class="p-2">\${res[i].dscsnYn}</td>
							</tr>`
					}
				}
			}

			$("#listBody").html(str);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function resultInsert(data){

	$.ajax({
		url : "/tch/dscsn/resultInsert",
		type : "post",
		contentType : "application/json;charset=utf-8",
		beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
		},
		dataType : 'text',
		data : JSON.stringify(data),
		success : function(res){

			if(res == "성공"){
				 Swal.fire({
	                    icon: 'success',
	                    title: '등록 성공',
	                    text: '결과가 정상적으로 등록되었습니다.',
	                }).then((result) => {
	                    if (result.isConfirmed) {
	                        location.href = "/tch/dscsn/dscsnBoard";
	                    }
	                });
			}else{
				alert("결과 등록에 실패했습니다.")
			}
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}
</script>

<script type="text/javascript"> <!-- 이력서 팝업링크 -->
function goPreview(resumeNo) { // 이력서 미리보기 팝업
    var popWidth = "970";
    var popHeight = "900";
    var posLeft = (screen.width) ? (screen.width - popWidth) / 2 : 0;
    var posTop = (screen.height) ? (screen.height - popHeight) / 2 : 0;
    var optionTxt = stringFormat("height={0},width={1},top={2},left={3}, toolbar=no, menubar=no, scrollbars=yes, resizable=no", popHeight, popWidth, posTop, posLeft);

    var url = "/resume/view?no=" + resumeNo;
    window.open(url, "이력서 미리보기", optionTxt);
}
function stringFormat(text) {
    if (arguments.length <= 1) return text;

    for (var i = 0; i <= arguments.length - 2; i++) {
        text = text.replace(new RegExp("\\{" + i + "\\}", "gi"), arguments[i + 1]);
    }

    return text;
}
</script>