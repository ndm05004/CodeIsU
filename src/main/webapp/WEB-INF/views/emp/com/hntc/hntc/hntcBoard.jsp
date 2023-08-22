<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib  uri="http://www.springframework.org/security/tags" prefix="sec"%>
<style>
#mainDiv, #mainCard{
	height: 87vh;
}

tbody tr{
	cursor: pointer;
}
</style>
<div id="mainDiv" class="row">
	<div class="col-12">
		<div id="mainCard" class="card">
			<div class="card-body">

				<div class="row" style="padding-bottom: 10px;">
					<form class="input-group input-group-outline justify-content-end" method="post" id="searchForm">
						<input type="hidden" name="page" id="page">
						<div class="col-md-2" style="padding: 0;">
							 <select class="form-select" name="searchType" id="selectForm">
								<option value="title" <c:if test="${searchType == 'title' }"><c:out value="selected"/></c:if>>제목</option>
								<option value="writer" <c:if test="${searchType == 'writer' }"><c:out value="selected"/></c:if>>작성자</option>
								<option value="titleWriter" <c:if test="${searchType == 'titleWriter' }"><c:out value="selected"/></c:if>>제목+작성자</option>
							 </select>
						   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</div>
						  <div class="col-md-3">
							  <!-- <label class=""></label> -->
							  <input type="text" name="searchWord" class="form-control" value="${searchWord }" placeholder="Search">
						  </div>
						<div class="col-md-1.5" style="padding: 0;">
						  <button type="submit" class="btn btn-outline-secondary">
							<i class="fas fa-search"></i>검색
						  </button>
						</div>
					</form>
				</div>
				<div style="height: 70vh;">
					<table class="table table-hover">
						<thead>
							<tr class="table-secondary">
								<th>번호</th>
								<th>작성자</th>
								<th>제목</th>
								<th>작성일</th>
								<th>조회수</th>
							</tr>
						</thead>
						<tbody id="hntcBody" class="table">
							<c:set value="${pagingVO.dataList }" var="hntcList"/>
							<c:set var="pageNum" value="${pagingVO.totalRecord - (pagingVO.currentPage - 1)* pagingVO.screenSize}"/>
							<c:set var="index" value="0" />
							<c:choose>
								<c:when test="${empty hntcList }">
									<tr>
										<td colspan="5" style="text-align: center;">조회할 게시물이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${hntcList }" var="hntc" varStatus="state">
										<tr>
											<%-- <a href="/emp/hntc/hntcDetail?bono=${hntc.hntcNo }">	 --%>
											<td id="hntcNo" style="display: none;">${hntc.hntcNo }</td>
											<td>${pageNum - index}</td>
											<td>${hntc.empNo }</td>
											<td>${hntc.hntcNm }</td>
											<td>${hntc.hntcDt }</td>
											<td>${hntc.checkNo }</td>
											<c:set var ="index" value="${index + 1}"/>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>

				<div>
					<button type="button" class="btn btn-primary" id="insertHntc">글 등록</button>
				</div>
				<div class="" id="pagingArea">
					${pagingVO.pagingHTML }
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function(){
	var insertHntc = $("#insertHntc");

	insertHntc.on("click", function(){
		location.href = "/emp/hntc/hntcForm"
	})

	$("#hntcBody").on("click","tr", function(){
		let no = $(this).find("#hntcNo").text();

		location.href = "/emp/hntc/hntcDetail?bono="+no;
	})

})

$(function(){
	var newBtn = $("#newBtn");
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");

	pagingArea.on("click", "a", function(event){
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});

})

</script>
