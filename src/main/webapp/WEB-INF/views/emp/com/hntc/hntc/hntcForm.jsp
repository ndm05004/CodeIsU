<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="row">
	<div class="col-12">
		<div class="card">
			<div class="card-body">
				<c:set value="등록" var="titleName"/>
				<c:if test="${status eq 'u' }">
					<c:set value="수정" var="titleName"/>
				</c:if>
				<h1>공지사항&nbsp;${titleName }</h1>
				<div>
					<form action="${pageContext.request.contextPath}/emp/hntc/hntcInsert?${_csrf.parameterName }=${_csrf.token}" method="post" id="hntcForm">
						<c:if test="${status eq 'u' }">
							<input type="hidden" name="hntcNo" id="hntcNo" value="${hntcVO.hntcNo }">
						</c:if>
						<div>
							<label>제목</label>
							<input type="text" name="hntcNm" id="hntcNm" class="form-control" value="${hntcVO.hntcNm }"/>
						</div>
						<div>
							<label>내용</label>
							<textarea rows="10" name="hntcCn" id="hntcCn" class="form-control">${hntcVO.hntcCn }</textarea>
						</div>
					</form>
				</div>
				<div style="margin-top: 10px">
					<button id="hntcInsert" class="btn btn-primary float-right" value="${titleName }">${titleName }</button>
					<button id="cancelBtn" class="btn btn-danger float-right">취소</button>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script> <!--이거 -->
<script type="text/javascript">
$(function(){
	CKEDITOR.replace("hntcCn"); <!--이거 -->
	CKEDITOR.config.allowedContent = true;
	var hntcInsert = $("#hntcInsert");
	var cancelBtn = $("#cancelBtn");
	var hntcForm = $("#hntcForm");

	hntcInsert.on("click", function(){
		var  hntcNm = $("#hntcNm").val();
		var  hntcCn = CKEDITOR.instances.hntcCn.getData();

		if(hntcNm == null || hntcNm == ""){
			alert("제목을 입력해주세요");
			return false;
		}

		if(hntcCn == null || hntcCn == ""){
			alert("내용을 입력해주세요");
			return false;
		}

		if($(this).val() == "수정"){
			hntcForm.attr("action", "/emp/hntc/hntcUpdate?${_csrf.parameterName }=${_csrf.token }")
		}

		hntcForm.submit();
	})

	cancelBtn.on("click", function(){
		location.href = "/emp/hntc/hntcBoard";
	})
})

</script>
</body>
