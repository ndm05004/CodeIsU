<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<div class="center-wrap">
	<header class="topbar center-wrap" data-navbarbg="skin6">
		<nav class="navbar top-navbar navbar-expand-lg">
			<div class="navbar-header" data-logobg="skin6">
				<!-- This is for the sidebar toggle which is visible on mobile only -->
				<a class="nav-toggler waves-effect waves-light d-block d-lg-none" href="javascript:void(0)"><i class="ti-menu ti-close"></i></a>
				<!-- ============================================================== -->
				<!-- Logo -->
				<!-- ============================================================== -->
				<div class="navbar-brand">
					<!-- Logo icon -->
					<a href="/"> <img src="${pageContext.request.contextPath}/resources/common/img/nav_logo.png" alt="" class="img-fluid">
					</a>
				</div>
				<!-- ============================================================== -->
				<!-- End Logo -->
				<!-- ============================================================== -->
				<!-- ============================================================== -->
				<!-- Toggle which is visible on mobile only -->
				<!-- ============================================================== -->
				<a class="topbartoggler d-block d-lg-none waves-effect waves-light" href="javascript:void(0)" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><i class="ti-more"></i></a>
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
						<li class="nav-item col-4 col-md-auto"><a class="nav-link fw-bold" href="javascript:goToMenu('emp_notice')" onclick="ga('send', 'event', 'Navbar', 'Community links', 'Bootstrap');">공지사항</a></li>
						<li class="nav-item col-4 col-md-auto"><a class="nav-link fw-bold" aria-current="true" href="javascript:goToMenu('emp_svlf')" onclick="ga('send', 'event', 'Navbar', 'Community links', 'Docs');">원생관리</a></li>
						<li class="nav-item col-4 col-md-auto"><a class="nav-link fw-bold" href="javascript:goToMenu('emp_sbjctList')" onclick="ga('send', 'event', 'Navbar', 'Community links', 'Examples');">수업관리</a></li>
						<li class="nav-item col-4 col-md-auto"><a class="nav-link fw-bold" href="javascript:goToMenu('emp_cmcode')" onclick="ga('send', 'event', 'Navbar', 'Community links', 'Icons');" rel="noopener">공통코드관리</a></li>
						<li class="nav-item col-4 col-md-auto"><a class="nav-link fw-bold" href="/qrcheck/qrcode" target='_blank' onclick="ga('send', 'event', 'Navbar', 'Community links', 'Icons');" rel="noopener">스마트 QR출결</a></li>

					</ul>

				</ul>
				<!-- ============================================================== -->
				<!-- Right side toggle and nav items -->
				<!-- ============================================================== -->
				<ul class="navbar-nav float-end">
					<!-- ============================================================== -->
					<!-- Search -->
					<!-- ============================================================== -->
					<li class="nav-item d-none"><a class="nav-link" href="javascript:void(0)">
							<form>
								<div class="customize-input">
									<input class="form-control custom-shadow custom-radius border-0 bg-white" type="search" placeholder="Search" aria-label="Search"> <i class="form-control-icon" data-feather="search"></i>
								</div>
							</form>
					</a></li>
					<!-- ============================================================== -->
					<!-- User profile and search -->
					<!-- ============================================================== -->
					<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="javascript:void(0)" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <img src="${pageContext.request.contextPath}<sec:authentication property='principal.member.userProfile'/>" alt="user" class="rounded-circle" width="40"> <span class="ms-2 d-none d-lg-inline-block"><span class="text-dark"><sec:authentication property="principal.member.userNm" /></span>
					<span>님 (행정직원)
							</span> <i data-feather="chevron-down" class="svg-icon"></i></span>
					</a>
						<div class="dropdown-menu dropdown-menu-end dropdown-menu-right user-dd animated flipInY">


							<a class="dropdown-item" href="javascript:goToMenu('logout')"><i data-feather="power" class="svg-icon me-2 ms-1"></i> 로그아웃</a>

						</div></li>
					<!-- ============================================================== -->
					<!-- User profile and search -->
					<!-- ============================================================== -->

				</ul>
			</div>
		</nav>
	</header>
</div>