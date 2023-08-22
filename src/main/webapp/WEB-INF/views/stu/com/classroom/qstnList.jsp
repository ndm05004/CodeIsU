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

    .menu_title {
      margin: 3px 0 15px;
      padding: 0 0 0 13px;
      background: url(/resources/img/h4.png) no-repeat 0 4px;
      font-size: 22px;
      font-weight: 700;
      color: #000;
    }

</style>
<input type="hidden" id="sbjctCd" value="${sbjctCd}">
<div class="">
	<h4 class="menu_title">${temp_title}</h4>
	<div class="row mb-2">
		<div class="col-5">
		</div>
			<div class="col text-end">
				<button type="button" class="btn btn-primary" id="createBtn">글쓰기</button>
			</div>
		</div>
	</div>
	<div class="accordion" id="qstnListContainer"></div>

</div>
<script>
	var sbjctCd = document.querySelector("#sbjctCd").value;
	var qstnListContainer = document.querySelector("#qstnListContainer");
	qstnLIst()

	var createBtn = document.querySelector("#createBtn");
	createBtn.addEventListener("click",function(){
		location.href = "/stu/classroom/qstn/insertform?sbjctCd=" + sbjctCd;
    })

	// 화면 생성
	var iNum = 1;
	function qstnLIst(){
		console.log("체킁");
		$.ajax({
			url: "/stu/classroom/qstn/qstnList",
			method: 'get',
			data : { "sbjctCd": sbjctCd },
			dataType: 'json',
			success: function(res) {
				console.log("res",res);

				var qstnList = res.qstnList;
				var profile = res.profile;
				var qstnListStr = "";
				if(res == null || res.length == 0){
					qstnListStr += `<div>` ;
					qstnListStr += `    <p>조회하실 게시물이 존재하지 않습니다.</p>`;
					qstnListStr += `</div>`;
				} else {
					qstnList.forEach(function(qstn) {
						var qstnAns = "";
						if(!qstn.qstnAns){
							qstnAns = "미답변"
						} else {
							qstnAns = "답변완료"
						}
						qstnListStr += '<div class="card qstnListCard" onclick="qstnUpdate('+ qstn.qstnNo +')">';
						qstnListStr += `    <div class="card-body collapse show">`
						qstnListStr += `		<div class="row">`
						qstnListStr += `			<div class="col-1 d-flex align-items-center"><img src=\${profile} class="avatar avatar-sm rounded-circle me-2" width="40" height="40"></div>`
						qstnListStr += `			<div class="col-2 fs-6">`
						qstnListStr += `				<div>`
						qstnListStr += 						qstn.userNm;
						qstnListStr += `				</div>`
						qstnListStr += `				<div class="text-muted fs-6">`
						qstnListStr += 						qstn.qstnDt;
						qstnListStr += `				</div>`
						qstnListStr += `			</div>`
						qstnListStr += `			<div class="col-7 font-weight-bold d-flex align-items-center">`
						qstnListStr += 					qstn.qstnTtl
						qstnListStr += `			</div>`
						qstnListStr += `			<div class="col-2 position-relative">`
			            qstnListStr += `        		<div class="text-muted position-absolute top-50 end-0 translate-middle-y" style="padding-right: 15px;">`
						qstnListStr += 					  	qstnAns
						qstnListStr += `			  	</div>`
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

	// 수정 삭제
	function qstnUpdate (qstnNo){
		location.href = "/stu/classroom/qstn/selectform?qstnNo=" + qstnNo +"&sbjctCd=" + sbjctCd;
	}

</script>