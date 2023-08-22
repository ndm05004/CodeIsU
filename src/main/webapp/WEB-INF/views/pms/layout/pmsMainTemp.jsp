<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://tiles.apache.org/tags-tiles"
prefix="tiles"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%> <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <link
      rel="apple-touch-icon"
      sizes="76x76"
      href="${pageContext.request.contextPath}/pms/assets/img/apple-icon.png"
    />
    <link
      rel="icon"
      type="image/png"
      href="${pageContext.request.contextPath}/pms/assets/img/favicon.png"
    />
    <title>Material Dashboard 2 by Creative Tim</title>
    <!--     Fonts and icons     -->
    <link
      rel="stylesheet"
      type="text/css"
      href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700"
    />
    <!-- Nucleo Icons  -->
    <link
      href="${pageContext.request.contextPath}/pms/assets/css/nucleo-icons.css"
      rel="stylesheet"
    />
    <link
      href="${pageContext.request.contextPath}/pms/assets/css/nucleo-svg.css"
      rel="stylesheet"
    />
    <!-- Font Awesome Icons -->
    <script
      src="https://kit.fontawesome.com/42d5adcbca.js"
      crossorigin="anonymous"
    ></script>
    <!-- Material Icons -->
    <link
      href="https://fonts.googleapis.com/icon?family=Material+Icons+Round"
      rel="stylesheet"
    />
    <!-- CSS Files -->
    <link
      id="pagestyle"
      href="${pageContext.request.contextPath}/pms/assets/css/material-dashboard.css"
      rel="stylesheet"
    />
    <!-- j쿼리 -->
    <script src="${pageContext.request.contextPath}/assets/libs/jquery/dist/jquery.min.js"></script>

    <!-- Custom $t Js -->
    <script>
      var $t = {
        header: "${_csrf.headerName}",
        token: "${_csrf.token}",
        csrfq: "${_csrf.parameterName }=${_csrf.token}",
        cpath: "${pageContext.request.contextPath}",
      };
    </script>
    <script
      src="${pageContext.request.contextPath}/resources/common/js/common.js"
      type="text/javascript"
    ></script>

    <!--   커스텀 CSS -->

    <style>
      .nav-link0 {
        color: #252323;
      }
      .nav-link0:hover {
        color: #252323;
        text-decoration: underline;
        text-decoration-color: #495b8a;
        text-decoration-thickness: 2px;
      }
    </style>

    <!--   커스텀 CSS 끝 -->
  </head>

  <body>
    <div class="center-wrap">
      <div class="bg-gray-200">
        <aside
          class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 ms-3 bg-gradient-dark"
          id="sidenav-main"
        >
          <div class="sidenav-header">
            <i
              class="fas fa-times p-3 cursor-pointer text-white opacity-5 position-absolute end-0 top-0 d-none d-xl-none"
              aria-hidden="true"
              id="iconSidenav"
            ></i>
            <a
              class="navbar-brand m-0"
              href="javascript:goToMenu('stu_stumain')"
            >
              <img
                src="${pageContext.request.contextPath}/pms/assets/img/ddit_logo05.png"
                class="navbar-brand-img h-100"
                alt="main_logo"
              />
            </a>
          </div>
          <hr class="horizontal light mt-0 mb-2" />
          <div
            class="collapse navbar-collapse w-auto"
            id="sidenav-collapse-main"
          >
            <ul class="navbar-nav">
              <li class="nav-item">
                <a
                  class="nav-link text-white"
                  href="javascript:goToMenu('pms_main')"
                >
                  <div
                    class="text-white text-center me-2 d-flex align-items-center justify-content-center"
                  >
                    <i class="material-icons opacity-10">dashboard</i>
                    <span
                      href="javascript:goToMenu('pms_main')"
                      class="nav-link-text ms-1"
                      >프로젝트 목록</span
                    >
                  </div>
                </a>
              </li>

              <li class="nav-item">
                <a
                  id="projNav"
                  data-bs-toggle="collapse"
                  href="#applicationsExamples"
                  class="nav-link text-white"
                  aria-controls="applicationsExamples"
                  role="button"
                  aria-expanded="false"
                >
                  <div
                    class="row text-white text-center me-2 d-flex align-items-center justify-content-center"
                  >
                    <div class="col-2">
                      <i class="pe-2 material-icons opacity-10">view_list</i>
                    </div>
                    <div class="col-10">
                      <span class="nav-link-text ms-1">내 프로젝트</span>
                    </div>
                  </div>
                </a>

                <div class="collapse" id="applicationsExamples">
                  <ul class="nav">
                    <li id="navlist" class="nav-item"></li>
                  </ul>
                </div>
              </li>
            </ul>
          </div>
          <div class="sidenav-footer position-absolute w-100 bottom-0">
            <div class="mx-3">
              <a
                class="btn btn-outline-info mt-4 w-100"
                href="https://www.creative-tim.com/learning-lab/bootstrap/overview/material-dashboard?ref=sidebarfree"
                type="button"
                >Documentation</a
              >
              <a
                class="btn bg-gradient-info w-100"
                href="https://www.creative-tim.com/product/material-dashboard-pro?ref=sidebarfree"
                type="button"
                >Upgrade to pro</a
              >
            </div>
          </div>
        </aside>
        <main
          class="main-content position-relative max-height-vh-100 h-100 border-radius-lg main-content-ktmar"
        >
          <!-- Navbar -->
          <nav
            class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl"
            id="navbarBlur"
            data-scroll="true"
          >
            <div class="container-fluid py-1 px-3">
              <nav aria-label="breadcrumb">
                <ol
                  class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5"
                >
                  <li class="breadcrumb-item text-sm">
                    <a class="opacity-5 text-dark" href="javascript:;">Pages</a>
                  </li>
                  <li
                    class="breadcrumb-item text-sm text-dark active"
                    aria-current="page"
                  >
                    Notifications
                  </li>
                </ol>
                <h6 class="font-weight-bolder mb-0">Notifications</h6>
              </nav>
              <div
                class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4"
                id="navbar"
              >
                <div class="ms-md-auto pe-md-3 d-flex align-items-center">
                  <div class="input-group input-group-outline">
                    <label class="form-label">Type here...</label>
                    <input type="text" class="form-control" />
                  </div>
                </div>
                <ul class="navbar-nav justify-content-end">
                  <ul class="navbar-nav justify-content-end">
                    <li class="nav-item d-flex align-items-center"></li>

                    <!--알람-->

                    <li
                      class="nav-item dropdown px-2 d-flex align-items-center"
                    >
                      <a
                        href="javascript:;"
                        class="nav-link text-body p-0"
                        id="dropdownMenuButton"
                        data-bs-toggle="dropdown"
                        aria-expanded="false"
                      >
                        <i class="far fa-bell" id="bell"></i>
                      </a>

                      <ul
                        class="dropdown-menu dropdown-menu-end px-2 py-3 me-sm-n4"
                        aria-labelledby="dropdownMenuButton"
                      >
                        <li class="mb-2">
                          <a
                            class="dropdown-item border-radius-md"
                            href="javascript:;"
                          >
                            <div class="d-flex py-1">
                              <div class="my-auto">
                                <img
                                  src="${pageContext.request.contextPath}/pms/assets/img/team-2.jpg"
                                  class="avatar avatar-sm me-3"
                                />
                              </div>
                              <div
                                class="d-flex flex-column justify-content-center"
                              >
                                <h6 class="text-sm font-weight-normal mb-1">
                                  <span class="font-weight-bold"
                                    >New message</span
                                  >
                                  from Laur
                                </h6>
                                <p class="text-xs text-secondary mb-0">
                                  <i class="fa fa-clock me-1"></i>
                                  13 minutes ago
                                </p>
                              </div>
                            </div>
                          </a>
                        </li>
                        <li class="mb-2">
                          <a
                            class="dropdown-item border-radius-md"
                            href="javascript:;"
                          >
                            <div class="d-flex py-1">
                              <div class="my-auto">
                                <img
                                  src="${pageContext.request.contextPath}/pms/assets/img/small-logos/logo-spotify.svg"
                                  class="avatar avatar-sm bg-gradient-dark me-3"
                                />
                              </div>
                              <div
                                class="d-flex flex-column justify-content-center"
                              >
                                <h6 class="text-sm font-weight-normal mb-1">
                                  <span class="font-weight-bold"
                                    >New album</span
                                  >
                                  by Travis Scott
                                </h6>
                                <p class="text-xs text-secondary mb-0">
                                  <i class="fa fa-clock me-1"></i>
                                  1 day
                                </p>
                              </div>
                            </div>
                          </a>
                        </li>
                        <li>
                          <a
                            class="dropdown-item border-radius-md"
                            href="javascript:;"
                          >
                            <div class="d-flex py-1">
                              <div
                                class="avatar avatar-sm bg-gradient-secondary me-3 my-auto"
                              >
                                <svg
                                  width="12px"
                                  height="12px"
                                  viewBox="0 0 43 36"
                                  version="1.1"
                                  xmlns="http://www.w3.org/2000/svg"
                                  xmlns:xlink="http://www.w3.org/1999/xlink"
                                >
                                  <title>credit-card</title>
                                  <g
                                    stroke="none"
                                    stroke-width="1"
                                    fill="none"
                                    fill-rule="evenodd"
                                  >
                                    <g
                                      transform="translate(-2169.000000, -745.000000)"
                                      fill="#FFFFFF"
                                      fill-rule="nonzero"
                                    >
                                      <g
                                        transform="translate(1716.000000, 291.000000)"
                                      >
                                        <g
                                          transform="translate(453.000000, 454.000000)"
                                        >
                                          <path
                                            class="color-background"
                                            d="M43,10.7482083 L43,3.58333333 C43,1.60354167 41.3964583,0 39.4166667,0 L3.58333333,0 C1.60354167,0 0,1.60354167 0,3.58333333 L0,10.7482083 L43,10.7482083 Z"
                                            opacity="0.593633743"
                                          ></path>
                                          <path
                                            class="color-background"
                                            d="M0,16.125 L0,32.25 C0,34.2297917 1.60354167,35.8333333 3.58333333,35.8333333 L39.4166667,35.8333333 C41.3964583,35.8333333 43,34.2297917 43,32.25 L43,16.125 L0,16.125 Z M19.7083333,26.875 L7.16666667,26.875 L7.16666667,23.2916667 L19.7083333,23.2916667 L19.7083333,26.875 Z M35.8333333,26.875 L28.6666667,26.875 L28.6666667,23.2916667 L35.8333333,23.2916667 L35.8333333,26.875 Z"
                                          ></path>
                                        </g>
                                      </g>
                                    </g>
                                  </g>
                                </svg>
                              </div>
                              <div
                                class="d-flex flex-column justify-content-center"
                              >
                                <h6 class="text-sm font-weight-normal mb-1">
                                  Payment successfully completed
                                </h6>
                                <p class="text-xs text-secondary mb-0">
                                  <i class="fa fa-clock me-1"></i>
                                  2 days
                                </p>
                              </div>
                            </div>
                          </a>
                        </li>
                      </ul>
                    </li>
                    <!--알람끝-->

                    <li class="nav-item d-flex align-items-center">　</li>

                    <li class="nav-item">
                      <div
                        class="d-flex align-items-center justify-content-between"
                      >
                        <div
                          class="avatar-group mt-2 avatar avatar-xs rounded-circle"
                        >
                          <img
                            alt="Image placeholder"
                            src="${pageContext.request.contextPath}<sec:authentication property='principal.member.userProfile'/>"
                            style="width: 40px"
                          />
                        </div>
                      </div>
                    </li>

                    <li class="nav-item d-flex align-items-center">　</li>
                    <li class="nav-item d-flex align-items-center">
                      <div class="d-flex flex-column justify-content-center">
                        <h6 class="mb-0 text-sm">
                          <sec:authentication
                            property="principal.member.userNm"
                          />
                          님
                        </h6>
                        <p class="text-xs text-secondary mb-0 d-none"></p>
                      </div>
                    </li>
                    <li class="nav-item d-flex align-items-center">　</li>

                    <li class="nav-item d-flex align-items-center">
                      <a
                        href="${pageContext.request.contextPath}/user/logout"
                        class="nav-link text-body font-weight-bold px-0"
                      >
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
                  <!-- 									<div class="card-header p-3"> -->
                  <!-- 										<h5 class="mb-0">여기에 제목</h5> -->
                  <!-- 									</div> -->
                  <div class="card-body p-3 pb-0">
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

                    <tiles:insertAttribute name="content" />
                  </div>
                </div>
              </div>
            </div>
            <div class="position-fixed bottom-1 end-1 z-index-2">
              <div
                class="toast fade hide p-2 bg-white"
                role="alert"
                aria-live="assertive"
                id="successToast"
                aria-atomic="true"
              >
                <div class="toast-header border-0">
                  <i class="material-icons text-success me-2"> check </i>
                  <span class="me-auto font-weight-bold"
                    >Material Dashboard
                  </span>
                  <small class="text-body">11 mins ago</small>
                  <i
                    class="fas fa-times text-md ms-3 cursor-pointer"
                    data-bs-dismiss="toast"
                    aria-label="Close"
                  ></i>
                </div>
                <hr class="horizontal dark m-0" />
                <div class="toast-body">
                  Hello, world! This is a notification message.
                </div>
              </div>
              <div
                class="toast fade hide p-2 mt-2 bg-gradient-info"
                role="alert"
                aria-live="assertive"
                id="infoToast"
                aria-atomic="true"
              >
                <div class="toast-header bg-transparent border-0">
                  <i class="material-icons text-white me-2"> notifications </i>
                  <span class="me-auto text-white font-weight-bold"
                    >Material Dashboard
                  </span>
                  <small class="text-white">11 mins ago</small>
                  <i
                    class="fas fa-times text-md text-white ms-3 cursor-pointer"
                    data-bs-dismiss="toast"
                    aria-label="Close"
                  ></i>
                </div>
                <hr class="horizontal light m-0" />
                <div class="toast-body text-white">
                  Hello, world! This is a notification message.
                </div>
              </div>
              <div
                class="toast fade hide p-2 mt-2 bg-white"
                role="alert"
                aria-live="assertive"
                id="warningToast"
                aria-atomic="true"
              >
                <div class="toast-header border-0">
                  <i class="material-icons text-warning me-2">
                    travel_explore
                  </i>
                  <span class="me-auto font-weight-bold"
                    >Material Dashboard
                  </span>
                  <small class="text-body">11 mins ago</small>
                  <i
                    class="fas fa-times text-md ms-3 cursor-pointer"
                    data-bs-dismiss="toast"
                    aria-label="Close"
                  ></i>
                </div>
                <hr class="horizontal dark m-0" />
                <div class="toast-body">
                  Hello, world! This is a notification message.
                </div>
              </div>
              <div
                class="toast fade hide p-2 mt-2 bg-white"
                role="alert"
                aria-live="assertive"
                id="dangerToast"
                aria-atomic="true"
              >
                <div class="toast-header border-0">
                  <i class="material-icons text-danger me-2"> campaign </i>
                  <span
                    class="me-auto text-gradient text-danger font-weight-bold"
                    >Material Dashboard
                  </span>
                  <small class="text-body">11 mins ago</small>
                  <i
                    class="fas fa-times text-md ms-3 cursor-pointer"
                    data-bs-dismiss="toast"
                    aria-label="Close"
                  ></i>
                </div>
                <hr class="horizontal dark m-0" />
                <div class="toast-body">
                  Hello, world! This is a notification message.
                </div>
              </div>
            </div>
            <footer class="footer py-4">
              <div class="container-fluid">
                <div class="row align-items-center justify-content-lg-between">
                  <div class="col-lg-6 mb-lg-0 mb-4">
                    <div
                      class="copyright text-center text-sm text-muted text-lg-start"
                    >
                      중간평가까지 D -
                      <script>
                        var currentDate = new Date();
                        var ddayDate = new Date(
                          currentDate.getFullYear(),
                          6,
                          21
                        );

                        var timeDiff =
                          ddayDate.getTime() - currentDate.getTime();
                        var daysDiff = Math.ceil(timeDiff / (1000 * 3600 * 24));

                        document.write(daysDiff);
                      </script>
                      ,
                      <a
                        href="https://www.creative-tim.com"
                        class="font-weight-bold"
                        target="_blank"
                        >TTTT</a
                      >
                      ㅎ
                    </div>
                  </div>
                  <div class="col-lg-6">
                    <ul
                      class="nav nav-footer justify-content-center justify-content-lg-end"
                    >
                      <li class="nav-item">
                        <a
                          href="https://www.creative-tim.com"
                          class="nav-link text-muted"
                          target="_blank"
                          >끝까지</a
                        >
                      </li>
                      <li class="nav-item">
                        <a
                          href="https://www.creative-tim.com/presentation"
                          class="nav-link text-muted"
                          target="_blank"
                          >화이팅</a
                        >
                      </li>
                      <li class="nav-item">
                        <a
                          href="https://www.creative-tim.com/blog"
                          class="nav-link text-muted"
                          target="_blank"
                          >시간은</a
                        >
                      </li>
                      <li class="nav-item">
                        <a
                          href="https://www.creative-tim.com/license"
                          class="nav-link pe-0 text-muted"
                          target="_blank"
                          >금방간다</a
                        >
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </footer>
          </div>
        </main>
        <div class="fixed-plugin">
          <a class="fixed-plugin-button text-dark position-fixed px-3 py-2">
            <i class="material-icons py-2">settings</i>
          </a>
          <div class="card shadow-lg">
            <div class="card-header pb-0 pt-3">
              <div class="float-start">
                <h5 class="mt-3 mb-0">Material UI Configurator</h5>
                <p>See our dashboard options.</p>
              </div>
              <div class="float-end mt-4">
                <button
                  class="btn btn-link text-dark p-0 fixed-plugin-close-button"
                >
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
              <a
                href="javascript:void(0)"
                class="switch-trigger background-color"
              >
                <div class="badge-colors my-2 text-start">
                  <span
                    class="badge filter bg-gradient-primary active"
                    data-color="primary"
                    onclick="sidebarColor(this)"
                  ></span>
                  <span
                    class="badge filter bg-gradient-dark"
                    data-color="dark"
                    onclick="sidebarColor(this)"
                  ></span>
                  <span
                    class="badge filter bg-gradient-info"
                    data-color="info"
                    onclick="sidebarColor(this)"
                  ></span>
                  <span
                    class="badge filter bg-gradient-success"
                    data-color="success"
                    onclick="sidebarColor(this)"
                  ></span>
                  <span
                    class="badge filter bg-gradient-warning"
                    data-color="warning"
                    onclick="sidebarColor(this)"
                  ></span>
                  <span
                    class="badge filter bg-gradient-danger"
                    data-color="danger"
                    onclick="sidebarColor(this)"
                  ></span>
                </div>
              </a>
              <!-- Sidenav Type -->
              <div class="mt-3">
                <h6 class="mb-0">Sidenav Type</h6>
                <p class="text-sm">Choose between 2 different sidenav types.</p>
              </div>
              <div class="d-flex">
                <button
                  class="btn bg-gradient-dark px-3 mb-2 active"
                  data-class="bg-gradient-dark"
                  onclick="sidebarType(this)"
                >
                  Dark
                </button>
                <button
                  class="btn bg-gradient-dark px-3 mb-2 ms-2"
                  data-class="bg-transparent"
                  onclick="sidebarType(this)"
                >
                  Transparent
                </button>
                <button
                  class="btn bg-gradient-dark px-3 mb-2 ms-2"
                  data-class="bg-white"
                  onclick="sidebarType(this)"
                >
                  White
                </button>
              </div>
              <p class="text-sm d-xl-none d-block mt-2">
                You can change the sidenav type just on desktop view.
              </p>
              <!-- Navbar Fixed -->
              <div class="mt-3 d-flex">
                <h6 class="mb-0">Navbar Fixed</h6>
                <div class="form-check form-switch ps-0 ms-auto my-auto">
                  <input
                    class="form-check-input mt-1 ms-auto"
                    type="checkbox"
                    id="navbarFixed"
                    onclick="navbarFixed(this)"
                  />
                </div>
              </div>
              <hr class="horizontal dark my-3" />
              <div class="mt-2 d-flex">
                <h6 class="mb-0">Light / Dark</h6>
                <div class="form-check form-switch ps-0 ms-auto my-auto">
                  <input
                    class="form-check-input mt-1 ms-auto"
                    type="checkbox"
                    id="dark-version"
                    onclick="darkMode(this)"
                  />
                </div>
              </div>
              <hr class="horizontal dark my-sm-4" />
              <a
                class="btn bg-gradient-info w-100"
                href="https://www.creative-tim.com/product/material-dashboard-pro"
                >Free Download</a
              >
              <a
                class="btn btn-outline-dark w-100"
                href="https://www.creative-tim.com/learning-lab/bootstrap/overview/material-dashboard"
                >View documentation</a
              >
              <div class="w-100 text-center">
                <a
                  class="github-button"
                  href="https://github.com/creativetimofficial/material-dashboard"
                  data-icon="octicon-star"
                  data-size="large"
                  data-show-count="true"
                  aria-label="Star creativetimofficial/material-dashboard on GitHub"
                  >Star</a
                >
                <h6 class="mt-3">Thank you for sharing!</h6>
                <a
                  href="https://twitter.com/intent/tweet?text=Check%20Material%20UI%20Dashboard%20made%20by%20%40CreativeTim%20%23webdesign%20%23dashboard%20%23bootstrap5&amp;url=https%3A%2F%2Fwww.creative-tim.com%2Fproduct%2Fsoft-ui-dashboard"
                  class="btn btn-dark mb-0 me-2"
                  target="_blank"
                >
                  <i class="fab fa-twitter me-1" aria-hidden="true"></i> Tweet
                </a>
                <a
                  href="https://www.facebook.com/sharer/sharer.php?u=https://www.creative-tim.com/product/material-dashboard"
                  class="btn btn-dark mb-0 me-2"
                  target="_blank"
                >
                  <i class="fab fa-facebook-square me-1" aria-hidden="true"></i>
                  Share
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
            Scrollbar.init(
              document.querySelector("#sidenav-scrollbar"),
              options
            );
          }
        </script>
        <!-- Github buttons -->
        <script async defer src="https://buttons.github.io/buttons.js"></script>
        <!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
        <script src="${pageContext.request.contextPath}/pms/assets/js/material-dashboard.min.js?v=3.1.0"></script>
        <!-- SweetAlert2 -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.12/dist/sweetalert2.all.min.js"></script>
        <link
          href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.12/dist/sweetalert2.min.css"
          rel="stylesheet"
        />
      </div>
    </div>
  </body>
</html>
<script>
  var stuNo = "${userNo}";

  /* 프로젝트 리스트  */
  function projectList(stuNo) {
    console.log("projectList 템플릿 체크 :" + stuNo);

    $.ajax({
      url: "/pms/projlist2",
      data: {
        stuNo: stuNo,
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
      },
    });
  }

  projectList(stuNo);

  /* 내 프로젝트 페이지 이동 */
  $(".nav-item").on("click", "#myProject", function () {
    location.href = "javascript:goToMenu('pms_myprojects')";
  });
</script>
