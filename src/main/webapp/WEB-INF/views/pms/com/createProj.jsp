<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<style>

.lineClear {
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: normal;
    font-weight: normal;
    height: 50px;
    font-size: 15px;

}

.aplyClick{
	background-color: #FBFBFB;
}

.pbox {
	background-color: #f4f2f2;
}

#projExpln {
	background-color: #f0f2f5;
	margin-bottom: 0px;
}

#insertBtn {
	float: right;
    height: 40px;
    background: #465b8a;
    margin-bottom: -10px;
    font-size: 15px;
}
.btnStyle, #aplyBtn, #mcanBtn {
    background-color: #465b8a;
    color: white;
}
.mcanBtn , #cancleBtn, #cancleBtn2{
	border: 1px solid #465b8a;
}
.progress-bar{
	background-color: #D71923;
}
#mAplyCn, .inputColor{
	border:1px solid #f4f2f2;
}

#techChoice, #mTechChoice{
	text-align:left;
	border:1px solid #E6E3E2;
	height:40px;
	background-color: #f4f2f2;
}

#cAplyBtn {
	width: 55px;
	height: 35px;
	line-height: 7px;
	cursor: pointer;
    background: #465b8a;
    color: white;
    border: none;
    font-size: 15px;
}

.nullStyle{
	text-align: center;
	font-weight: 500;
	margin-top: 165px;

}

textarea {
  	resize: none;
}
/* 프로젝트내용 마우스오버 */
.hover-text-container {
 	position: relative;
}

.hover-text {
  display: none;
  position: absolute;
  width: 970px;
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

label.necessary::after {
    content: "*";
    color: red;
    margin-left: 4px;
}

/* 무한 스크롤 시작 영역 */
.scroll-Wrap {
	max-height: 550px;
	overflow-y: auto;
	direction: ltr;
	scrollbar-color: #d4aa70 #e4e4e4;
}

.scroll-Wrap::-webkit-scrollbar {
 	width: 10px;  /* 세로축 스크롤바 폭 너비 */
    height: 20px;  /* 가로축 스크롤바 폭 너비 */
}

.scroll-Wrap::-webkit-scrollbar-track {
	background-color: #e4e4e4;
	border-radius: 100px;
}

.scroll-Wrap::-webkit-scrollbar-thumb {
	border-radius: 50px;
	border-left: 0;
	border-right: 0;
	background-color: #CEC8C7;
}

</style>

<!-- 검색창 -->


<!-- 프로젝트 생성 버튼 -->
<div class="d-flex justify-content-end" id="insertBtnClass">
</div>
<div class="table-responsive ms-1"><br>

<!-- 프로젝트 리스트 -->
<table class="table align-items-center mb-0" id="projCreate">
</table>
</div>


<!-- 프로젝트 생성  Modal 시작-->
<div class="modal fade" id="insertProjModal" role="dialog" aria-labelledby="insertProjModalLabel" aria-hidden="true">
  <div class="modal-dialog d-flex justify-content-center" role="document">
    <div class="modal-content" id="modalContent">
    </div>
  </div>
</div>
<!-- 프로젝트 생성  Modal 끝 -->


<script type="text/javascript">

var projNo;

var stuNo = "${userNo}";

const userVo = "${userVo}";

/* 무한 스크롤 함수 시작 */
var page = 1;

$(window).scroll(function() {
    if ($(window).scrollTop() == $(document).height() - $(window).height()) {
      console.log(++page);
    }
});
/* 무한 스크롤 함수 끝  */



//서버에서 발행된 헤더네임과 토큰갑사 저장
var header = '${_csrf.headerName}';
var token =  '${_csrf.token}';


//데이터 보내고 싶을 때 사용 , handleTextMessage로 전송
// 서버로 메세지 전달하는 함수
function sendMsg(msg) {
  if (!msg) {
    webSocket.send("연결성공");
    return;
  }
  webSocket.send(msg);
  console.log("msg : ", msg);
}

//날짜 수정
function convertDate(Cdate) {
  const year = Cdate.substring(0, 4);
  const month = Cdate.substring(4, 6);
  const day = Cdate.substring(6, 8);
  const formattedDate = year + "-" + month + "-" + day;
  return formattedDate;
}
//날짜 수정 하이픈 제거
function converDate2(Cdate){
	const formattedDate = Cdate.replaceAll("-", "");
	return formattedDate;
}

const autoComplete = () => {
	  $(document).keydown(function(event) {
		     if (event.keyCode == "220") {
		    	projAutoComplete();
		     } else if(event.keyCode == "221") {
		    	aplyAutoComplete();
		     }
		 })
	 }

	 const projAutoComplete = () => {
		 document.getElementById("mProjNm").value="AI+빅데이터+IOT";
		 document.getElementById("mProjExpln").value="모든 스택을 이용해 최고의 포트폴리오를 함께 만들어가실분들을 찾습니다.";
		 document.getElementById("mProjBgngDt").value="2023-08-17";
		 document.getElementById("mProjDdlnDt").value="2023-09-23";
	 }
	 const aplyAutoComplete = () => {
		 document.getElementById("mAplyCn").value=
			 " Spring, React, NodeJs을 잘 할 수 있고 프론트엔드, 백엔드 모두 수준급입니다." +
			 "매일 새벽 3시까지 코딩하다 지쳐 잠에 들 정도로 열심히 하고 있어요. 꼭 뽑아주세요!";
	 }


/* 프로젝트 생성된 리스트 */
function projList(type, search){
	let data = {
			projSttsCd:type,
			projNm:search
		}

    $.ajax({
      url: "/pms/projlist",
      type: "get",
      data: data,
	  contentType:"application/json;charset=utf-8",
      success:function(res){
    	  console.log("projcreate vo:",res);

    	  let count = 0;
    	  code = "";
    	  code +=
    		  `<nav class="shadow-none navbar border-0 d-flex me-4">



    		  <!-- <div class="container-fluid" style="justify-content:flex-end	;">
				    <a class="navbar-brand">제목</a>
				    <form class="d-flex"></form>
				      <input class="w-20 form-control me-2" id="titleSearch" type="search" placeholder="Search" aria-label="Search">
				      <button type="button" id="searchBtn"  class="btn btn-default mb-0 search">
						 <i class="fas fa-search" aria-hidden="true"></i>
					  </button>
				  </div> -->
				  <div class="container-fluid" style="justify-content:flex-end;">
				  <div class="col-3 d-flex justify-content-start">
				  <button type="button" class="btn btn-success btn-sm me-5 flex-start" id="insertBtn">프로젝트 생성</button>
				  </div>
				  <div class="col-5"></div>
				  <div class="col-4">
				  <div class="d-flex justify-content-end border rounded bg-white">
				  	<a class="navbar-brand ps-2 pt-2">제목</a>
				    <form class="d-flex"></form>
				      <input class="form-control me-2" id="titleSearch" type="search" placeholder="검색" aria-label="Search">
				      <button type="button" id="searchBtn" class="btn btn-default mb-0 search">
						 <i class="fas fa-search" aria-hidden="true"></i>
					  </button>
			      </div>
				  </div>
				  </div>
			  </nav>
    		  `;

    	  code += `
    		<nav class="nav mb-3 me-5 justify-content-end border-0" id="navWrap">
    		  <a class="stat nav-link text-muted navBtn active search" aria-current="page" href="#" data-value="">전체</a>
    		  <a class="stat nav-link text-muted navBtn search" href="#" data-value="P002-1">대기중</a>
    		  <a class="stat nav-link text-muted navBtn search" href="#" data-value="P002-2">진행중</a>
    		  <a class="stat nav-link text-muted navBtn search" href="#" data-value="P002-3">중단중</a>
    		  <a class="stat nav-link text-muted navBtn search" href="#" data-value="P002-4">완료</a>
    		</nav>
    	  `;
 		if(res.length == 0) {


 			$("#projCreate").html(code + "<p class='nullStyle border-0'>조회 되는 프로젝트가 없습니다.</p>");

 			if(!type){
				//alert("ppp");
				$(`a[data-value=""].navBtn`).css("border-bottom","2px solid #56726A");
			  }else {
				$(`a[data-value=\${type}].navBtn`).css("border-bottom","2px solid #56726A");
			 }

	    	$("#titleSearch").val(search);


		  } else {

    	  code += `<div class="scroll-Wrap border-0 ">`;
		  code += `<div class='d-flex justify-start-end border-0'>`;

    	  for(let i=0; i<res.length; i++){


    		  aplyYn(res[i].projNo);
			  let sys = new Date();

			  let projBgngDt = convertDate(res[i].projBgngDt)
    		  let projDdlnDt = convertDate(res[i].projDdlnDt)

    		  let lestDay = Date.parse(projDdlnDt) - sys;

			  if(lestDay < 0) {
 			      daysLeft = "프로젝트 종료";
			  } else {
			   	  daysLeft = Math.ceil(lestDay / (1000 * 60 * 60 * 24)) + " days left";
			  }

    	  code += `
    		  <div class="container card me-4 ms-3 mb-3 aplyClick" id="aplyClick" style="width: 65rem; background: #FBFBFB;" value="\${res[i].projNo}">

    			<div class="card-body" style="box-sizing: border-box; background: #FBFBFB;">
    				<div class="row">
	    				<div class="col-10">
	    					<h5 class="card-title fs-5 font-weight-bolder" style="height: 20px;">
	    						\${res[i].projNm}
	    					</h5>
		    				<p class="card-text fs-6 mt-1">
			    				\${projBgngDt} ~ \${projDdlnDt}
			    			</p>
	    				</div>
    					<div class="col-2">
    						<button type="button" class="btn btn-outline-secondary float-end p-2 fs-6 mb-0 mt-1 cAplyBtn" id="cAplyBtn" btnNo="\${res[i].projNo}">지원</button>
						</div>
					</div>
					<div class="hover-text-container mt-3">
    					<h6 class="card-subtitle mb-1 mt-2 lineClear">\${res[i].projExpln}</h6>

    					<!-- 마우스 오버시 보일 내용 -->
    					 <label class="hover-text card-subtitle mb-1 mt-2 ">\${res[i].projExpln}</label>
    				</div>
    				<div class="row">

					</div>
    				<div class="row mt-3">
	    				<div class="col-5">
	    					 <i class="fas fa-laptop-code fa-xs"></i>
							 <span class="fs-6 fw-bold lineClear2" id="projTech" >
							 \${res[i].projTech}</span>
						</div>
	    				<div class="col-3">
		    				<span class="card-text fs-6">
			    				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="me-1 bi bi-people-fill" viewBox="0 0 16 16">
			    				  <path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1H7Zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm-5.784 6A2.238 2.238 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.325 6.325 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1h4.216ZM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5Z"/>
			    				</svg>
		    					\${res[i].projTnope}명
		    				</span>
	    					<span class="fs-6 fw-bold" id="projStatus" > / \${res[i].projSttsCd}</span>
	    				</div>
	    				<div class="col-4">
	    				<div class="progress-wrapper">
    					<div class="progress-info">
    						<div class="progress-percentage">
    							<span class="fs-6 fw-bold">진행도 \${res[i].projSttr}%
    							<span class="w-45 mt-2 text-end text-xs daysLeft" style="float:right;">
	    							<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-stopwatch-fill" viewBox="0 0 16 16">
	    							  <path d="M6.5 0a.5.5 0 0 0 0 1H7v1.07A7.001 7.001 0 0 0 8 16a7 7 0 0 0 5.29-11.584.531.531 0 0 0 .013-.012l.354-.354.353.354a.5.5 0 1 0 .707-.707l-1.414-1.415a.5.5 0 1 0-.707.707l.354.354-.354.354a.717.717 0 0 0-.012.012A6.973 6.973 0 0 0 9 2.071V1h.5a.5.5 0 0 0 0-1h-3zm2 5.6V9a.5.5 0 0 1-.5.5H4.5a.5.5 0 0 1 0-1h3V5.6a.5.5 0 1 1 1 0z"/>
	    							</svg>
    							<span class="minMsg fs-6">\${daysLeft}</span>
    							</span>
    						</div>
    					</div>
    				</div>
    				<div class="progress" style="width: 100%; background:#dbdbdb;">
    					<div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: \${res[i].projSttr}%"></div>
    				</div>
    			</div>

	    				</div>
    				</div>

    		</div>
    	  `;

    	  count++;

    	  if(count % 1 === 0) {
    		  code += "</div><div class='d-flex justify-start-end' style='border:none;'>";
    	  }
		}

    	  code += "</div>";
    	  code += "</div>";

    	  $("#projCreate").html(code);
    	  $("#titleSearch").val(search);

    	  $(".minMsg").each(function(index,item){
			 if(item.innerHTML=="프로젝트 종료"){
				item.style.color="#D71923";
			 }
		  });

		  if(!type){
			//alert("ppp");
			$(`a[data-value=""].navBtn`).css("border-bottom","2px solid #56726A");
		  }else {
			$(`a[data-value=\${type}].navBtn`).css("border-bottom","2px solid #56726A");
		 }
  	} //res.length  else문 끝
      },
		error: function(xhr) {
		console.log("상태: " + xhr.status);
		},
		dataType: 'json'
	});

}

projList();


/* 프로젝트 소개 상세보기 */
/* $("#projCreate").on("click",".aplyClick",function(){
	 var projNo = $(".aplyClick").attr("value");

	 const detailModal = `
	 <div class="modal-header">
				<h5 class="modal-title font-weight-normal" id="insertProjModalLabel">프로젝트 상세보기</h5>
           </div>

           <div class="modal-body container">
             	<form>
                   <div class="row mb-2">
                       <div class="col-3 fs-6">프로젝트명</div>
                       <div class="col-9">
                         <input type="text" class=" pbox rounded form-control" id="projNm" style="height:40px;" disabled />
                       </div>
                   </div>

                   <div class="row mb-2">
                       <div class="col-3 fs-6" >프로젝트 소개</div>
                       <div class="col-9">
                     	  <p class="pbox rounded form-control" id="projExpln" disabled > </p>
                       </div>
				   </div>

                  <div class="row mb-2">
                     <div class="col-3 fs-6">프로젝트 기간</div>
                     <div class="col-9">
                    	 <input type="text" class="col-8 pbox rounded form-control" id="proDt" disabled />
                     </div>
				  </div>

                  <div class="row mb-2 ">
                     <div class="col-3 fs-6">필요 기술 스택</div>
                     <div class="col-9">
                   	  <input type="text" class="col-8 pbox rounded form-control" id="projTech2" disabled  />
                  	 </div>
                  </div>

				  <div class="modal-footer mt-3">
                   <button type="reset" class="btn bg mcanBtn" data-bs-dismiss="modal" id="mcanBtn">닫기</button>
                  </div>

				</form>
            </div>
	`





	$("#modalContent").html(detailModal);

	projDetail(projNo);
	$("#insertProjModal").modal("show");

})

function projDetail(projNo) {
	console.log("플젝번호 확인 : ", projNo)

	$.ajax({
		url: "/pms/detail",
		type: "post",
		data : projNo,
		dataType : "json",
		contentType : "application/json; charset=utf-8",
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success : function(res){
			console.log(res)
			$("#projNm").val(res.projNm)
			$("#projExpln").text(res.projExpln)
			$("#proDt").val(convertDate(res.projBgngDt) + " ~ " + convertDate(res.projDdlnDt))
			$("#projTech2").val(res.projTech)

		},
		error : function(xhr){
			alert(xhr.status);
		}
	})


} */

/* 검색, 프로젝트 상태 버튼 이벤트 */
$("#projCreate").on("click", ".search", function(){
	var status = $(this).data("value");
	var projNm = $("#titleSearch").val();

	console.log("status, projNm",status,projNm)
	projList(status, projNm);


})

//프로젝트 가입 또는 신청 여부 확인
function aplyYn(projNo){

	/* console.log("projNo:::::::", projNo) */
	$.ajax({
		url : "/pms/yn",
		type : "post",
		data : stuNo,
		dataType : "json",
		contentType : "application/json; charset=utf-8",
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success : function(res){
			/* console.log("가입 또는 신청 된 res : ", res); */

			let $aplyBtns=$(".cAplyBtn");
			$aplyBtns.show();

/*
			console.log("jQ1:", $aplyBtns);
			console.log("jQ2:", $aplyBtns[0]);
			console.log("jQ3:", $aplyBtns.eq(0)); */

	         for (let i = 0; i < res.length; i++) {
				for(let j=0; j < $aplyBtns.length; j++){
					if(res[i].projNo == $aplyBtns.eq(j).attr("btnNo")){
						$aplyBtns.eq(j).hide();
					}
				}
	         }
		},
		error : function(xhr){
			console.log(xhr.status);
		}
	})
}

/* 프로젝트 지원신청서 모달 */
$("#projCreate").on("click", "#cAplyBtn", function(){

		// 클릭된 아이콘이 속한 부모 요소인 .aplyClick 클래스를 찾음
	    var parent = $(this).closest('.aplyClick');

	 	 // 해당 부모 요소의 value 속성 값을 가져옴
	 	projNo = parent.attr("value");

		console.log("클릭한 projNo: ",projNo)


		const aplyModal = `
		<div class="modal-header">
        <h5 class="modal-title font-weight-normal" id="aplyModalLabel">프로젝트 지원</h5>
        </div>

      <div class="modal-body">
         <form>
          <h5 class="modal-title font-weight-normal mb-2" id="aplyModalLabel"></h5>

          <input type="hidden" id="aplyStuNo" value='${userNo}'/>
	      <label class="form-label fs-6 necessary" for="mAplyCn">자기소개</label>
          <textarea class="form-control mAplyCn mb-2 ps-2" id="mAplyCn" placeholder="나에 대해 소개해보세요."></textarea>
		  <label class="form-label fs-6 necessary" for="mAplyTech">보유기술</label>
	          <p class="form-control fs-6 mb-2 text-center" id="mAplyTech">
		          <input type="button" class="btn w-20 me-2" style="border: 1px solid #56726a;" value="Java">
		          <input type="button" class="btn w-20 me-2" style="border: 1px solid #56726a;" value="Js">
		          <input type="button" class="btn w-20 me-2" style="border: 1px solid #56726a;" value="Python">
		          <input type="button" class="btn w-20" style="border: 1px solid #56726a;" value="Oracle"><br>
		          <input type="button" class="btn w-20 me-2" style="border: 1px solid #56726a;" value="HTML">
		          <input type="button" class="btn w-20 me-2" style="border: 1px solid #56726a;" value="CSS">
		          <input type="button" class="btn w-20 me-2" style="border: 1px solid #56726a;" value="React">
		          <input type="button" class="btn w-20" style="border: 1px solid #56726a;" value="PHP">
			 	  <label class="form-control mb-2 ps-2" id="mTechChoice">
	         	  </label>
			 	</p>

	      <div class="modal-footer">
	        <button type="button" class="btn bg msubBtn " id="aplyBtn">지원하기</button>
	        <button type="reset" class="btn bg mcanBtn" data-bs-dismiss="modal" id="cancleBtn2">취소</button>
	      </div>
        </form>
      </div>
		`

		$("#modalContent").html(aplyModal);
		aplyTech()
		$("#insertProjModal").modal("show");
})


/* 지원신청서 기술 */
const aplyTech = () =>{
	$("#mAplyTech").on("click", "input[type='button']", function(){
		var tech = $(this).val();
		console.log("선택된 기술 스택 : ", tech);
		var techChoice = $("#mTechChoice").val(tech);


		// 이미 선택된 기술 스택인 경우 선택 해제
		if ($(this).hasClass("selected")) {  //hasClass 존재여부 확인
			  $(this).removeClass("selected");
			  techChoice.find("label[data-value='" + tech + "']").remove();
		}
		// 선택되지 않은 기술 스택인 경우 선택
		else {
			 $(this).addClass("selected");

			// 선택된 기술 스택 추가
			techChoice.append("<label data-value='" + tech + "'>" + " " + tech  + "</label>");
		}
})
}

/* 지원 신청 데이터  */
document.addEventListener("click", function (event) {

		if (event.target.id === "aplyBtn") {
			if (validateAplyForm()) {
				$.ajax({
					url: "/pms/project/userno",
					type: "post",
					dataType: "json",
					beforeSend: function (xhr) {
						xhr.setRequestHeader(header, token);
					},
					success: function (res) {
						console.log("res!!!!!!!!!: ", res);
						var stuNo = res.userNo;
						console.log("stuNo !!!! : ", stuNo);

						var userName = res.userNm;
						console.log("이름 가져오기 : ", userName);

						var userProfile = res.userProfile;

						var insertTime = new Date();
						var currentHour = insertTime.getHours();
						var currentMinute = insertTime.getMinutes();
						var formattedMinute =
							currentMinute < 10 ? "0" + currentMinute : currentMinute;
						var HourMinute = currentHour + ":" + formattedMinute;
						console.log("등록시간 ", HourMinute);

						var data = {
							aplyCn: $("#mAplyCn").val(),
							aplyTech: getSelectedAplyTech(),
							stuNo: $("#aplyStuNo").val(),
							projNo: projNo,
							applyDate: HourMinute
						};

						//서버로 보내기
						insertAply(data, userName, userProfile);


					}
				})
			}
		}
	})





/* $("#cancleBtn2").on("click", function(){
      	$("#mTechChoice").empty();
})
 */

/* 지원신청서에서 기술스택 클릭시 */
function getSelectedAplyTech(){

	console.log('getSelectedAplyTech' + '실행')

	var selectedTech = "";
	$("#mAplyTech input[type='button'].selected").each(function() {
		var tech = $(this).val();
		//db에 저장되는 값
		selectedTech += " " + tech;
	});

	console.log("selectedTech: ",selectedTech);
	return selectedTech;
}

/* 프로젝트 지원 신청 */
function insertAply(data, userName, userProfile) {
	console.log("지원신청서 data : ", data)

	var dtTime = data.applyDate;
	var aplyCn = data.aplyCn;

	$.ajax({
		url : "/pms/insertaply",
		type : "post",
		data : JSON.stringify(data),
		dataType : "text",
		contentType : "application/json; charset=utf-8",
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success : function(res) {

			Swal.fire(
      			  '지원 완료',
      			  '프로젝트 지원이 완료 되었습니다!',
      			  'success'
      		)
			projList();
			aplyList(stuNo);

	     	sendMsg(
	          `지원서,\${projNo},\${userName},\${userProfile},\${dtTime},프로젝트이름,프로젝트 지원,\${stuNo},\${aplyCn}`
	        );


			$("#insertProjModal").modal("hide");



		},
		error : function(xhr){
			console.log(xhr.status);
		}
	})
}


/* 프로젝트 등록 버튼  */
$("#projCreate").on("click","#insertBtn", function(){

	console.log("클릭됨")
	const projectModal = `
	      <div class="modal-header">
        <h5 class="modal-title font-weight-normal" id="insertProjModalLabel">프로젝트 생성</h5>
        </div>

      <div class="modal-body">
         <form>
	      <label class="form-label necessary" for="mProjNm">프로젝트명</label>
	      <input type="text" placeholder="10자 이하로 입력해주세요." class="form-control mb-2 ps-2 inputColor" id="mProjNm" name="projNm" style="border:1px solid #E6E3E2">
		  <label class="form-label necessary" for="mProjExpln">프로젝트 소개</label>
          <textarea class="form-control mb-2 ps-2 inputColor" id="mProjExpln" name="projExpln" placeholder="프로젝트에 대해 소개해주세요." style="border:1px solid #E6E3E2"></textarea>
		  <label class="form-label w-30 pt-2 necessary" for="mProjBgngDt">프로젝트 기간</label>
		  <div class="d-flex justify-content-start mb-2">
          	<input type="date" class="form-control ps-2 inputColor" id="mProjBgngDt" style="border:1px solid #E6E3E2">
		  	<span class="ps-1 pe-1 pt-2">~</span>
         	 <input type="date" class="form-control ps-2 inputColor" id="mProjDdlnDt" style="border:1px solid #E6E3E2">
		  </div>
	          <label class="form-label necessary" for="mProjTech">필요 기술 스택</label>
          <p class="form-control mb-2 text-center" id="mProjTech">
	          <input type="button" class="btn w-20 me-2" style="border: 1px solid #56726a;" value="Java">
	          <input type="button" class="btn w-20 me-2" style="border: 1px solid #56726a;" value="Js">
	          <input type="button" class="btn w-20 me-2" style="border: 1px solid #56726a;" value="Python">
	          <input type="button" class="btn w-20" style="border: 1px solid #56726a;" value="Oracle"><br>
	          <input type="button" class="btn w-20 me-2" style="border: 1px solid #56726a;" value="HTML">
	          <input type="button" class="btn w-20 me-2" style="border: 1px solid #56726a;" value="CSS">
	          <input type="button" class="btn w-20 me-2" style="border: 1px solid #56726a;" value="React">
	          <input type="button" class="btn w-20" style="border: 1px solid #56726a;" value="PHP">
		 	  <label class="form-control mb-2 ps-2 inputColor" id="techChoice" ></label>
          </p>
	      <div class="modal-footer">
	        <button type="button" class="btn bg msubBtn btnStyle" id="AddBtn">생성</button>
	        <button type="reset" class="btn bg mcanBtn" data-bs-dismiss="modal" id="cancleBtn">취소</button>
	      </div>
        </form>
      </div>
	`
	$("#modalContent").html(projectModal);

	techChoiceBtn()

	$("#insertProjModal").modal("show");
	autoComplete();

})


/* 지원신청서 모달 작성  */
const techChoiceBtn =() =>{

	$("#mProjTech input[type='button']").on("click", function(){
		var tech = $(this).val();
		console.log("선택된 기술 스택 : ", tech);
		var techChoice = $("#techChoice").val(tech);


	 // 이미 선택된 기술 스택인 경우 선택 해제
	    if ($(this).hasClass("selected")) {  //hasClass 존재여부 확인
	      $(this).removeClass("selected");
	      techChoice.find("label[data-value='" + tech + "']").remove();
	    }
	    // 선택되지 않은 기술 스택인 경우 선택
	    else {
	        $(this).addClass("selected");

	        // 선택된 기술 스택 추가
	        techChoice.append("<label data-value='" + tech + "'>" + " " + tech  + "</label>");

	      }
	})
}
		document.addEventListener("click", function (event) {

  		if (event.target.id === "AddBtn") {
  			 if (validateForm()) {
				var data = {
					stuNo : stuNo,
					projNm : $("#mProjNm").val(),
					projExpln : $("#mProjExpln").val(),
					projBgngDt : converDate2($("#mProjBgngDt").val()),
					projDdlnDt : converDate2($("#mProjDdlnDt").val()),
					projTech : getSelectedTech()
			    };

		//서버로 보내기
			insertProj(data);

			$("#insertProjModal").modal("hide");

 	   		}
  		}
	});


 /* 기술스택 선택시 */
function getSelectedTech(){

	var selectedTech = "";
	$("#mProjTech input[type='button'].selected").each(function() {

		var tech = $(this).val();

		//db에 저장되는 값
		selectedTech += " " + tech;
	});

	console.log("selectedTech: ",selectedTech);
	return selectedTech;
}



/* 프로젝트 생성 */
function insertProj(data) {

	console.log("stuNo 추가한 data", data)

	$.ajax({
		url : "/pms/insertproj",
		type : "post",
		data : JSON.stringify(data),
		dataType : "text",
		contentType : "application/json; charset=utf-8",
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success : function(res) {

			Swal.fire(
	       			  '프로젝트 생성 완료',
	       			  '새로운 프로젝트가 생성 되었습니다!',
	       			  'success'
	       			)
			projList();
			projectList(stuNo);
		},

		error : function(xhr){
			console.log(xhr.status);
		},

		});

	};


	function validateForm() {
	    const mProjNm = document.getElementById("mProjNm");
	    const mProjExpln = document.getElementById("mProjExpln");
	    const mProjBgngDt = document.getElementById("mProjBgngDt");
	    const mProjDdlnDt = document.getElementById("mProjDdlnDt");
	    const mProjTech = document.getElementById("mProjTech");

	    if (mProjNm.value.trim() === "") {
		      Swal.fire({
		        icon: "error",
		        title: "프로젝트명을 입력하세요.",
		      });
	      return false;
	    } else if (mProjNm.value.length > 10) {
	        Swal.fire({
	            icon: "error",
	            title: "프로젝트명은 10자 이하로 입력하세요.",
	          });
	  	 return false;
	    } else if (mProjExpln.value.trim() === "") {
		      Swal.fire({
		        icon: "error",
		        title: "프로젝트 소개를 입력하세요.",
		      });
	      return false;
	    } else if (mProjBgngDt.value === "" || mProjDdlnDt.value === "") {
		      Swal.fire({
		        icon: "error",
		        title: "프로젝트 기간을 선택하세요.",
		      });
	      return false;
	    } else if (mProjTech.querySelectorAll("input[type='button'].selected").length === 0) {
		      Swal.fire({
		        icon: "error",
		        title: "필요 기술 스택을 선택하세요.",
		      });
	      return false;
	    }
	    return true;
	}



	function validateAplyForm() {
		  const mAplyCn = document.getElementById("mAplyCn");
		  const mAplyTech = document.getElementById("mAplyTech");

		  if (mAplyCn.value.trim() === "") {
		    Swal.fire({
		      icon: "error",
		      title: "자기소개를 입력하세요.",
		    });
		    return false;
		  } else if (
		    mAplyTech.querySelectorAll("input[type='button'].selected").length === 0
		  ) {
		    Swal.fire({
		      icon: "error",
		      title: "보유 기술을 선택하세요.",
		    });
		    return false;
		  }

		  return true;
	}





</script>

