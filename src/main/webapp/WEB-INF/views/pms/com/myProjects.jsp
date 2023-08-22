<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<style>
.lineClear {
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
	text-overflow: ellipsis;
}

.nullStyle{
	text-align: center;
	font-weight: 500;
	margin-top: 165px;

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

/* 프로젝트내용 마우스오버 */
.hover-text-container {
 	position: relative;
}

.hover-text {
  display: none;
  position: absolute;
  width: 270px;
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

#exitBtn{
	cursor:pointer;
	width: 55px;
	height: 30px;
    line-height: 10px;
    background: #465b8a;
    color: white;
    border: none;
    font-weight: 600;
}

.aplyClick {
	cursor: pointer;
}
</style>
<div class="table-responsive ms-1"><br>

<table class="table align-items-center mb-0" id="myProjects">
</table>
</div>


<script type="text/javascript">

var stuNo = "${userNo}"

console.log("stuNo : ", stuNo)
/* 무한 스크롤 함수 시작 */
var page = 1;

$(window).scroll(function() {
    if ($(window).scrollTop() == $(document).height() - $(window).height()) {
      console.log(++page);

      /* $("#myProjects").append('<div class="table-responsive ms-1"></div>'); */

    }
});
/* 무한 스크롤 함수 끝  */


//서버에서 발행된 헤더네임과 토큰갑사 저장
var header = '${_csrf.headerName}';
var token =  '${_csrf.token}';


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


//내프로젝트 리스트
function projList(type, search){

	// get방식에 필요 없는 것  : contentType, @RequestBody

	let data = {
			stuNo:stuNo,
			projSttsCd:type,
			projNm:search
		}

    $.ajax({
      url: "/pms/myprojlist",
      type: "get",
      data: data,
      success:function(res){
    	  console.log("myprojlist:",res);
		  console.log("stuNo", stuNo)
    	  let count = 0;

    	  code = "";
    	  code +=
    		  `<nav class="shadow-none navbar border-0 d-flex me-4">
	    		<!--  <div class="container-fluid" style="justify-content:flex-end	;">
				    <a class="navbar-brand">제목</a>
				    <form class="d-flex"></form>
				      <input class="w-20 form-control me-2" id="titleSearch" type="search" placeholder="Search" aria-label="Search">
				      <button type="button" id="searchBtn"  class="btn btn-default mb-0 search">
						 <i class="fas fa-search" aria-hidden="true"></i>
					  </button>
				  </div> -->

				  <div class="container-fluid" style="justify-content:flex-end	;">
				  <div class="col-3"></div>
				  <div class="col-5"></div>
				  <div class="col-4">
				  <div class="d-flex justify-content-end border rounded bg-white">
				  <a class="navbar-brand pt-2 ps-2">제목</a>
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

	    	$("#myProjects").html(code + "<p class='nullStyle border-0'>조회 되는 프로젝트가 없습니다.</p>");

	    	if(!type){
				//alert("ppp");
				$(`a[data-value=""].navBtn`).css("border-bottom","2px solid #56726A");
			  }else {
				$(`a[data-value=\${type}].navBtn`).css("border-bottom","2px solid #56726A");
			 }

	    	$("#titleSearch").val(search);

		  } else {
		  code += `<div class="scroll-Wrap ps-4 border-0">`;
		  code += `<div class="d-flex justify-start-end border-0">`;

    	  for(let i=0; i<res.length; i++){
			  let sys = new Date();

			  let projBgngDt = convertDate(res[i].projBgngDt)
    		  let projDdlnDt = convertDate(res[i].projDdlnDt)
    		  let jbttlCd = res[i].jbttlCd

    		  console.log("jbttlCd !!!!!!!!!!!! : ", jbttlCd)

    		  let lestDay = Date.parse(projDdlnDt) - sys;

			  if(lestDay < 0) {
 			      daysLeft = "프로젝트 종료됨";
			  } else {
			   	  daysLeft = Math.ceil(lestDay / (1000 * 60 * 60 * 24)) + " days left";
			  }

    	  code += `
    		  <div class="card me-4 ms-3 mb-3 aplyClick" style="width: 20rem; background:#FBFBFB;" value="\${res[i].projNo}">
    			<div class="card-body container" style="box-sizing: border-box;">
    				<div class="row" style="height:46px;" id="btn-Wrap">
	    				<div class="col-8">
		    				<h5 class="card-title h6 font-weight-bolder" style="height: 20px;">
		    					\${res[i].projNm}
		    				</h5>
	    				</div>
	    				<div class="col-4">
    						<button type="button" class="btn btn-outline-secondary float-end p-2 fs-6" id="exitBtn"
    							    style="\${jbttlCd !== 'PL' ? 'display: block;' : 'display: none;'}">탈퇴</button>
	    				</div>
    				</div>
    				<div class="row">
	    				<div class="col">
		    				<h6 class="card-subtitle mb-1 mt-1 text-xs lineClear" style="height: 30px; font-weight:normal;">\${res[i].projExpln}</h6>

		    				<!-- 마우스 오버시 보일 내용 -->
							<label class="hover-text card-subtitle mb-1 mt-2 ">\${res[i].projExpln}</label>
						</div>
					</div>
					<div class="row pb-2">
			  			<div class="col-5">
    						<span class="text-xs fw-bold" id="jbttlCd" style="color: #344767;">직책: \${res[i].jbttlCd}</span>
						</div>
	    				<div class="col-7 pe-0 text-end">
		    				<span class="card-text text-xs pe-1">
			    				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="me-1 bi bi-people-fill" viewBox="0 0 16 16">
			    				  <path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1H7Zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm-5.784 6A2.238 2.238 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.325 6.325 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1h4.216ZM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5Z"/>
			    				</svg>
		    					\${res[i].projTnope}명
		    				</span>
		    			    <span class="text-xs fw-bold">/</span>
		    				<span class="text-xs fw-bold pe-3" id="projStatus" >\${res[i].projSttsCd}</span>
		    			</div>
					</div>

					<div class="row">
						<div class="col">
		    				<p class="card-text text-xs mt-1 pb-1">
			    				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="me-1 bi bi-calendar4-range" viewBox="0 0 16 16">
			  				 	  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM2 2a1 1 0 0 0-1 1v1h14V3a1 1 0 0 0-1-1H2zm13 3H1v9a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V5z"/>
			  					  <path d="M9 7.5a.5.5 0 0 1 .5-.5H15v2H9.5a.5.5 0 0 1-.5-.5v-1zm-2 3v1a.5.5 0 0 1-.5.5H1v-2h5.5a.5.5 0 0 1 .5.5z"/>
			  					</svg>
			    				\${projBgngDt} - \${projDdlnDt}
			    			</p>
		    			</div>
	    			</div>
	    			<div class="row pt-2 pb-2">
		    			<div class="col">
							<div style="border:1px solid #F4F2F2; "></div>
						</div>
					</div>

					<div class="row">
						<div class="col-4">
							<span class="text-xs fw-bold">진행도 \${res[i].projSttr}%</span>
						</div>
						<div class="col-8">
		    				<div class="progress-wrapper">
		    					<div class="progress-info">
		    						<div class="progress-percentage">
										<div class="pt-2">
			    							<span class="text-end text-xs daysLeft" style="float:right;">
				    							<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-stopwatch-fill" viewBox="0 0 16 16">
				    							  <path d="M6.5 0a.5.5 0 0 0 0 1H7v1.07A7.001 7.001 0 0 0 8 16a7 7 0 0 0 5.29-11.584.531.531 0 0 0 .013-.012l.354-.354.353.354a.5.5 0 1 0 .707-.707l-1.414-1.415a.5.5 0 1 0-.707.707l.354.354-.354.354a.717.717 0 0 0-.012.012A6.973 6.973 0 0 0 9 2.071V1h.5a.5.5 0 0 0 0-1h-3zm2 5.6V9a.5.5 0 0 1-.5.5H4.5a.5.5 0 0 1 0-1h3V5.6a.5.5 0 1 1 1 0z"/>
				    							</svg>
			    							<span class="minMsg fw-bold">\${daysLeft}</span>
			    							</span>
		    							</div>
		    						</div>
		    					</div>
		    				</div>
	    				</div>
    				</div>

    				<div class="row pt-2">
    					<div class="col">
		    				<div class="progress" style="width: 100%; background:#dbdbdb;">
		    					<div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: \${res[i].projSttr}%"></div>
		    				</div>
		    			</div>
    				</div>
    		</div>
    		</div>
    	  `;
    	  count++;

    	  if(count % 3 === 0) {
    		  code += "</div><div class='d-flex justify-start-end' style='border:none;'>";
    	  }
    	  }
    	  code += "</div>";
    	  code += "</div>";



    	  $("#myProjects").html(code);
    	  $("#titleSearch").val(search);

    	  $(".minMsg").each(function(index,item){
			 if(item.innerHTML=="프로젝트 종료됨"){
				item.style.color="#D71923";
			 }
		  });


		  if(!type){
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


/* 탈퇴 버튼 이벤트 */
	$("#myProjects").on("click", "#exitBtn", function(event){
	    event.stopPropagation(); // 이벤트 중단

		var cardNo = $(this).closest(".aplyClick");
		var pNo = cardNo.attr("value");
		console.log("pNo:!!!!", pNo)
		console.log("stuNo:!!!!",stuNo)

		Swal.fire({
 		  title: '탈퇴 하시겠습니까?',
 		  text: "프로젝트 탈퇴 후 취소할 수 없습니다!",
 		  icon: 'warning',
 		  showCancelButton: true,
 		  confirmButtonColor: '#3085d6',
 		  cancelButtonColor: '#d33',
 		  confirmButtonText: '프로젝트 탈퇴'

		}).then((result) => {
 			if (result.value) {
		$.ajax({
			url: "/pms/delmyproj",
			type: "post",
			data: JSON.stringify({
					projNo:pNo,
					stuNo:stuNo
			}),
		    contentType:"application/json;charset=utf-8",
			    beforeSend: function(xhr) {
		           xhr.setRequestHeader(header, token);
		    },
			dataType: "text",
			success:function(res){
				 Swal.fire({
			          icon: "success",
			          title: "프로젝트 탈퇴 완료!",
			          showConfirmButton: false,
			          timer: 1500,
			        });

			       	/* 삭제 후 페이지 이동 */
					setTimeout(() => {
						projList();
						projectList(stuNo);
					}, 1600);

			},
		error: function(xhr) {
			console.log("상태: " + xhr.status);
		},
		})
 		}
		})
	})


/* 프로젝트 클릭시 대시보드 이동 이벤트 */
 $("#myProjects").on("click", ".aplyClick", function(){


	var aplyProjNo = $(this).attr("value");
	console.log("aplyProjNo: ",aplyProjNo)

	location.href = "/pms/project/dashBoard?projNo="+aplyProjNo;

})

/* 검색, 프로젝트 상태 버튼 이벤트 */
$("#myProjects").on("click", ".search", function(){
	var status = $(this).data("value");
	var projNm = $("#titleSearch").val();

	console.log("status, projNm",status,projNm)
	projList(status, projNm);

})

</script>