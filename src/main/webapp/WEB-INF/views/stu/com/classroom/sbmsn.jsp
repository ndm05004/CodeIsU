<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!-- 현재날짜 -->
<c:set var="date" value="<%=new java.util.Date()%>" />
<fmt:formatDate value="${date}" pattern="yyyy-MM-dd HH:mm" var="today"/>
<style>
    .asmtCardDtl{
        height:65px;
    }
</style>
<div class="">
	<div class="mb-3">
		<input type="hidden" name="asmtNo" id="asmtNo" value="${asmtVO.asmtNo}">
		<P>${asmtVO.asmtDdln}까지</P>
	</div>
	<div class="mb-5">
		<h2>${asmtVO.asmtTtl}</h2>
		<p>${asmtVO.asmtExpln}</p>
	</div>
	<!-- 문제 card -->
	<form action="/stu/classroom/assign/sbmsn?${_csrf.parameterName}=${_csrf.token}" method="post">
		<input type="hidden" name="sbjctCd" value="${asmtVO.sbjctCd}">
		<input type="hidden" name="asmtNo" value="${asmtNo}">
		<div id="asmtContainer">
			<c:set var="btnFlag" value="false"/>
			<c:set var="num" value="0"/>
			<c:forEach items="${asmtVO.qstList}" var="qst">
				<c:if test="${qst.qstSbmsnYn eq null || qst.qstSbmsnYn eq '' || qst.qstSbmsnYn eq 'N'}">
					<c:set var="btnFlag" value="true"/>
				</c:if>
				<div class="card qstCard border-dark mb-3">
					
					<div class="card-body">
						<input type="hidden" name="qstAnswerList[${num}].qstNo" value="${qst.qstNo}">
						<div class="qst">
							<div class="row mb-3 qstTitle">
								<div class="col-10">${qst.qstCn }</div>
							</div>

							<div class="asmttitleimg mb-3">
								<c:forEach items="${atchFileList}" var="atchFile">
									<c:if test="${qst.atchFileNo eq atchFile.atchFileNo}">
										<img alt="" src="${atchFile.filePath}" style = "width:100%; height: auto;">
									</c:if>
								</c:forEach>
							</div>
							<div class="asmtcardDtl">
								<!-- 객관식 -->
								<c:if test="${qst.qstCode eq 'M' }">
									<c:forEach items="${qst.qstDtlList}" var="qstDtl">
										<div class="form-check mb-2">
											<input class="form-check-input" type="radio" name="qstAnswerList[${num}].qstSbmsnAns" value="${qstDtl.qstDtlNo}"> ${qstDtl.qstDtlCn}
										</div>
									</c:forEach>
								</c:if>
								<!-- 주관식 -->
								<c:if test="${qst.qstCode ne 'M' }">
									<div class="row align-items-center">
										<div class="col-1">답</div>
										<div class="col-9">
											<input type="text" name="qstAnswerList[${num}].qstSbmsnAns"  class="form-control font-weight-normal border-0 rounded-0 shadow-none border-bottom border-dark qstnAns" placeholder="답">
										</div>
										<div class="col-2"></div>
									</div>
								</c:if>
							</div>
						</div>
					</div>
				</div>
				<c:set var="num" value="${num + 1}"/>
			</c:forEach>
		</div>
		<div class="d-grid gap-2">
			<input type="submit" class="btn btn-primary" id="submitBtn" value="완료">
		</div>
	</form>
</div>
<script>

</script>