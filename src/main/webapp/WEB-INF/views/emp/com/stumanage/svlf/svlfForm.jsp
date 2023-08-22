<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<body>
	<h1>svlfForm 페이지</h1>
<div>
	<form action="${pageContext.request.contextPath}/emp/svlf/svlfInsert?${_csrf.parameterName }=${_csrf.token}" id="svlfForm" method="post">
		<c:if test="${status eq 'u' }">
			<input type="hidden" name="bdforeClassCd" value="${svlfVO.lectureRoomCd }">
		</c:if>
		<div class="mb-3">
			<label class="form-label">연수과정 번호</label>
			<c:if test="${status eq 'u' }">
				<input type="text" name="svlfNo" id="svlfNo" value="${svlfVO.svlfNo }" class="form-control" readonly/>
			</c:if>
			<c:if test="${status ne 'u' }">
				<input type="text" name="svlfNo" id="svlfNo" class="form-control"/>
			</c:if>
		</div>
		<div class="mb-3">

			<!-- 시작일과 종료일 데이터를 가져올 수 있도록 해주기 -->

			<label class="form-label">시작일</label>
			<%-- <c:if test="${status eq 'u' }">
				<input type="date" name="svlfBgngDt" id="svlfBgngDt" value="${svlfVO.svlfBgngDt }" class="form-control"/>
			</c:if> --%>
			<input type="date" name="svlfBgngDt" id="svlfBgngDt" class="form-control"/>
		</div>
		<div class="mb-3">
			<label class="form-label">수료일</label>
			<%-- <c:if test="${status eq 'u' }">
				<input type="date" name="svlfDdlbDt" id="svlfDdlbDt" value="${svlfVO.svlfDdlbDt }" class="form-control"/>
			</c:if> --%>
			<input type="date" name="svlfDdlbDt" id="svlfDdlbDt" class="form-control">
		</div>
		<div class="mb-3">
			<label class="form-label">연수과정명</label>
			<c:if test="${status eq 'u' }">
				<input type="text" name="svlfNm" id="svlfNm" value="${svlfVO.svlfNm }" class="form-control"/>
			</c:if>
			<c:if test="${status ne 'u' }">
				<input type="text" name="svlfNm" id="svlfNm" class="form-control"/>
			</c:if>
		</div>
		<div class="mb-3">
			<label class="form-label">호실</label>
			<c:set value="${lectureRoomList }" var="lectureRoomList"/>

			<!-- 호실 순서에 맞춰서 나올 수 있도록 해보기 -->

			<select id="lectureRoomCd" name="lectureRoomCd" class="form-select" aria-label="Default select example">
				<c:forEach items="${lectureRoomList }" var="lectureroomList">
					<option value="${lectureroomList.lectureRoomCd }">${lectureroomList.lectureRoomNm }</option>
				</c:forEach>
				<c:if test="${status eq 'u' }">
					<option value="${svlfVO.lectureRoomCd }">${svlfVO.lectureRoomNm }</option>
				</c:if>
			</select>
		</div>
		<div class="mb-3">
			<label class="form-label">담임</label>
			<c:set value="${tchList }" var="TchList"/>
			<select id="empNo" name="empNo" class="form-select" aria-label="Default select example">
			<c:if test="${status ne 'u' }">
			<c:choose>
				<c:when test="${empty TchList }">
					<option>담당할 수 있는 강사가 존재하지 않습니다.</option>
				</c:when>
				<c:otherwise>
					<c:forEach items="${TchList }" var="tchlist">
						<option value="${tchlist.empNo }">${tchlist.userNm }</option>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			</c:if>
			<c:if test="${status eq 'u' }">
				<option value="${svlfVO.empNo }">${svlfVO.userNm }</option>
			</c:if>
			</select>
		</div>
		<div class="mb-3">
			<label class="form-label">연수내용</label>
			<c:if test="${status eq 'u' }">
				<textarea rows="10" name="svlfCn" id="svlfCn" class="form-control">${svlfVO.svlfCn }</textarea>
			</c:if>
			<c:if test="${status ne 'u' }">
				<textarea rows="10" name="svlfCn" id="svlfCn" class="form-control"></textarea>
			</c:if>
		</div>
		<!-- 시작일 종료일 계산하여 기간 구해서 hidden타입으로 강의 일수 구하기 -->
	</form>
</div>
<div>
	<c:if test="${status eq 'u' }">
		<button type="button" id="updateSvlfBtn" class="btn btn-success">수정완료</button>
	</c:if>
	<c:if test="${status ne 'u' }">
		<button type="button" id="addSvlfBtn" class="btn btn-success">생성</button>
	</c:if>
	<button type="button" id="cancelBtn" class="btn btn-secondary">취소</button>
</div>
<script type="text/javascript">
$(function(){
	var addSvlfBtn = $("#addSvlfBtn");
	var updateSvlfBtn = $("#updateSvlfBtn");
	var cancelBtn = $("#cancelBtn");
	var svlfForm = $("#svlfForm");

	addSvlfBtn.on("click", function(){
		svlfForm.submit();
	})

	updateSvlfBtn.on("click", function(){
		svlfForm.attr("action", "/emp/svlf/svlfUpdate?${_csrf.parameterName }=${_csrf.token}");
		svlfForm.submit();
	})

	cancelBtn.on("click", function(){
		location.href = "/emp/svlf/svlfList";
	})
})
</script>
</body>
