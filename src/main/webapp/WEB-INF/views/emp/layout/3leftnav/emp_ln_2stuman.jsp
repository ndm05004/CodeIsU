<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<aside class="left-sidebar" data-sidebarbg="skin6">
	<!-- Sidebar scroll-->
	<div class="scroll-sidebar" data-sidebarbg="skin6">
		<!-- Sidebar navigation-->
		<nav class="sidebar-nav">
			<ul id="sidebarnav">
				<li class="sidebar-item d-flex justify-content-center">
				<a class="sidebar-link sidebar-link" href="index.html" aria-expanded="false">
				<span class="hide-menu" style="font-size: 28px; font-weight: 600;">
				<c:set var="temp_category" value="원생관리" scope="request"/>${temp_category}
				</span></a></li>
				<li class="list-divider"></li>
				<li class="sidebar-item"><a class="sidebar-link" href="javascript:goToMenu('emp_svlf')" aria-expanded="false"><span class="hide-menu">연수과정 </span></a></li>
				<li class="sidebar-item"><a class="sidebar-link" href="javascript:goToMenu('emp_stulist')" aria-expanded="false"><span class="hide-menu">학원생 등록 </span></a></li>
				<li class="sidebar-item"><a class="sidebar-link" href="javascript:goToMenu('emp_attend')" aria-expanded="false"><span class="hide-menu">출결관리 </span></a></li>
				<li class="sidebar-item"><a class="sidebar-link" href="javascript:goToMenu('emp_dscsnboard')" aria-expanded="false"><span class="hide-menu">상담관리 </span></a></li>

			</ul>
		</nav>
		<!-- End Sidebar navigation -->
	</div>
	<!-- End Sidebar scroll-->
</aside>