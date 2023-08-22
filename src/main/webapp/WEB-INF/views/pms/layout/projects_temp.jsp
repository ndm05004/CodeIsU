<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>




    <!DOCTYPE html>
    <html lang="ko">
        <head>
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/pms/assets/img/apple-icon.png" />
            <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/pms/assets/img/favicon.png" />
            <title>Material Dashboard 2 by Creative Tim</title>
            <!--     Fonts and icons     -->
            <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
            <!-- Nucleo Icons -->
            <link href="${pageContext.request.contextPath}/pms/assets/css/nucleo-icons.css" rel="stylesheet" />
            <link href="${pageContext.request.contextPath}/pms/assets/css/nucleo-svg.css" rel="stylesheet" />
            <!-- Font Awesome Icons -->
            <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
            <!-- Material Icons -->
            <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet" />
            <!-- CSS Files -->
            <link id="pagestyle" href="${pageContext.request.contextPath}/pms/assets/css/material-dashboard.css" rel="stylesheet" />
            <!-- j쿼리 -->
            <script src="${pageContext.request.contextPath}/assets/libs/jquery/dist/jquery.min.js"></script>

            <!-- Custom $t Js -->
          <script>
          var $t = {
              header : "${_csrf.headerName}",
              token : "${_csrf.token}",
              csrfq : "${_csrf.parameterName }=${_csrf.token}",
              cpath : "${pageContext.request.contextPath}"
          };
          </script>

	<!-- 여기가 프로젝트 목록 템플릿 -->
	<script>
	  var stuNo = "<sec:authentication property="principal.member.userNo" />";
	  console.log("stuNo : " , stuNo);

	  //로컬스토리지에 로그인 했을 때부터 리스트 저장하려고 호출
	  alarmMsg();

 	  let webSocket = null;
 	  let webSocket2 = null;
	  function connect() {
	    webSocket = new WebSocket("ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/tttt1"); // End Point
	    webSocket2 = new WebSocket("ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/tttt"); // End Point
	    //이벤트에 이벤트핸들러 뜽록
	    console.log("웹소켓 : ", webSocket)
	    webSocket.onopen = fOpen; // 소켓 접속되면 자동 실행할 함수(fOpen) 소켓이 생성될때(클라이언트 접속)
	    webSocket.onmessage = fMessage; //서버에서 메세지 오면 자동으로 실행할 함수(fMessage) 소켓이 메세지를 받을 때

	    webSocket2.onopen = fOpen; // 소켓 접속되면 자동 실행할 함수(fOpen) 소켓이 생성될때(클라이언트 접속)
	    webSocket2.onmessage = fMessage; //서버에서 메세지 오면 자동으로 실행할 함수(fMessage) 소켓이 메세지를 받을 때
	  }

	  connect();


	  // 연결이 열리면 자동실행(딱 한번)
	  function fOpen() {
	    console.log("웹소켓 연결 성공");
	    const bell = $("#bell");
	  }

	  // 서버에서 데이터가 왔을때 자동실행
	  function fMessage() {
	    let data = event.data; // 서버가 보낸 데이터가 event.data에 담겨있음!

	    console.log("let data : ", data);
	    //var pNo = data.split(",")[1]; //프로젝트 번호 가져오기
	      //해당 프로젝트에만 알림 메세지 보내기
	      alarmMsg(data); //메세지 띄우기 함수 호출

	  }



	//알림 메세지 띄우기
	  function alarmMsg(data) {
	console.log("로그인한 사용자 no : " + stuNo);

// 		console.log("data !!!" , data)
// 	    const pNo = data.split(",")[1]; //프로젝트 번호 가져오기

		if(stuNo != "S2302101"){
			 $.ajax({
				url: "/pms/project/alarmlist",
				type: "get",
				dataType : "json",
				success: function(res){

					console.log("알람 리스트 res : ", res)

					$(".dropdown-menu").empty();

					for (let aMsg of res) {
					/* 	console.log("체킁:",aMsg); */

						const aDt = aMsg.alarmDt;
						const timePart = aDt.substring(11, 16);


						const proFileImg = $("<img>")
						.attr("src", aMsg.userProfile)
						.addClass("profile-image rounded-circle");

							const bell = $(".fa-bell");
								bell.addClass("fas fa-bell");
								bell.append(
									`<div class='icon' style='width: 8px;height: 8px;background: #f30000;border-radius: 100%;position: absolute;right: 21%;top: 28%;'></div>`
								);

							let htmlMsg = `
								<div class="container">
	 							<div class="row pt-2" style="border-bottom: 1px solid #f2f2f2;">
	 								<div class="col-2">
	 									<div>\${proFileImg.prop('outerHTML')}</div>
	 								</div>
	 								<div class="col-10">
	 									<div class="col-12">
			 								<div>[\${aMsg.projNm}]</div>
			 							</div>
	 									<div class="col-12 me-0">
				 							<div>\${aMsg.userNm}님이 [\${aMsg.projNm}]에 \${aMsg.alarmCd}를 제출 했습니다. \${timePart}</div>
			 							</div>
			 						</div>
								</div>
							</div>
							`;
						$(".dropdown-menu").html(htmlMsg);

						localStorage.setItem("aMsgList", JSON.stringify(res));
						updateDropdownMenu();
					}
				},
				error: function(xhr) {
				console.log("상태: " + xhr.status);
				}
			})
		}else{
			localStorage.setItem("aMsgList", null);
		}
	  }

	  function updateDropdownMenu() {
		  const storedNotifications = JSON.parse(localStorage.getItem("aMsgList"));

		  if (storedNotifications && Array.isArray(storedNotifications)) {
		    const dropdownMenu = $(".dropdown-menu");

		    // 드롭다운 메뉴 비우기
		    dropdownMenu.empty();

		    // 저장된 알림을 드롭다운 메뉴에 추가하기
		    for (const aMsg of storedNotifications) {



				const aDt = aMsg.alarmDt;
				const timePart = aDt.substring(11, 16);

				const proFileImg = $("<img>")
				.attr("src", aMsg.userProfile)
				.addClass("profile-image rounded-circle");

					let htmlMsg = `
						<div class="container">
							<div class="row pt-2" style="border-bottom: 1px solid #f2f2f2;">
 								<div class="col-2">
 									<div>\${proFileImg.prop('outerHTML')}</div>
 								</div>
 								<div class="col-10">
 									<div class="col-12">
		 								<div>[\${aMsg.projNm}]</div>
		 							</div>
 									<div class="col-12 me-0">
			 							<div>\${aMsg.userNm}님이 \${aMsg.alarmCd}를 등록했습니다. \${timePart}</div>
		 							</div>
		 						</div>
							</div>
						</div>
					`;
				dropdownMenu.append(htmlMsg);
		    }
		  }
		}

	  $(document).ready(function () {
		  updateDropdownMenu();

		 $("#bell").on("click", function () {
				  const bell = $(".fa-bell");

				    bell.removeClass("fas fa-bell");
				    bell.addClass("far fa-bell");
				    bell.find(".icon").remove(); // 추가된 div.icon 요소를 삭제

			});

	  });

	 </script>

          <script src="${pageContext.request.contextPath}/resources/common/js/common.js" type="text/javascript"></script>


            <!--   커스텀 CSS -->

    	<style>
	        .nav-link0{
	            color:#252323;
	        }
	        .nav-link0:hover{
	            color:#252323;
	            text-decoration: underline;
	            text-decoration-color: #495B8A;
	            text-decoration-thickness: 2px;
	        }

	        .icon-lg i {
			    top: 25%;
			    font-size: 1.5rem;
			}

			.profile-image {
			    width: 45px;
			    height: 45px;
			    margin-right: 10px;
			    margin-bottom: 10px;
			}



        </style>

        <!--   커스텀 CSS 끝 -->
        </head>

<body>
	<div class="center-wrap">
		<div class=" bg-gray-200">
			<aside class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 ms-3 bg-gradient-dark" id="sidenav-main">
				<div class="sidenav-header">
					<i class="fas fa-times p-3 cursor-pointer text-white opacity-5 position-absolute end-0 top-0 d-none d-xl-none" aria-hidden="true" id="iconSidenav"></i> <a class="navbar-brand m-0" href="javascript:goToMenu('stu_stumain')"> <img src="${pageContext.request.contextPath}/pms/assets/img/ddit_logo05.png" class="navbar-brand-img h-100" alt="main_logo" />
					</a>
				</div>
				<hr class="horizontal light mt-0 mb-2" />
				<div class="collapse navbar-collapse w-auto" id="sidenav-collapse-main">
					<ul class="navbar-nav">

						<li class="nav-item">
							<%--   <a class="nav-link text-white" href="${pageContext.request.contextPath}/pms/dashboard.html"> --%> <a class="nav-link text-white" href="javascript:goToMenu('pms_main')">
								<div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
									<i class="pe-2 material-icons opacity-10">dashboard</i>
									<!-- <a href="javascript:goToMenu('pms_main')"><span class="nav-link-text ms-1">프로젝트 목록</span></a> -->
									<span class="nav-link-text ms-1">프로젝트 목록</span>
								</div>

						</a>
						</li>


				<!-- 여기가 프로젝트 목록 템플릿 -->
						<!-- <a href="javascript:goToMenu('pms_myprojects')"> -->
						<li class="nav-item">
						 <div id="myProject">
							<a id="projNav" data-bs-toggle="collapse" href="#applicationsExamples" class="nav-link text-white " aria-controls="applicationsExamples" role="button" aria-expanded="true">
								<div class="row text-white text-center me-2 d-flex align-items-center justify-content-center">
										<div class="col-2">
											<i class="pe-2 material-icons opacity-10">view_list</i>
										</div>
										<div class="col-10">
										<span class="nav-link-text ms-1">내 프로젝트</span>
										</div>
								</div>
							</a>
						 </div>
							<div class="collapse show" id="applicationsExamples">

								<ul class="nav">
									<li id="navlist" class="nav-item"></li>
								</ul>
							</div>
						</li>

					</ul>
				</div>


				<!-- 프로젝트 지원 현황 -->
				<div class="sidenav-footer position-absolute w-100 bottom-0">
					<div class="col">
						<div class="card  mb-2 mx-3">

							<div class="card ">
								<div class="card-header p-3 pt-1 pb-1 bg-transparent">
									<div class="icon icon-lg icon-shape bg-Info shadow-info text-center border-radius-xl mt-n4 position-absolute"
										 style="width: 42px; height: 42px; left: 7px; top: 10px; background: #0a1f3b; opacity: 88%;">
										<i class="material-icons opacity-10 mb-1">pending_actions</i>
									</div>
									<div class="text-end pt-1">
										<p class="text-sm mb-0 text-capitalize ">프로젝트 지원 목록</p>
										<h4 class="mb-0" id="aplyCnt"></h4> <!--프로젝트 지원 리스트 카운트  -->
									</div>
								</div>
								<hr class="horizontal my-0 dark">
								<div class="card-footer p-2" id="aplyBox">
									<p class="mb-0"></p><!--지원한프로젝트명  -->
								</div>
							</div>
						</div>
					</div>



					<div class="mx-3">
						<a class="btn bg-white w-100" href="/" type="button">메인페이지로 돌아가기</a>
					</div>
				</div>


			</aside>
			<main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg main-content-ktmar">
				<!-- Navbar -->
				<nav class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl" id="navbarBlur" data-scroll="true">
					<div class="container-fluid py-1 px-3">
						<div class="">
							<h3 class="ms-1">프로젝트 목록</h3>
						</div>
						<div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4" id="navbar">
							<div class="ms-md-auto pe-md-3 d-flex align-items-center"></div>
							<ul class="navbar-nav justify-content-end">
								<ul class="navbar-nav justify-content-end">
									<li class="nav-item d-flex align-items-center"></li>

								 <!--알람-->

                                            <li class="nav-item dropdown px-2 d-flex align-items-center">
                                                <a href="javascript:;" class="nav-link text-body p-0" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                         			<i class="far fa-bell" id="bell" aria-hidden="true"></i>
                                                </a>

                                                <ul class="dropdown-menu dropdown-menu-end px-2 py-3 me-sm-n4" aria-labelledby="dropdownMenuButton" style="width:380px;">

                                                </ul>
                                            </li>
                                            <!--알람끝-->

                                            <li class="nav-item d-flex align-items-center">　</li>

                                            <li class="nav-item">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="avatar-group mt-2 avatar avatar-xs rounded-circle">
                                                         <img alt="Image placeholder" src="${pageContext.request.contextPath}<sec:authentication property='principal.member.userProfile'/>" style="width: 40px" />
												   </div>
                                                </div>
                                            </li>

                                            <li class="nav-item d-flex align-items-center">　</li>
                                            <li class="nav-item d-flex align-items-center">
                                                <div class="d-flex flex-column justify-content-center">
                                                    <h6 class="mb-0 text-sm">
                                                    <sec:authentication property="principal.member.userNm" /> 님</h6>
                                                    <p class="text-xs text-secondary mb-0 d-none"></p>
                                                </div>
                                            </li>
                                            <li class="nav-item d-flex align-items-center">　</li>

                                            <li class="nav-item d-flex align-items-center">
                                                <a href="/user/logout" class="nav-link text-body font-weight-bold px-0">
                                                    <i class="fa fa-user me-sm-1" aria-hidden="true"></i>
                                                    <span class="d-sm-inline d-none">로그아웃</span>
                                                </a>
                                            </li>
                                        </ul>

                                    </ul>
						</div>
					</div>
				</nav>
				<!-- End Navbar -->
				<div class="container-fluid py-0">
					<div class="row justify-content-md-end">
						<div class="col">
							<div class="card mt-4">
								<div class="card-body p-3 pb-0" style="min-height: 850px;">
									<div class="container mt-3"></div>



									<tiles:insertAttribute name="content" />

								</div>
							</div>
						</div>
					</div>
					<div class="position-fixed bottom-1 end-1 z-index-2">
						<div class="toast fade hide p-2 bg-white" role="alert" aria-live="assertive" id="successToast" aria-atomic="true">
							<div class="toast-header border-0">
								<i class="material-icons text-success me-2"> check </i> <span class="me-auto font-weight-bold">Material Dashboard </span> <small class="text-body">11 mins ago</small> <i class="fas fa-times text-md ms-3 cursor-pointer" data-bs-dismiss="toast" aria-label="Close"></i>
							</div>
							<hr class="horizontal dark m-0" />
							<div class="toast-body">Hello, world! This is a notification message.</div>
						</div>
						<div class="toast fade hide p-2 mt-2 bg-gradient-info" role="alert" aria-live="assertive" id="infoToast" aria-atomic="true">
							<div class="toast-header bg-transparent border-0">
								<i class="material-icons text-white me-2"> notifications </i> <span class="me-auto text-white font-weight-bold">Material Dashboard </span> <small class="text-white">11 mins ago</small> <i class="fas fa-times text-md text-white ms-3 cursor-pointer" data-bs-dismiss="toast" aria-label="Close"></i>
							</div>
							<hr class="horizontal light m-0" />
							<div class="toast-body text-white">Hello, world! This is a notification message.</div>
						</div>
						<div class="toast fade hide p-2 mt-2 bg-white" role="alert" aria-live="assertive" id="warningToast" aria-atomic="true">
							<div class="toast-header border-0">
								<i class="material-icons text-warning me-2"> travel_explore </i> <span class="me-auto font-weight-bold">Material Dashboard </span> <small class="text-body">11 mins ago</small> <i class="fas fa-times text-md ms-3 cursor-pointer" data-bs-dismiss="toast" aria-label="Close"></i>
							</div>
							<hr class="horizontal dark m-0" />
							<div class="toast-body">Hello, world! This is a notification message.</div>
						</div>
						<div class="toast fade hide p-2 mt-2 bg-white" role="alert" aria-live="assertive" id="dangerToast" aria-atomic="true">
							<div class="toast-header border-0">
								<i class="material-icons text-danger me-2"> campaign </i> <span class="me-auto text-gradient text-danger font-weight-bold">Material Dashboard </span> <small class="text-body">11 mins ago</small> <i class="fas fa-times text-md ms-3 cursor-pointer" data-bs-dismiss="toast" aria-label="Close"></i>
							</div>
							<hr class="horizontal dark m-0" />
							<div class="toast-body">Hello, world! This is a notification message.</div>
						</div>
					</div>
					<footer class="footer py-4">
						<div class="container-fluid">
							<!--  <div class="row align-items-center justify-content-lg-between">
                                        <div class="col-lg-6 mb-lg-0 mb-4">
                                        <div class="copyright text-center text-sm text-muted text-lg-start">
                                            중간평가까지 D -
                                            <script>
                                                var currentDate = new Date();
                                                var ddayDate = new Date(currentDate
                                                        .getFullYear(), 6, 21);

                                                var timeDiff = ddayDate.getTime()
                                                        - currentDate.getTime();
                                                var daysDiff = Math.ceil(timeDiff
                                                        / (1000 * 3600 * 24));

                                                document.write(daysDiff);
                                            </script>
                                            , <a href="https://www.creative-tim.com" class="font-weight-bold" target="_blank">TTTT</a> ㅎ
                                        </div>
                                    </div>
                                        <div class="col-lg-6">
                                            <ul class="nav nav-footer justify-content-center justify-content-lg-end">
                                                <li class="nav-item">
                                                    <a href="https://www.creative-tim.com" class="nav-link text-muted" target="_blank">끝까지</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a href="https://www.creative-tim.com/presentation" class="nav-link text-muted" target="_blank">화이팅</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a href="https://www.creative-tim.com/blog" class="nav-link text-muted" target="_blank">시간은</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a href="https://www.creative-tim.com/license" class="nav-link pe-0 text-muted" target="_blank">금방간다</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div> -->
						</div>
					</footer>
				</div>
			</main>
			<div class="fixed-plugin">
				<a class="fixed-plugin-button text-dark position-fixed px-3 py-2"> <i class="material-icons py-2">settings</i>
				</a>
				<div class="card shadow-lg">
					<div class="card-header pb-0 pt-3">
						<div class="float-start">
							<h5 class="mt-3 mb-0">Material UI Configurator</h5>
							<p>See our dashboard options.</p>
						</div>
						<div class="float-end mt-4">
							<button class="btn btn-link text-dark p-0 fixed-plugin-close-button">
								<i class="material-icons">clear</i>
							</button>
						</div>
						<!-- End Toggle Button -->
					</div>
					<hr class="horizontal dark my-1" />
					<div class="card-body pt-sm-3 pt-0">
						<!-- Sidebar Backgrounds -->
						<div>
							<h6 class="mb-0">Sidebar Colors</h6>
						</div>
						<a href="javascript:void(0)" class="switch-trigger background-color">
							<div class="badge-colors my-2 text-start">
								<span class="badge filter bg-gradient-primary active" data-color="primary" onclick="sidebarColor(this)"></span> <span class="badge filter bg-gradient-dark" data-color="dark" onclick="sidebarColor(this)"></span> <span class="badge filter bg-gradient-info" data-color="info" onclick="sidebarColor(this)"></span> <span class="badge filter bg-gradient-success" data-color="success" onclick="sidebarColor(this)"></span> <span class="badge filter bg-gradient-warning" data-color="warning"
									onclick="sidebarColor(this)"></span> <span class="badge filter bg-gradient-danger" data-color="danger" onclick="sidebarColor(this)"></span>
							</div>
						</a>
						<!-- Sidenav Type -->
						<div class="mt-3">
							<h6 class="mb-0">Sidenav Type</h6>
							<p class="text-sm">Choose between 2 different sidenav types.</p>
						</div>
						<div class="d-flex">
							<button class="btn bg-gradient-dark px-3 mb-2 active" data-class="bg-gradient-dark" onclick="sidebarType(this)">Dark</button>
							<button class="btn bg-gradient-dark px-3 mb-2 ms-2" data-class="bg-transparent" onclick="sidebarType(this)">Transparent</button>
							<button class="btn bg-gradient-dark px-3 mb-2 ms-2" data-class="bg-white" onclick="sidebarType(this)">White</button>
						</div>
						<p class="text-sm d-xl-none d-block mt-2">You can change the sidenav type just on desktop view.</p>
						<!-- Navbar Fixed -->
						<div class="mt-3 d-flex">
							<h6 class="mb-0">Navbar Fixed</h6>
							<div class="form-check form-switch ps-0 ms-auto my-auto">
								<input class="form-check-input mt-1 ms-auto" type="checkbox" id="navbarFixed" onclick="navbarFixed(this)" />
							</div>
						</div>
						<hr class="horizontal dark my-3" />
						<div class="mt-2 d-flex">
							<h6 class="mb-0">Light / Dark</h6>
							<div class="form-check form-switch ps-0 ms-auto my-auto">
								<input class="form-check-input mt-1 ms-auto" type="checkbox" id="dark-version" onclick="darkMode(this)" />
							</div>
						</div>
						<hr class="horizontal dark my-sm-4" />
						<a class="btn bg-gradient-info w-100" href="https://www.creative-tim.com/product/material-dashboard-pro">Free Download</a> <a class="btn btn-outline-dark w-100" href="https://www.creative-tim.com/learning-lab/bootstrap/overview/material-dashboard">View documentation</a>
						<div class="w-100 text-center">
							<a class="github-button" href="https://github.com/creativetimofficial/material-dashboard" data-icon="octicon-star" data-size="large" data-show-count="true" aria-label="Star creativetimofficial/material-dashboard on GitHub">Star</a>
							<h6 class="mt-3">Thank you for sharing!</h6>
							<a href="https://twitter.com/intent/tweet?text=Check%20Material%20UI%20Dashboard%20made%20by%20%40CreativeTim%20%23webdesign%20%23dashboard%20%23bootstrap5&amp;url=https%3A%2F%2Fwww.creative-tim.com%2Fproduct%2Fsoft-ui-dashboard" class="btn btn-dark mb-0 me-2" target="_blank"> <i class="fab fa-twitter me-1" aria-hidden="true"></i> Tweet
							</a> <a href="https://www.facebook.com/sharer/sharer.php?u=https://www.creative-tim.com/product/material-dashboard" class="btn btn-dark mb-0 me-2" target="_blank"> <i class="fab fa-facebook-square me-1" aria-hidden="true"></i> Share
							</a>
						</div>
					</div>
				</div>
			</div>
			<!--   Core JS Files   -->
			<script src="${pageContext.request.contextPath}/pms/assets/js/core/popper.min.js"></script>
			<script src="${pageContext.request.contextPath}/pms/assets/js/core/bootstrap.min.js"></script>
			<script src="${pageContext.request.contextPath}/pms/assets/js/plugins/perfect-scrollbar.min.js"></script>
			<script src="${pageContext.request.contextPath}/pms/assets/js/plugins/smooth-scrollbar.min.js"></script>
			<script>
                        var win = navigator.platform.indexOf("Win") > -1;
                        if (win && document.querySelector("#sidenav-scrollbar")) {
                            var options = {
                                damping: "0.5",
                            };
                            Scrollbar.init(document.querySelector("#sidenav-scrollbar"), options);
                        }
                    </script>
			<!-- Github buttons -->
			<script async defer src="https://buttons.github.io/buttons.js"></script>
			<!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
			<script src="${pageContext.request.contextPath}/pms/assets/js/material-dashboard.min.js?v=3.1.0"></script>
			<!-- SweetAlert2 -->
			<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.12/dist/sweetalert2.all.min.js"></script>
			<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.12/dist/sweetalert2.min.css" rel="stylesheet">
		</div>
	</div>
</body>
</html>


<script>

	/* var stuNo = "${userNo}"; */

    /* 프로젝트 리스트  */
    function projectList(stuNo){

       $.ajax({
         url: "/pms/projlist2",
         data: {
           "stuNo": stuNo,
         },
         type: "get",
         dataType: "json",
         success: function (res) {
           console.log("ProjList", res);

           var projList = "";

   	        for (let i = 0; i < res.length; i++) {
   	          projList += `

   		             	<a class="nav-link text-white" href="/pms/project/dashBoard?projNo=\${res[i].projNo}" id="proj" data-value="\${res[i].projNo}">
	   						<span class="sidenav-normal text-sm ms-2  ps-1">
	   						\${res[i].projNm} </span>
   						</a>
   	            `;
   	        }

           $("#navlist").html(projList);
         }
       });
     };

     projectList(stuNo);

     /* 내 프로젝트 페이지 이동 */
     $(".nav-item").on("click","#myProject", function(){
    	 location.href = "javascript:goToMenu('pms_myprojects')";
     })




   function aplyList(stuNo){
    	console.log("aplyList 템플릿 체크 :" + stuNo)

       $.ajax({
         url: "/pms/aplylist",
         data: {
           stuNo: stuNo,
         },
         type: "get",
         dataType: "json",
         success: function (res) {
           console.log("aplyList", res);

           var aplyList = "";
           var cnt = 0;


   	        for (let i = 0; i < res.length; i++) {
   	        	aplyList += `

   		             	<p class="nav-link text-white mt-0 mb-0 pt-0 pb-0" href="" id="proj" data-value="\${res[i].projNo}">
	   						<span class="sidenav-normal text-sm text-dark">
	   						\${res[i].projNm} </span>
   						</p>

   	            `;
   	           cnt++;

   	        }

           $("#aplyBox").html(aplyList);

           if (cnt !== 0) {
               $("#aplyCnt").html("+" + cnt);
           } else {
               $("#aplyCnt").html("-");
           }
         }
       });
     };

     aplyList(stuNo);


</script>