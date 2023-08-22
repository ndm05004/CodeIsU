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
						<c:set var="temp_category" value="HOME" scope="request"/>${temp_category}
						</span>
					</a>
				</li>
				<li class="list-divider"></li>
				<li class="sidebar-item"><a class="sidebar-link" href="/emp/main" aria-expanded="false"><span class="hide-menu">행정 대시보드 </span></a></li>

			</ul>
		</nav>
		<!-- End Sidebar navigation -->
	</div>
	<!-- End Sidebar scroll-->
</aside>