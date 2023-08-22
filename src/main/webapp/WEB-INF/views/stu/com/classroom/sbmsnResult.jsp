<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<style>
    .asmtCardDtl{
        height:65px;
    }
</style>
<div class="container">
    <!-- 맞은 개수 -->
    <c:set var="qstcount" value="0"/>
    <c:set var="count" value="0"/>
	<div class="row">
        <c:set var="qstSbmsnDt" value=""/>
        <c:forEach items="${sbmsnList}" var="sbmsn">
            <c:set var="qstSbmsnDt" value="${sbmsn.qstSbmsnDt} 제출"/>

        </c:forEach>
        <div class="col-10 text-muted mb-3">
            ${asmtVO.asmtDdln}까지 · ${qstSbmsnDt}
        </div>
        <div class="col-2 text-danger text-end fw-bold" id="scoreDiv">
        </div>
	</div>
	<div class="mb-5">
		<h2>${asmtVO.asmtTtl}</h2>
		<p>${asmtVO.asmtExpln}</p>
	</div>
	<!-- 문제 card -->
		<input type="hidden" name="sbjctCd" value="${asmtVO.sbjctCd}">
		<div id="asmtContainer">
			<c:set var="btnFlag" value="false"/>
			<c:set var="num" value="0"/>
			<c:forEach items="${asmtVO.qstList}" var="qst">
                <c:set var="qstcount" value="${qstcount+1}"/>
				<c:if test="${qst.qstSbmsnYn eq null || qst.qstSbmsnYn eq '' || qst.qstSbmsnYn eq 'N'}">
					<c:set var="btnFlag" value="true"/>
				</c:if>
				<div class="card qstCard border-dark mb-3">

					<div class="card-body">
						<input type="hidden" name="qstAnswerList[${num}].qstNo" value="${qst.qstNo}">
						<div class="qst">
							<div class="row mb-3 qstTitle">
								<div class="col-10">${qst.qstCn }</div>
                                    <!--문제 채점-->
                                    <c:forEach items="${sbmsnList}" var="sbmsn">
                                        <c:if test="${qst.qstNo eq sbmsn.qstNo}">
                                            <!-- 정답이랑 다르면 정답을 빨강 -->
                                            <c:if test="${sbmsn.qstSbmsnAns ne qst.qstAns}">
                                                <div class="col-2 text-end text-danger">
                                                    X
                                                </div>
                                            </c:if>
                                            <c:if test="${sbmsn.qstSbmsnAns eq qst.qstAns}">
                                                <div class="col-2 text-end text-primary">
                                                    O
                                                </div>
                                            </c:if>
    
                                        </c:if>
                                    </c:forEach>
							</div>

							<div class="asmttitleimg mb-3">
								<c:forEach items="${atchFileList}" var="atchFile">
									<c:if test="${qst.atchFileNo eq atchFile.atchFileNo}">
										<img alt="" src="${atchFile.filePath}" style = "width:100%; height: auto;">
									</c:if>
								</c:forEach>
							</div>
							<div class="asmtcardDtl">
                                <c:forEach items="${sbmsnList}" var="sbmsn">
                                    <!-- 객관식 -->
                                    <c:if test="${qst.qstCode eq 'M' }">
                                        <c:set value="1" var="i"/>
                                        <c:forEach items="${qst.qstDtlList}" var="qstDtl">
                                            <c:if test = "${sbmsn.qstNo eq qst.qstNo}">
                                                <!-- 정답이랑 다르면 정답을 빨강 -->
                                                <c:if test="${sbmsn.qstSbmsnAns ne qst.qstAns && qst.qstAns eq i}">
                                                    <div class="mb-2 text-danger fw-bold">정답 : 
                                                </c:if>
                                                <!-- 정답이랑 다르면 내가 쓴 답은 검정 -->
                                                <c:if test="${sbmsn.qstSbmsnAns ne qst.qstAns && sbmsn.qstSbmsnAns eq i}">
                                                    <div class="mb-2 text-dark fw-bold">
                                                </c:if>
                                                <!-- 정답이랑 같으면 정답을 파랑 -->
                                                <c:if test="${sbmsn.qstSbmsnAns eq qstDtl.qstDtlNo && qst.qstAns eq i}">
                                                    <c:set var="count" value="${count+1}"/>
                                                    <div class="mb-2 text-primary fw-bold">
                                                </c:if>
                                                <!-- 내가 쓴것도 아니고 정답도 아닌것들은 회색 -->
                                                <c:if test="${sbmsn.qstSbmsnAns ne i && qst.qstAns ne i}">
                                                    <div class="mb-2 text-muted">
                                                </c:if>
                                                    ${qstDtl.qstDtlCn}
                                                </div>
                                                <c:set value="${i+1}" var="i"/>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                    <!-- 주관식 -->
                                    <c:if test="${qst.qstCode ne 'M' }">
                                        <c:set value="${sbmsn.qstSbmsnAns}" var="qstSbmsnAns"/>
                                        <c:if test="${qstSbmsnAns eq null}">
                                            <c:set value="" var="qstSbmsnAns"/>
                                        </c:if>
                                        <c:if test = "${sbmsn.qstNo eq qst.qstNo}">
                                            <div class="row align-items-center">
                                                <div class="col-1">작성</div>
                                                <!-- 내가 쓴 답이 답이라면-->
                                                <c:if test="${sbmsn.qstSbmsnAns eq qst.qstAns}">
                                                    <c:set var="count" value="${count+1}"/>
                                                    <div class="col-9 text-primary">
                                                        ${qstSbmsnAns}
                                                    </div>
                                                </c:if>
                                                <!-- 정답이 아니라면-->
                                                <c:if test="${sbmsn.qstSbmsnAns ne qst.qstAns}">
                                                    <div class="col-9 text-dark">
                                                        ${qstSbmsnAns}
                                                    </div>
                                                </c:if>
                                                <div class="col-2"></div>
                                            </div>
                                            <div class="row">
                                                <!-- 정답이 아니라면-->
                                                <c:if test="${sbmsn.qstSbmsnAns ne qst.qstAns}">
                                                    <div class="col-1 text-danger fw-bold">정답</div>
                                                    <div class="col-9 text-danger fw-bold">
                                                        ${qst.qstAns}
                                                    </div>
                                                </c:if>
                                            </div>
                                        </c:if>
                                    </c:if>
                                </c:forEach>
							</div>
						</div>
					</div>
				</div>
				<c:set var="num" value="${num + 1}"/>
			</c:forEach>
		</div>
        <input type="hidden" name="score" id="score" value="${100 / qstcount * count}">

</div>
<script>

    document.querySelector("#scoreDiv").innerHTML = Math.floor(document.querySelector("#score").value) + " 점";
</script>