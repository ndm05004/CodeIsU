<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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
                            <a href="${pageContext.request.contextPath}/">
                                <img src="${pageContext.request.contextPath}/resources/common/img/nav_logo.png" alt="" class="img-fluid">
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
                                            <input class="form-control custom-shadow custom-radius border-0 bg-white"
                                                type="search" placeholder="Search" aria-label="Search">
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
                                    <img src="${pageContext.request.contextPath}<sec:authentication property='principal.member.userProfile'/>" alt="user" class="rounded-circle"
                                        width="40">
                                    <span class="ms-2 d-none d-lg-inline-block"><span class="text-dark"><sec:authentication property="principal.member.userNm"/></span><span>님 (원생)</span> <i data-feather="chevron-down"
                                            class="svg-icon"></i></span>
                                </a>
                                <div class="dropdown-menu dropdown-menu-end dropdown-menu-right user-dd animated flipInY">
                                    <a class="dropdown-item" href="/stu/mypage/modify"><i data-feather="user"
                                            class="svg-icon me-2 ms-1"></i>
                                        회원정보 변경</a>

                                    <div class="dropdown-divider"></div>


                                    <a class="dropdown-item" href="/user/logout"><i data-feather="power"
                                            class="svg-icon me-2 ms-1"></i>
                                        로그아웃</a>

                                </div>
                            </li>
                            <!-- ============================================================== -->
                            <!-- User profile and search -->
                            <!-- ============================================================== -->
                                                    <!-- Notification -->

                                                    <li class="nav-item dropdown d-none">
                                                        <a class="nav-link dropdown-toggle pl-md-3 position-relative" href="javascript:void(0)"
                                                            id="bell" role="button" data-bs-toggle="dropdown" aria-haspopup="true"
                                                            aria-expanded="false">
                                                            <span><i data-feather="bell" class="svg-icon"></i></span>
                                                            <span class="badge text-bg-primary notify-no rounded-circle">5</span>
                                                        </a>
                                                        <div class="dropdown-menu dropdown-menu-end mailbox animated bounceInDown">
                                                            <ul class="list-style-none">
                                                                <li>
                                                                    <div class="message-center notifications position-relative">
                                                                        <!-- Message -->
                                                                        <a href="javascript:void(0)"
                                                                            class="message-item d-flex align-items-center border-bottom px-3 py-2">
                                                                            <div class="btn btn-danger rounded-circle btn-circle"><i
                                                                                    data-feather="airplay" class="text-white"></i></div>
                                                                            <div class="w-75 d-inline-block v-middle ps-2">
                                                                                <h6 class="message-title mb-0 mt-1">Luanch Admin</h6>
                                                                                <span class="font-12 text-nowrap d-block text-muted">Just see
                                                                                    the my new
                                                                                    admin!</span>
                                                                                <span class="font-12 text-nowrap d-block text-muted">9:30 AM</span>
                                                                            </div>
                                                                        </a>
                                                                        <!-- Message -->
                                                                        <a href="javascript:void(0)"
                                                                            class="message-item d-flex align-items-center border-bottom px-3 py-2">
                                                                            <span class="btn btn-success text-white rounded-circle btn-circle"><i
                                                                                    data-feather="calendar" class="text-white"></i></span>
                                                                            <div class="w-75 d-inline-block v-middle ps-2">
                                                                                <h6 class="message-title mb-0 mt-1">Event today</h6>
                                                                                <span
                                                                                    class="font-12 text-nowrap d-block text-muted text-truncate">Just
                                                                                    a reminder that you have event</span>
                                                                                <span class="font-12 text-nowrap d-block text-muted">9:10 AM</span>
                                                                            </div>
                                                                        </a>
                                                                        <!-- Message -->
                                                                        <a href="javascript:void(0)"
                                                                            class="message-item d-flex align-items-center border-bottom px-3 py-2">
                                                                            <span class="btn btn-info rounded-circle btn-circle"><i
                                                                                    data-feather="settings" class="text-white"></i></span>
                                                                            <div class="w-75 d-inline-block v-middle ps-2">
                                                                                <h6 class="message-title mb-0 mt-1">Settings</h6>
                                                                                <span
                                                                                    class="font-12 text-nowrap d-block text-muted text-truncate">You
                                                                                    can customize this template
                                                                                    as you want</span>
                                                                                <span class="font-12 text-nowrap d-block text-muted">9:08 AM</span>
                                                                            </div>
                                                                        </a>
                                                                        <!-- Message -->
                                                                        <a href="javascript:void(0)"
                                                                            class="message-item d-flex align-items-center border-bottom px-3 py-2">
                                                                            <span class="btn btn-primary rounded-circle btn-circle"><i
                                                                                    data-feather="box" class="text-white"></i></span>
                                                                            <div class="w-75 d-inline-block v-middle ps-2">
                                                                                <h6 class="message-title mb-0 mt-1">Pavan kumar</h6> <span
                                                                                    class="font-12 text-nowrap d-block text-muted">Just
                                                                                    see the my admin!</span>
                                                                                <span class="font-12 text-nowrap d-block text-muted">9:02 AM</span>
                                                                            </div>
                                                                        </a>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <a class="nav-link pt-3 text-center text-dark" href="javascript:void(0);">
                                                                        <strong>Check all notifications</strong>
                                                                        <i class="fa fa-angle-right"></i>
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </li>

                                                    <!-- End Notification -->
                        </ul>
                    </div>
                </nav>
            </header>
        </div>