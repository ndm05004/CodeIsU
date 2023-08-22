<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html dir="ltr" lang="ko">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">
  <!-- Favicon icon -->
  <link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/assets/images/favicon.png">
  <title>Code is U</title>
  <!-- Custom CSS -->
  <link href="${pageContext.request.contextPath}/dist/css/style.css" rel="stylesheet">
  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
  <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->



  <!-- :: Topjs 시작 :: -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"
    integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw=="
    crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js"
    integrity="sha512-57oZ/vW8ANMjR/KQ6Be9v/+/h6bq9/l3f0Oc7vn6qMqyhvPd1cvKBRWWpzu0QoneImqr2SkmO4MSqU+RpHom3Q=="
    crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.min.css"
    integrity="sha512-ELV+xyi8IhEApPS/pSj66+Jiw+sOT1Mqkzlh8ExXihe4zfqbWkxPRi8wptXIO9g73FSlhmquFlUOuMSoXz5IRw=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />
  <!-- Bootstrap tether Core JavaScript -->
  <script src="${pageContext.request.contextPath}/assets/libs/popper.js/dist/umd/popper.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>

  <!-- Custom $t Js -->
  <script>
    var $t = {
      header: "${_csrf.headerName}",
      token: "${_csrf.token}",
      csrfq: "${_csrf.parameterName }=${_csrf.token}",
      cpath: "${pageContext.request.contextPath}"
    };
  </script>
  <script src="${pageContext.request.contextPath}/resources/common/js/common.js" type="text/javascript"></script>
  <!-- :: Topjs 끝 :: -->
  <style>
    .res-div {
      font-size: 1.125rem;
    }

    .res-remote {
      position: relative;
      right: 10px;
    }

    .res-remote-menu {
      position: fixed;
      z-index: 30;
      background-color: white;
    }

    .photo-box {
      padding: 16px;
      /* top: 31px; */
      width: 146px;
      /* float: left; */
      /* position: absolute; */
      border: 1px solid #dfe0e5;
    }

    .photo-box .btn-open {
      background: #fafafc;
      width: 100%;
      height: 149px;
      text-align: center;
      font-size: 13px;
      color: #999;
      cursor: pointer;
      position: relative;
    }

    .row-con {
      max-width: 100%;
      --bs-gutter-x: 30px;
      --bs-gutter-y: 0;
      display: flex;
      flex-wrap: wrap;
      padding: 0;

    }

    .row-con>* {
      flex-shrink: 0;
      max-width: 100%;
      padding-right: calc(var(--bs-gutter-x) * .5);
      padding-left: calc(var(--bs-gutter-x) * .5);
      margin-top: var(--bs-gutter-y);
    }

    .del-btn {
      font-size: 12px;
      position: absolute;
      right: -2px;
      top: 12px;
      width: 15px;
      height: 15px;
    }
  </style>

</head>

<body>
  <!-- ============================================================== -->
  <!-- Preloader - style you can find in spinners.css -->
  <!-- ============================================================== -->
  <div class="preloader">
    <div class="lds-ripple">
      <div class="lds-pos"></div>
      <div class="lds-pos"></div>
    </div>
  </div>
  <!-- ============================================================== -->
  <!-- Main wrapper - style you can find in pages.scss -->
  <!-- ============================================================== -->
  <div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
    data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">
    <!-- ============================================================== -->
    <!-- Topbar header - style you can find in pages.scss -->
    <!-- ============================================================== -->
    <!-- ::: TOPbar 시작 ::: -->
    <div class="center-wrap">
      <header class="topbar center-wrap" data-navbarbg="skin6">
        <nav class="navbar top-navbar navbar-expand-lg">
          <div class="navbar-header" data-logobg="skin6">
            <!-- This is for the sidebar toggle which is visible on mobile only -->
            <a class="nav-toggler waves-effect waves-light d-block d-lg-none" href="javascript:void(0)"><i
                class="ti-menu ti-close"></i></a>
            <!-- ============================================================== -->
            <!-- Logo -->
            <!-- ============================================================== -->
            <div class="navbar-brand">
              <!-- Logo icon -->
              <a href="/">
                <img src="${pageContext.request.contextPath}/resources/common/img/nav_logo.png" alt=""
                  class="img-fluid">
              </a>
            </div>
            <!-- ============================================================== -->
            <!-- End Logo -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Toggle which is visible on mobile only -->
            <!-- ============================================================== -->
            <a class="topbartoggler d-block d-lg-none waves-effect waves-light" href="javascript:void(0)"
              data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
              aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><i
                class="ti-more"></i></a>
          </div>
          <!-- ============================================================== -->
          <!-- End Logo -->
          <!-- ============================================================== -->
          <div class="navbar-collapse collapse" id="navbarSupportedContent">
            <!-- ============================================================== -->
            <!-- toggle and nav items -->
            <!-- ============================================================== -->
            <ul class="navbar-nav float-left me-auto ms-3 ps-1">
              <!-- ============================================================== -->
              <!-- create new -->
              <!-- ============================================================== -->
              <ul class="navbar-nav flex-row flex-wrap bd-navbar-nav pt-0 py-md-0">
                <li class="nav-item col-4 col-md-auto"><a class="nav-link fw-bold" href="javascript:goToMenu('stu_stumain')" onclick="ga('send', 'event', 'Navbar', 'Community links', 'Bootstrap');">Home</a></li>
                <li class="nav-item col-4 col-md-auto"><a class="nav-link fw-bold" aria-current="true" href="javascript:goToMenu('stu_h_cfroom')" onclick="ga('send', 'event', 'Navbar', 'Community links', 'Docs');">학업지원</a></li>
                <li class="nav-item col-4 col-md-auto"><a class="nav-link fw-bold" href="javascript:goToMenu('stu_classroom')" onclick="ga('send', 'event', 'Navbar', 'Community links', 'Examples');">클래스룸</a></li>
                <li class="nav-item col-4 col-md-auto"><a class="nav-link fw-bold" href="javascript:goToMenu('pms_main')" rel="noopener">프로젝트</a></li>
                <li class="nav-item col-4 col-md-auto"><a class="nav-link fw-bold" href="javascript:goToMenu('stu_notice')"  rel="noopener">공지사항</a></li>
                <li class="nav-item col-4 col-md-auto"><a class="nav-link fw-bold" href="javascript:goToMenu('stu_m_resume')"  rel="noopener">마이페이지</a></li>
              </ul>
              <!-- 언어 변경 -->
              <li class="nav-item d-none">
                <a class="nav-link" href="javascript:void(0)">
                  <div class="customize-input">
                    <select class="custom-select form-control bg-white custom-radius custom-shadow border-0">
                      <option selected>EN</option>
                      <option value="1">AB</option>
                      <option value="2">AK</option>
                      <option value="3">BE</option>
                    </select>
                  </div>
                </a>
              </li>
              <!-- 언어 변경 끝-->
            </ul>
            <!-- ============================================================== -->
            <!-- Right side toggle and nav items -->
            <!-- ============================================================== -->
            <ul class="navbar-nav float-end">
              <!-- ============================================================== -->
              <!-- Search -->
              <!-- ============================================================== -->
              <li class="nav-item d-none">
                <a class="nav-link" href="javascript:void(0)">
                  <form>
                    <div class="customize-input">
                      <input class="form-control custom-shadow custom-radius border-0 bg-white" type="search"
                        placeholder="Search" aria-label="Search">
                      <i class="form-control-icon" data-feather="search"></i>
                    </div>
                  </form>
                </a>
              </li>
              <!-- ============================================================== -->
              <!-- User profile and search -->
              <!-- ============================================================== -->
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="javascript:void(0)" data-bs-toggle="dropdown"
                  aria-haspopup="true" aria-expanded="false">
                  <img src="${pageContext.request.contextPath}<sec:authentication property='principal.member.userProfile'/>" alt="user"
                    class="rounded-circle" width="40">
                  <span class="ms-2 d-none d-lg-inline-block"><span class="text-dark">
                      <sec:authentication property="principal.member.userNm" />
                    </span><span>님 (원생)
                    </span> <i data-feather="chevron-down" class="svg-icon"></i></span>
                </a>
                <div class="dropdown-menu dropdown-menu-end dropdown-menu-right user-dd animated flipInY">
                  <a class="dropdown-item" href="javascript:void(0)"><i data-feather="user"
                      class="svg-icon me-2 ms-1"></i>
                    My Profile</a>
                  <a class="dropdown-item" href="javascript:void(0)"><i data-feather="credit-card"
                      class="svg-icon me-2 ms-1"></i>
                    My Balance</a>
                  <a class="dropdown-item" href="javascript:void(0)"><i data-feather="mail"
                      class="svg-icon me-2 ms-1"></i>
                    Inbox</a>
                  <div class="dropdown-divider"></div>
                  <a class="dropdown-item" href="javascript:void(0)"><i data-feather="settings"
                      class="svg-icon me-2 ms-1"></i>
                    Account Setting</a>
                  <div class="dropdown-divider"></div>
                  <a class="dropdown-item" href="javascript:void(0)"><i data-feather="power"
                      class="svg-icon me-2 ms-1"></i>
                    Logout</a>
                  <div class="dropdown-divider"></div>
                  <div class="pl-4 p-3"><a href="javascript:void(0)" class="btn btn-sm btn-info">View
                      Profile</a></div>
                </div>
              </li>
              <!-- ============================================================== -->
              <!-- User profile and search -->
              <!-- ============================================================== -->
              <!-- Notification -->

              <!-- End Notification -->
            </ul>
          </div>
        </nav>
      </header>
    </div>
    <!-- ::: TOPbar 끝 ::: -->
    <!-- ============================================================== -->
    <!-- End Topbar header -->
    <!-- ============================================================== -->
    <!-- ============================================================== -->
    <!-- Left Sidebar - style you can find in sidebar.scss  -->
    <!-- ============================================================== -->
    <div class="center-wrap">
      <!-- ::: LeftNav 시작 ::: -->
      <!-- ::: LeftNav 끝 ::: -->
      <!-- ============================================================== -->
      <!-- End Left Sidebar - style you can find in sidebar.scss  -->
      <!-- ============================================================== -->
      <!-- ============================================================== -->
      <!-- Page wrapper  -->
      <!-- ============================================================== -->
      <div class="page-wrapper page-wrapper2 px-0 res-div">
        <!-- ============================================================== -->
        <!-- Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <form id="resumeForm" action="/stu/mypage/resume/write?${_csrf.parameterName}=${_csrf.token}" method="post"
          enctype="multipart/form-data">
          <div class="row mt-4 mx-2">
            <div class="col-10">
              <div class="col">
                <label for="">
                  <h3>이력서 제목</h3>
                </label>
              </div>
              <div class="card">
                <input class="form-control" type="text" name="resumeNm" id="resumeNm" placeholder="나를 가장 잘 소개할 수 있는 이력서 제목을 입력해주세요">
              </div>
              <div class="col">
                <h3>기본사항</h3>
              </div>
              <div class="card py-3"> <!-- 기본사항 -->
                <div class="row">
                  <div class="col-3 d-flex justify-content-center">
                    <div class="photo-box pull-right mt-3">
                      <div class="btn-open">
                        <img src="/resources/img/profile/dummy/r_junghae.jpg" style="height: 93%;">

                      </div>
                    </div>
                  </div>
                  <div class="col-9">
                    <div class="row me-1 py-2 ">
                      <div class="col-1 d-flex align-items-center">이름</div>
                      <div class="col-3"> <input class="form-control" type="text" value="${user.userNm}" /></div>
                      <div class="col-2 ps-4 d-flex align-items-center justify-content-end ">생년월일</div>
                      <div class="col-3 px-0"> <input class="form-control" type="text" value="${user.userBrdt}" /></div>
                      <div class="col-1  d-flex align-items-center justify-content-end">성별</div>
                      <div class="col-2">
                        <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                          <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off"
                            <c:if test="${user.userGender eq 'M'}">checked</c:if> >
                          <label class="btn btn-outline-primary" for="btnradio1">남성</label>
                          <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off"
                          	<c:if test="${user.userGender eq 'F'}">checked</c:if> >
                          <label class="btn btn-outline-primary" for="btnradio2">여성</label>
                        </div>
                      </div>
                    </div>
                    <div class="row me-1 py-2 ">
                      <div class="col-1">주소</div>
                      <div class="col-11">
                        <div class="row g-3 ">
                          <div class="col-10 mb-2">
                            <input class="form-control" type="text" value="${user.userAddr}" />
                          </div>
                          <div class="col-2"><input class="form-control" type="text" value="${user.userZip}"/></div>
                        </div>

                        <input class="form-control" type="text" value="${user.userDaddr}"/>
                      </div>
                    </div>
                    <div class="row me-1 py-2 ">
                      <div class="col-1 d-flex align-items-center">전화</div>
                      <div class="col-4 pe-0"><input class="form-control" type="text" value="${user.userPhoneno}"/></div>
                      <div class="col-2 d-flex align-items-center justify-content-end">이메일</div>
                      <div class="col-5"><input class="form-control" type="text" value="${user.userEmlAddr}"/></div>
                    </div>
                  </div>
                </div>

              </div>

              <div class="col">
                <h3>학력사항</h3>
              </div>
              <div class="card py-3"> <!-- 학력사항 -->
                <div class="row mx-1 py-2" style="border-bottom: solid 1px #888;">
                  <div class="col-3 text-center">구분</div>
                  <div class="col-4 text-center" id="">학교명</div>
                  <div class="col-3 text-center">계열</div>
                  <div class="col-2 text-center">졸업년월</div>
                </div>
                <div class="row mx-1 py-2 ">
                  <div class="col-3 text-center"> <!--학력사항-고등학교-구분(readonly)-->
                    <input class="form-control" type="text" value="고등학교" readonly />
                  </div>
                  <div class="col-4"><input class="form-control" name="highschNm" id="highschNm" type="text" /></div>
                  <!--학력사항-고등학교-학교명-->
                  <div class="col-3"><!--학력사항-고등학교-계열-->
                    <select class="form-select mr-sm-2" name="highschType" id="highschType">
                      <option selected="">계열 구분</option>
                      <option value="1">일반</option>
                      <option value="2">특성화</option>
                      <option value="3">특수목적</option>
                    </select>
                  </div>
                  <div class="col-2 text-end position-relative"><input class="form-control" name="highschGrdtnYm"
                      id="highschGrdtnYm" type="month" /><!--학력사항-고등학교-졸업년월-->
                  </div>


                </div>
                <hr />
                <div class="row mx-1 py-2" style="border-bottom: solid 1px #888;">
                  <div class="col-2 text-center">대학(원)</div>
                  <div class="col-2 text-center">학교명</div>
                  <div class="col-2 text-center">학과</div>
                  <div class="col-3 text-center">기간</div>
                  <div class="col-1 text-center">상태</div>
                  <div class="col-2 text-center">학점</div>
                </div>
                <div id="input-acbg" class="row mx-1 py-2 ">
                  <div class="col-2 text-center"> <!--학력사항-대학(원)-구분-->
                    <select class="form-select mr-sm-2" name="acbgList[0].schlSeCd">
                      <option selected value="">구분</option>
                      <c:forEach var="c" items="${cmcd_schlSeCd}">
                      	<option value="${c.cdVl}" <c:if test="${c.cdVl eq resume.acbgList.schlSeCd}">checked</c:if>>
                      		${c.cdNm}
                      	</option>
                      </c:forEach>
                    </select>
                  </div>
                  <div class="col-2"><input class="form-control" type="text" name="acbgList[0].schlNm" /></div>
                  <div class="col-2"><input class="form-control" type="text" name="acbgList[0].departNm" /></div>
                  <div class="col-3"><input class="form-control d-inline-block px-0" style="width: 45%;" type="month"
                      name="acbgList[0].mtcltnYm" /> ~
                    <input class="form-control d-inline-block px-0" name="acbgList[0].grdtnYm" style="width: 45%;"
                      type="month" />
                  </div>
                  <div class="col-1">
                    <select class="form-control mr-sm-2" name="acbgList[0].grdtnState">
                      <option value="1">졸업</option>
                      <option value="2">재학중</option>
                      <option value="3">휴학</option>
                      <option value="4">수료</option>
                    </select>
                  </div>
                  <div class="col-2 text-end position-relative">
                    <input class="form-control d-inline-block" style="width: 40%;" type="text"
                      name="acbgList[0].userCredit" /> /
                    <select class="d-inline-block form-control mr-sm-2" style="width: 40%;"
                      name="acbgList[0].baseCredit">
                      <option selected="4.5">4.5</option>
                      <option value="4.3">4.3</option>
                      <option value="4">4</option>
                    </select>
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                      stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                      class="feather feather-x form-control-icon del-btn">
                      <line x1="18" y1="6" x2="6" y2="18"></line>
                      <line x1="6" y1="6" x2="18" y2="18"></line>
                    </svg>
                  </div>
                </div>
                <div id="add-acbg-div" class="row mx-1 py-2">
                  <div class="col-12 text-end">

                    <button type="button" id="add-acbg-btn"
                      class="btn btn-sm waves-effect waves-light btn-outline-info">대학(원) 추가</button>
                  </div>
                </div>
              </div>

              <div class="col">
                <h3>면허/자격증</h3>
              </div>
              <div class="card py-3">
                <div class="row mx-1 py-2" style="border-bottom: solid 1px #888;">
                  <div class="col-5 text-center">면허/자격증</div>
                  <div class="col-4 text-center">발급기관명</div>
                  <div class="col-3 text-center">발급일</div>
                </div>
                <div id="input-crtfct" class="row mx-1 py-2">
                  <div class="col-5 text-center"><input class="form-control" type="text"
                      name="crtfctList[0].crtfctNm" /></div>

                  <div class="col-4"><input class="form-control" type="text" name="crtfctList[0].issuInstNm" /></div>
                  <div class="col-3 position-relative"><input class="form-control" type="date"
                      name="crtfctList[0].crtfctDt" />
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                      stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                      class="feather feather-x form-control-icon del-btn">
                      <line x1="18" y1="6" x2="6" y2="18"></line>
                      <line x1="6" y1="6" x2="18" y2="18"></line>
                    </svg>
                  </div>
                </div>
                <div id="add-crtfct-div" class="row mx-1 py-2">
                  <div class="col-12 text-end position-relative">
                    <button type="button" id="add-crtfct-btn"
                      class="btn btn-sm waves-effect waves-light btn-outline-info">자격(면허)
                      추가</button>
                  </div>
                </div>
              </div>

              <div class="col">
                <h3>경력사항</h3>
              </div>
              <div class="card py-3">
                <div class="row mx-1 py-2" style="border-bottom: solid 1px #888;">
                  <div class="col-3 text-center">회사명</div>
                  <div class="col-4 text-center">입사월 ~ 퇴사월</div>
                  <div class="col-2 text-center">근무부서</div>
                  <div class="col-1 text-center">직급명</div>
                  <div class="col-2 text-center">재직여부</div>
                </div>
                <div id="input-career" class="row mx-1 py-2 ">
                  <div class="col-3 text-center"><input class="form-control" type="text" name="careerList[0].coNm" />
                  </div>
                  <div class="col-4"><input class="form-control d-inline-block" style="width: 45%;" type="month"
                      name="careerList[0].jncmpYm" /> ~
                    <input class="form-control d-inline-block" style="width: 45%;" type="month"
                      name="careerList[0].rsgntnYm" />
                  </div>
                  <div class="col-2"><input class="form-control" type="text" name="careerList[0].deptNm" /></div>
                  <div class="col-1"><input class="form-control px-0" type="text" name="careerList[0].jbgdNm" /></div>
                  <div class="col-2 position-relative">
                    <select class="form-control mr-sm-2" name="careerList[0].hdofYn">
                      <option value="Y">재직중</option>
                      <option selected value="N">퇴사</option>

                    </select>
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                      stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                      class="feather feather-x form-control-icon del-btn">
                      <line x1="18" y1="6" x2="6" y2="18"></line>
                      <line x1="6" y1="6" x2="18" y2="18"></line>
                    </svg>
                  </div>

                </div>
                <div id="add-career-div" class="row mx-1 py-2">
                  <div class="col-12 text-end">
                    <button type="button" id="add-career-btn"
                      class="btn btn-sm waves-effect waves-light btn-outline-info">경력사항 추가</button>
                  </div>
                </div>
              </div>

              <div class="col">
                <h3>기술 숙련도</h3>
              </div>
              <div class="card py-3">
                <div class="row mx-1 py-2" style="border-bottom: solid 1px #888;">
                  <div class="col-3 text-center">기술 스택명</div>
                  <div class="col-2 text-center">숙련도</div>
                  <div class="col-1 text-center"></div>
                  <div class="col-3 text-center">기술 스택명</div>
                  <div class="col-2 text-center">숙련도</div>
                  <div class="col-1 text-center"></div>
                </div>

                <div id="add-tech-div" class="row mx-1 py-2 ">

                  <div id="input-tech" class="row-con" style="width: 50%;">
                    <div class="col-6 text-center"><input class="form-control" name="techList[0].techNm"
                        type="text" /></div>
                    <div class="col-4">
                      <select class="form-control mr-sm-2" name="techList[0].skillLevel">
                        <option value="" selected>선택하세요</option>
                        <option value="3">상</option>
                        <option value="2">중</option>
                        <option value="1">하</option>
                      </select>
                    </div>
                    <div class="col-2"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                        viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round" class="feather feather-x form-control-icon del-btn2">
                        <line x1="18" y1="6" x2="6" y2="18"></line>
                        <line x1="6" y1="6" x2="18" y2="18"></line>
                      </svg></div>
                  </div>

                </div>

                <div class="row mx-1 py-2">
                  <div class="col-12 text-end">
                    <button type="button" id="add-tech-btn"
                      class="btn btn-sm waves-effect waves-light btn-outline-info">기술스택 추가</button>
                  </div>
                </div>
              </div>

              <div class="col">
                <h3>자기소개서</h3>
              </div>
              <div class="card py-3">
                <div class="row mx-1 py-2">
                  <textarea class="form-control" rows="7" id="resumeIntroConn" name="resumeIntroConn"></textarea>
                </div>
              </div>

              <div class="card py-0">
                <button type="submit" class="btn btn-lg waves-effect waves-light btn-primary">작성완료</button>
              </div>

            </div>
            <div class="col-2 res-remote"> <!-- 메뉴리모컨 -->
              <br><br>
              <div class="list-group res-remote-menu" style="background-color: white;">
                <a href="javascript:void(0)" class="list-group-item active">　이력서 작성　</a>
                <a href="javascript:void(0)" class="list-group-item">기본사항</a>
                <a href="javascript:void(0)" class="list-group-item">학력사항</a>
                <a href="javascript:void(0)" class="list-group-item">면허/자격증</a>
                <a href="javascript:void(0)" class="list-group-item">경력사항</a>
                <a href="javascript:void(0)" class="list-group-item">기술숙련도</a>
                <a href="javascript:void(0)" class="list-group-item">자기소개서</a>
              </div>

            </div>


          </div>
        </form>

        <!-- ============================================================== -->
        <!-- footer -->
        <!-- ============================================================== -->
        <footer class="footer text-center text-muted">
          All Rights Reserved by <a href="https://adminmart.com/">TTTT</a>.
        </footer>
        <!-- ============================================================== -->
        <!-- End footer -->
        <!-- ============================================================== -->
      </div>
    </div>
    <!-- ============================================================== -->
    <!-- End Page wrapper  -->
    <!-- ============================================================== -->
  </div>
  <script defer> // 항목 동적 추가 스크립트


var addTech = () => {}
    window.onload = function () {
      // 배열 index 값 counter
      var acbgCounter = 1;
      var crtfctCounter = 1;
      var careerCounter = 1;
      var techCounter = 1;

      // Get the template for the new elements
      var acbg_template = document.querySelector("#input-acbg").cloneNode(true);
      var crtfct_template = document.querySelector("#input-crtfct").cloneNode(true);
      var career_template = document.querySelector("#input-career").cloneNode(true);
      var tech_template = document.querySelector("#input-tech").cloneNode(true);

      // 학력사항
      document.getElementById('add-acbg-btn').addEventListener('click', function () {

        var newDiv = acbg_template.cloneNode(true);
        resetForm(newDiv, acbgCounter);

        var addButtonDiv = document.querySelector("#add-acbg-div");


        addButtonDiv.parentNode.insertBefore(newDiv, addButtonDiv);

        acbgCounter++;
      });

      // 자격사항
      document.getElementById('add-crtfct-btn').addEventListener('click', function () {

        var newDiv = crtfct_template.cloneNode(true);
        resetForm(newDiv, crtfctCounter);


        var addButtonDiv = document.querySelector("#add-crtfct-div");


        addButtonDiv.parentNode.insertBefore(newDiv, addButtonDiv);

        crtfctCounter++;
      });

      // 경력사항
      document.getElementById('add-career-btn').addEventListener('click', function () {

        var newDiv = career_template.cloneNode(true);
        resetForm(newDiv, careerCounter);


        var addButtonDiv = document.querySelector("#add-career-div");


        addButtonDiv.parentNode.insertBefore(newDiv, addButtonDiv);

        careerCounter++;
      });

      // 기술숙련도
      addTech = () => {
        var newDiv = tech_template.cloneNode(true);
        resetForm(newDiv, techCounter);


        var addButtonDiv = document.querySelector("#add-tech-div");


        addButtonDiv.insertAdjacentElement("beforeend", newDiv);
        techCounter++;
      }

      document.getElementById('add-tech-btn').addEventListener('click', function () {

        addTech() ;
      });

      document.addEventListener('click', function (e) {
        if (e.target && e.target.classList.contains('del-btn')) {
          e.target.closest('.row').remove();
        }
      });


      document.addEventListener('click', function (e) {
        if (e.target && e.target.classList.contains('del-btn2')) {
          e.target.closest('.row-con').remove();
        }
      });





      function resetForm(newDiv, idxCounter) {

        // input과 select의 value값 초기화
        var inputs = newDiv.querySelectorAll('input');
        inputs.forEach(input => input.value = '');

        var selects = newDiv.querySelectorAll('select');
        selects.forEach(select => select.selectedIndex = 0);

        // index값 변경
        var formElements = newDiv.querySelectorAll('select, input');
        formElements.forEach(function (element) {
          var name = element.getAttribute('name');
          if (name) {
            name = name.replace('[0]', '[' + idxCounter + ']');
            element.setAttribute('name', name);
          }
        });
      }
    }

  </script>
  <script> // 빈칸검증

    document.querySelector('#resumeForm').addEventListener('submit', function(event) {
      event.preventDefault();
  // 모든 input, textarea, select 필드를 가져옴
  var inputs = this.querySelectorAll('input, textarea, select');

  for (var i = 0; i < inputs.length; i++) {
    // 만약 필드가 비어있거나 선택되지 않았다면
    if (!inputs[i].value) {
      // 현재 이벤트를 중단 (폼 제출을 막음)
      event.preventDefault();
      // 경고 메시지를 표시
      alert('모든 필드를 입력해주세요.');
      // 해당 필드로 focus 이동
      inputs[i].focus();
      // 반복문 종료
      return;
    }
  }
  document.querySelector('#resumeForm').submit();
});

  </script>

  <script>//자동완성

    const autoComplete = () => {
    $(document).keydown(function (event) {
      if (event.keyCode == "220") {
        storageAutoComplete();
      }
    });
  };

  const storageAutoComplete = () => {
    document.getElementById("resumeNm").value = "실력으로 승부하는 개발자, 김취준입니다."; // 이력서 제목
    document.getElementById("highschNm").value = "오룡고등학교"; // 오룡고등학교
    $('#highschType').prop('selectedIndex',2);
    document.getElementById("highschGrdtnYm").value = "2017-02"; // 오룡고등학교
    $('select[name="acbgList[0].schlSeCd"]').prop('selectedIndex',2);
    $('input[name="acbgList[0].schlNm"]').val('오룡대학교');
    $('input[name="acbgList[0].departNm"]').val('컴퓨터공학과');
    $('input[name="acbgList[0].mtcltnYm"]').val('2017-03');
    $('input[name="acbgList[0].grdtnYm"]').val('2023-02');
    $('input[name="acbgList[0].userCredit"]').val('3.8');
    $('input[name="crtfctList[0].crtfctNm"]').val('정보처리기사');
    $('input[name="crtfctList[0].issuInstNm"]').val('한국산업인력공단');
    $('input[name="crtfctList[0].crtfctDt"]').val('2022-12-03');
    $('input[name="careerList[0].coNm"]').val('오류돈까스');
    $('input[name="careerList[0].jncmpYm"]').val('2022-07');
    $('input[name="careerList[0].rsgntnYm"]').val('2022-12');
    $('input[name="careerList[0].deptNm"]').val('외식사업부');
    $('input[name="careerList[0].jbgdNm"]').val('사원');
    $('input[name="techList[0].techNm"]').val('Java');
    $('select[name="techList[0].skillLevel"]').prop('selectedIndex',2);
    addTech();addTech();addTech();addTech();addTech();

    $('input[name="techList[1].techNm"]').val('Python');
    $('select[name="techList[1].skillLevel"]').prop('selectedIndex',1);
    $('input[name="techList[2].techNm"]').val('Node.js');
    $('select[name="techList[2].skillLevel"]').prop('selectedIndex',1);
    $('input[name="techList[3].techNm"]').val('JavaScript');
    $('select[name="techList[3].skillLevel"]').prop('selectedIndex',1);
    $('input[name="techList[4].techNm"]').val('CSS3');
    $('select[name="techList[4].skillLevel"]').prop('selectedIndex',1);
    $('input[name="techList[5].techNm"]').val('HTML5');
    $('select[name="techList[5].skillLevel"]').prop('selectedIndex',1);


    
    $('textarea[name="resumeIntroConn"]').val(`성장과정
[긍정은 나를 이끄는 원동력]

어렸을 적부터 항상 가져온 습관이 있습니다. 무엇이든 긍정적으로 생각하자는 마음가짐이었습니다. 사춘기가 왔을 무렵, 무슨 일이든 쉽게 포기하고 하기 싫어하는 제 자신이 있었습니다. 이때는 항상 부정적인 마음으로 가득했었습니다.

그때 방황의 시기를 거치고 있던 저에게 어머니가 앞으로의 제 인생을 결정 짓는 말씀을 하셨습니다. 무엇이든 마음먹기 달려있고, 긍정적으로 살다보면 행복이 뭔지 알 수 있다는 말이었습니다. 그 말에, 저는 많은 반성과 고민을 했습니다.

그 이후로 모든 일에 대하여 제 태도가 바뀌었습니다. 힘들어도, 기분이 안내킬때도, 화가 날때도 항상 다시 한번 생각을 깊게 해보는 습관이 생겼습니다. 그러고는 이내 긍정적으로, 웃으며 난 할 수 있다는 마음을 가졌습니다. 긍정은 어떠한 일에서도 성공을 이끌어냈고, 저를 좋게 평가할 수 있는 척도가 되었습니다. 긍정적인 마음은 항상 절 올바르게 이끌어온 제 자신의 바탕입니다.
성격의 장단점 및 특기
[개발자로서의 나의 장점과 바꿔나가야 할 단점]

개발자다운, 개발자가 꼭 가져야할 장점과 앞으로 바꿔나가야 할 단점을 주제로 제 자신을 소개하겠습니다.
저는 생각을 사람들에게 전달하지 못하는 단점이 있었습니다. 사람들의 말을 들어주는 것은 잘하지만 저의 생각을 전달하는 방법에 있어 익숙하지가 못했습니다.`);
  };
  autoComplete();
  </script>
  <!-- ============================================================== -->
  <!-- End Wrapper -->
  <!-- ============================================================== -->
  <!-- End Wrapper -->
  <!-- ============================================================== -->
  <!-- All Jquery -->
  <!-- ============================================================== -->
  <!-- ::: Footjs 시작 ::: -->
  <!-- apps -->
  <!-- apps -->
  <script src="${pageContext.request.contextPath}/dist/js/app-style-switcher.js"></script>
  <script src="${pageContext.request.contextPath}/dist/js/feather.min.js"></script>
  <!-- slimscrollbar scrollbar JavaScript -->
  <script
    src="${pageContext.request.contextPath}/assets/libs/perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/extra-libs/sparkline/sparkline.js"></script>
  <!--Wave Effects -->
  <!-- themejs -->
  <!--Menu sidebar -->
  <script src="${pageContext.request.contextPath}/dist/js/sidebarmenu.js"></script>
  <!--Custom JavaScript -->
  <script src="${pageContext.request.contextPath}/dist/js/custom.min.js"></script>
  <!-- SweetAlert2 -->
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.12/dist/sweetalert2.all.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.12/dist/sweetalert2.min.css" rel="stylesheet">
  <!-- ::: Footjs 끝 ::: -->
</body>

</html>