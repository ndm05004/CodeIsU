<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<aside class="left-sidebar" data-sidebarbg="skin6">
	<!-- Sidebar scroll-->
	<div class="scroll-sidebar" data-sidebarbg="skin6">
		<!-- Sidebar navigation-->
		<nav class="sidebar-nav">
			<ul id="sidebarnav">
				<li class="sidebar-item d-flex justify-content-center">
					<a class="sidebar-link sidebar-link" aria-expanded="false">
						<span class="hide-menu" style="font-size: 28px; font-weight: 600;">
						<c:set var="temp_category" value="수업 관리" scope="request"/>${temp_category}
						</span>
					</a>
				</li>
				<li class="list-divider"></li>
				<li class="sidebar-item"><a class="sidebar-link" href="/tch/class" aria-expanded="false"><span class="hide-menu">수업선택</span></a></li>
				<li class="sidebar-item"><a class="sidebar-link" href="/tch/class/asmt?sbjctCd=${sbjctCd}" aria-expanded="false"><span class="hide-menu">과제</span></a></li>
				<li class="sidebar-item"><a class="sidebar-link" href="/tch/class/qstn?sbjctCd=${sbjctCd}" aria-expanded="false"><span class="hide-menu">질문 답변</span></a></li>
				<li class="sidebar-item"><a class="sidebar-link" href="javascript:goToMenu('#')" aria-expanded="false"><span class="hide-menu">자료실</span></a></li>

			</ul>
		</nav>
		<!-- End Sidebar navigation -->
	</div>
	<!-- End Sidebar scroll-->
</aside>