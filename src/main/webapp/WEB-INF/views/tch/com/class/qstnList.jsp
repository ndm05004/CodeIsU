<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	.ImgStuNoQstnDtBox {
		margin-bottom: 20px;
		height: 40px;
	}
	.ImgStuNoQstnDtBox .stuNoQstnDt{
		top: 1px;
		left: 50px;

	}
	.ImgStuNoQstnDtBox .stuNoQstnDt .stuNo{
		font-size: 14px;
		font-weight: 600px;
	}
	.ImgStuNoQstnDtBox .stuNoQstnDt .qstnDt{
		font-size: 12px;
	}

	.dropdown{
		top : 0px;
		right: 0px;
	}
	.style-none{
		border: none;
		background-color: white;
		color:none;
		color: white;
	}
	.cardHeight{
		height: 95.990px;
	}
	.topBtn{
		cursor: pointer;
	}
	.topBtn:hover {
		color: #3246C4; /* 마우스 오버시 텍스트 색상 변경 */
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
<!-- 강사 - 질문답변 리스트 -->
<div class="">
  <h4 class="menu_title">${temp_title}</h4>
	<div class="mb-3 mt-4">
		<span class="me-2 text-primary topBtn" id="allBtn">전체</span>
		<span class="me-2  text-muted topBtn" id="asnNoBtn">미답변</span>
		<span class="text-muted topBtn" id="ansYesBtn">답변완료</span>
	</div>
	<div class="" id="qstnListContainer"></div>

</div>
<script>
	var sbjctCd = "${sbjctCd}";
	var qstnListContainer = document.querySelector("#qstnListContainer");
	qstnLIst("/tch/class/qstn/qstnlist/all?sbjctCd=" + sbjctCd)

	// 전체 클릭시
	var allBtn = document.querySelector("#allBtn");
	allBtn.addEventListener("click",function(){
		qstnLIst("/tch/class/qstn/qstnlist/all?sbjctCd=" + sbjctCd)
		if($("#allBtn").hasClass("text-muted")){
			$("#allBtn").removeClass("text-muted").addClass("text-primary");
		}
		if($("#asnNoBtn").hasClass("text-primary")){
			$("#asnNoBtn").removeClass("text-primary").addClass("text-muted");
		}
		if($("#ansYesBtn").hasClass("text-primary")){
			$("#ansYesBtn").removeClass("text-primary").addClass("text-muted");
		}
		
	})
	// 미답변 클릭시
	var asnNoBtn = document.querySelector("#asnNoBtn");
	asnNoBtn.addEventListener("click",function(){
		qstnLIst("/tch/class/qstn/qstnlist/ansno?sbjctCd=" + sbjctCd)
		if($("#asnNoBtn").hasClass("text-muted")){
			$("#asnNoBtn").removeClass("text-muted").addClass("text-primary");
		}
		if($("#allBtn").hasClass("text-primary")){
			$("#allBtn").removeClass("text-primary").addClass("text-muted");
		}
		if($("#ansYesBtn").hasClass("text-primary")){
			$("#ansYesBtn").removeClass("text-primary").addClass("text-muted");
		}
	})
	// 답변 완료 클릭시
	var ansYesBtn = document.querySelector("#ansYesBtn");
	ansYesBtn.addEventListener("click",function(){
		qstnLIst("/tch/class/qstn/qstnlist/ansyes?sbjctCd=" + sbjctCd)
		if($("#ansYesBtn").hasClass("text-muted")){
			$("#ansYesBtn").removeClass("text-muted").addClass("text-primary");
		}
		if($("#allBtn").hasClass("text-primary")){
			$("#allBtn").removeClass("text-primary").addClass("text-muted");
		}
		if($("#asnNoBtn").hasClass("text-primary")){
			$("#asnNoBtn").removeClass("text-primary").addClass("text-muted");
		}
	})

	function qstnLIst(urlStr){
		console.log("체킁" , sbjctCd);
		$.ajax({
			url: urlStr,
			method: 'get',
			dataType: 'json',
			success: function(res) {
				console.log("res",res);
				var qstnListStr = "";
				if(res == null || res.length == 0){
					qstnListStr += `<div>` ;
					qstnListStr += `    <p>조회하실 게시물이 존재하지 않습니다.</p>`;
					qstnListStr += `</div>`;
				} else {
					res.forEach(function(qstn) {
						var qstnAns = "";
						if(!qstn.qstnAns){
							qstnAns = "미답변"
						} else {
							qstnAns = "답변완료"
						}
						qstnListStr += '<div class="card qstnListCard" onclick="qstnselect('+ qstn.qstnNo +')" style="cursor: pointer;">';
						qstnListStr += `    <div class="card-body collapse show">`
						qstnListStr += `		<div class="row">`
						qstnListStr += `			<div class="col-1 d-flex align-items-center"><img src=\${qstn.stuProfile} class="avatar avatar-sm rounded-circle me-2" width="40" height="40"></div>`
						qstnListStr += `			<div class="col-2 fs-6">`
						qstnListStr += `				<div>`
						qstnListStr += 						qstn.stuNm;
						qstnListStr += `				</div>`
						qstnListStr += `				<div class="text-muted fs-6">`
						qstnListStr += 						qstn.qstnDt;
						qstnListStr += `				</div>`
						qstnListStr += `			</div>`
						qstnListStr += `			<div class="col-7 font-weight-bold d-flex align-items-center">`
						qstnListStr += 					qstn.qstnTtl
						qstnListStr += `			</div>`
						qstnListStr += `			<div class="col-2 position-relative">`
            qstnListStr += `        <div class="text-muted position-absolute top-50 end-0 translate-middle-y" style="padding-right: 15px;">`
						qstnListStr += 					  qstnAns
						qstnListStr += `			  </div>`
						qstnListStr += `			</div>`
						qstnListStr += `		</div>`

						qstnListStr += `    </div>`
						qstnListStr += `</div>`

					})
				}
				qstnListContainer.innerHTML = qstnListStr;
			},
			error: function(xhr, status, error) {
			// 요청이 실패했을 때 처리할 코드 작성
			console.error('Request failed. Status:', status);
			}
		});

	}
	

	function sliceText(text, maxLength) {
		// 줄바꿈 문자를 <br> 태그로 변경
		if (text.length > maxLength) {
			return text.slice(0, maxLength) + '...';
		}
		return text;
	}

	// 수정 삭제 상세보기 폼
	function qstnselect (qstnNo){
		location.href = "/tch/class/qstn/selectform?qstnNo=" + qstnNo + "&sbjctCd=" + sbjctCd;
	}

</script>