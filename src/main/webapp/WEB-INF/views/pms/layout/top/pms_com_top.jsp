<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
    <!-- 왼쪽 네비바 -->
    <aside class="sidenav navbar navbar-vertical navbar-expand-xskt border-0 border-radius-xl my-3 ms-1   bg-gradient-dark"
      id="sidenav-main">

      <div class="sidenav-header">
        <i class="fas fa-times p-3 cursor-pointer text-white opacity-5 position-absolute end-0 top-0 d-none d-xl-none"
          aria-hidden="true" id="iconSidenav"></i>
        <a class="navbar-brand m-0" href="javascript:goToMenu('stu_stumain')"  target="_blank">
          target="_blank">
          <img src="${pageContext.request.contextPath}/pms/assets/img/ddit_logo02.png" class="navbar-brand-img h-100" alt="main_logo"><br>
          <span class="ms-1 font-weight-bold text-white">CODE IS U</span>
        </a>
      </div>


      <hr class="horizontal light mt-0 mb-2">

	<div class=" navbar-collapse  w-auto " id="sidenav-collapse-main">
		<ul class="navbar-nav">




			<li class="nav-item"><a class="nav-link text-white" href="/pms/dashboard.html">
					<div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
						<i class="material-icons opacity-10">dashboard</i>
					</div>
					<span class="nav-link-text ms-1">프로젝트 목록</span>

			</a></li>

			<li class="nav-item"><a class="nav-link text-white " href="${pageContext.request.contextPath}/pms/tables.html">

					<div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
						<i class="material-icons opacity-10">table_view</i>
					</div>
					<span href="javascript:goToMenu('pms_myprojects')" class="nav-link-text ms-1">내 프로젝트</span>
			</a></li>



		</ul>
	</div>


</aside>

    <main class="main-content border-radius-lg main-content-ktmar">
      <!-- Navbar -->

      <nav class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl" id="navbarBlur"
        data-scroll="true">
        <div class="container-fluid py-1 px-3">
          <nav aria-label="breadcrumb">

            <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5">
              <li class="breadcrumb-item text-sm"><a class="opacity-5 text-dark" href="javascript:;">Pages</a></li>
              <li class="breadcrumb-item text-sm text-dark active" aria-current="page">index</li>
            </ol>
            <h6 class="font-weight-bolder mb-0">index</h6>

          </nav>
          <div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4" id="navbar">
            <div class="ms-md-auto pe-md-3 d-flex align-items-center">

              <div class="input-group input-group-outline">
                <label class="form-label">Type here...</label>
                <input type="text" class="form-control">
              </div>

            </div>
            <ul class="navbar-nav  justify-content-end">



              <ul class="navbar-nav  justify-content-end">
                <li class="nav-item d-flex align-items-center">

                </li>

              <!--알람-->

              <li class="nav-item dropdown px-2 d-flex align-items-center">

                <a href="javascript:;" class="nav-link text-body p-0" id="dropdownMenuButton" data-bs-toggle="dropdown"
                  aria-expanded="false">
                 <i class="material-icons opacity-10">notifications</i>
										<!--  <i class="fa fa-bell cursor-pointer"></i> -->
                </a>

                <ul class="dropdown-menu  dropdown-menu-end  px-2 py-3 me-sm-n4" aria-labelledby="dropdownMenuButton">

                </ul>
              </li>
              <!--알람끝-->


                <li class="nav-item d-flex align-items-center">　</li>

                <li class="nav-item">
                  <div class="d-flex align-items-center justify-content-between">
                  <div class="avatar-group mt-2 avatar avatar-xs rounded-circle">
                    <img alt="Image placeholder" src="${pageContext.request.contextPath}/pms/assets/img/team-1.jpg" style="width:40px;">
                  </div>
                  </div>
                </li>

                <li class="nav-item d-flex align-items-center">　</li>
                <li class="nav-item d-flex align-items-center">
                  <div class="d-flex flex-column justify-content-center">
                    <h6 class="mb-0 text-sm">홍기태 님</h6>
                    <p class="text-xs text-secondary mb-0">aa@aa.aa</p>
                  </div>
                </li>
                <li class="nav-item d-flex align-items-center">　</li>

                <li class="nav-item d-flex align-items-center">
                  <a href="${pageContext.request.contextPath}/user/logout" class="nav-link text-body font-weight-bold px-0">
                  <i class="fa fa-user me-sm-1" aria-hidden="true"></i>
                  <span class="d-sm-inline d-none">로그아웃</span>
                  </a>
                </li>

              </ul>


              <!-- <li class="nav-item px-3 d-flex align-items-center">
                <a href="javascript:;" class="nav-link text-body p-0">
                  <i class="fa fa-cog fixed-plugin-button-nav cursor-pointer"></i>
                </a>
              </li>

              <li class="nav-item d-flex align-items-center">
                <a href="${pageContext.request.contextPath}/pms/pages/sign-in.html" class="nav-link text-body font-weight-bold px-0">
                  <i class="fa fa-user me-sm-1"></i>

                  <span class="d-sm-inline d-none">Sign In</span>

                </a>
              </li> -->
            </ul>
          </div>
        </div>
      </nav>

      <!-- End Navbar -->





      <div class="container-fluid py-4">
<!-- 커스텀 서브 navbar -->

<div class="container mt-3">
  <h2>프로젝트</h2>

  <ul class="nav me">
    <li class="nav-item">
      <a class="nav-link nav-link0" href="#">대시보드</a>
    </li>
    <li class="nav-item">
      <a class="nav-link nav-link0" href="#">일감</a>
    </li>
    <li class="nav-item">
      <a class="nav-link nav-link0" href="#">간트차트</a>
    </li>
    <li class="nav-item">
      <a class="nav-link nav-link0" href="#">칸반보드</a>
    </li>
    <li class="nav-item">
      <a class="nav-link nav-link0" href="#">캘린더</a>
    </li>
    <li class="nav-item">
      <a class="nav-link nav-link0" href="#">이슈</a>
    </li>
    <li class="nav-item">
      <a class="nav-link nav-link0" href="#">게시판</a>
    </li>
    <li class="nav-item">
      <a class="nav-link nav-link0" href="#">멤버관리</a>
    </li>

  </ul>
</div>

<!-- 커스텀 서브 navbar -->