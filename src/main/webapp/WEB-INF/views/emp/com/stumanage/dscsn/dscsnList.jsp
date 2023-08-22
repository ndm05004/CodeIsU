<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
#mainDiv{
	height: 75vh;
}
</style>

<div id="mainDiv">
	<table class="table">
		<thead class="table-dark">
			<tr>
				<th style="text-align: center;" colspan="4" class="p-2">미승인 상담</th>
			</tr>
			<tr>
				<th class="p-2">분류</th>
				<th class="p-2">상담일</th>
				<th class="p-2">상담원</th>
				<th class="p-2">상담자</th>
			</tr>
		</thead>
		<tbody id="oneBoxBody">
			<c:forEach items="${dscsnList }" var="dscsn">
				<tr>
					<td class="p-2">${dscsn.dscsnCd}</td>
					<td class="p-2">${dscsn.dscsnDt}</td>
					<td class="p-2">${dscsn.empNo}</td>
					<td class="p-2">${dscsn.stuNo}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<div class="row align-items-center" style="height: 50px;">
	<div class="col">
		<button id="dscsnMainBtn" type="button" class="btn btn-dark">목록</button>
	</div>
</div>

<script>
$(function(){

	$("#dscsnMainBtn").on("click", function(){
		location.href = "/emp/dscsn/dscsnBoard";
	})
})
</script>