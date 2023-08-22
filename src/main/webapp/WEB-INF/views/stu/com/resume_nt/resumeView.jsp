<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CodeIsU 이력서 미리보기</title>
<link href="${pageContext.request.contextPath}/common/kt/css/resume_view.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<style type="text/css">
.wrap {
	margin: 0 auto;
}
</style>
</head>
<body>
	<div class="wrap">
		<div id="resume-preview">
			<div class="resume-title">
				<div class="title-txt limit">
					이력서 <a class="btn btn-printer" title="인쇄" onclick="openPrintPreview()" style="float: right; font-size: 14px; font-weight: lighter;">인쇄</a>
				</div>
			</div>
			<div class="basic-info">
				<div class="container">
					<div class="photo">
						<!--기본이미지-->
						<img src="${pageContext.request.contextPath}${res.atchFileNo}" />

					</div>
					<div class="info-container">
						<div class="info-general">
							<div class="item name">${res.userInfo.userNm}</div>
							<div class="item age"> ${fn:substring(res.userInfo.userBrdt, 0, 4)}년</div>
							<div class="line"></div>
							<div class="item sex">
								<c:if test="${res.userInfo.userGender eq 'M'}">남</c:if>
								<c:if test="${res.userInfo.userGender eq 'F'}">여</c:if>
							</div>
							<div class="line"></div>

						</div>
						<div class="info-detail">
							<div class="item">
								<div class="label">이메일</div>
								<div class="value">
									<a>${res.userInfo.userNm}</a>
								</div>
							</div>
							<div class="item full">
								<div class="label">전화</div>
								<div class="value">${res.userInfo.userPhoneno}</div>
							</div>

							<div class="item full m-b-0">
								<div class="label">주소</div>
								<div class="value">(${res.userInfo.userZip}) ${res.userInfo.userAddr} ${res.userInfo.userDaddr}</div>
							</div>

						</div>
					</div>
				</div>
			</div>
			<!--//기본정보-->
			<!--학력-->
			<div class="section">
				<div class="header">
					<img src="${pageContext.request.contextPath}/resources/img/resume/ic_edu.png" />
					<h2 class="title">학력</h2>
					<div class="term"></div>
				</div>
				<div class="list"> <!-- 학력사항 -->

					<div class="item height-fix"> <!-- 고등학교 졸업 -->
						<div class="term-wrap">
							<div class="term">${fn:replace(res.highschGrdtnYm, '-', '.')}</div>
							<div class="state">고등학교 졸업</div>
						</div>
						<div class="content">
							<div class="content-header">
								<div class="main-txt">${res.highschNm}</div>


								<div class="sub-txt"></div>
							</div>
						</div><!-- //고등학교 졸업 -->
					</div>

					<c:forEach var="acbg" items="${res.acbgList}">
						<div class="item height-fix">
							<!-- 대학 -->
							<div class="term-wrap">
								<div class="term">${fn:replace(acbg.mtcltnYm, '-', '.')} ~ ${fn:replace(acbg.grdtnYm, '-', '.')}</div>
								<div class="state">${acbg.schlSeCd} ${acbg.grdtnState}</div>
							</div>
							<div class="content">
								<div class="content-header">
									<div class="main-txt">${acbg.schlNm}</div>
									<div class="sub-txt">${acbg.departNm}</div>
								</div>
								<div class="content-body">
									<div class="info">
										<div class="item">
											<div class="label">학점</div>
											<div class="line"></div>
											<div class="value">${acbg.userCredit} / ${acbg.baseCredit}</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>

				</div>
			</div>
			<!--//학력-->
			<!--자격증-->
			<div class="section">
				<div class="header">
					<img src="${pageContext.request.contextPath}/resources/img/resume/ic_license.png" />
					<h2 class="title">면허 / 자격증</h2>
					<div class="term">
						<div class="total">
							총 <strong>${fn:length(res.crtfctList)}</strong> 건
						</div>
					</div>
				</div>
				<div class="list">
					<c:forEach items="${res.crtfctList}" var="crtfct">
						<div class="item">
							<div class="term-wrap">
								<div class="term">${fn:replace(crtfct.crtfctDt, '-', '.')}</div>
							</div>
							<div class="content">
								<div class="content-header">
									<div class="main-txt license-type">${crtfct.crtfctNm}</div>

									<div class="sub-txt">${crtfct.issuInstNm}</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<!--//자격증-->
			<!--경력-->
			<div class="section career">
				<div class="header">
					<img src="${pageContext.request.contextPath}/resources/img/resume/ic_career.png" />
					<h2 class="title">경력</h2>
					<div class="term">
						<div class="total">
							총 <strong>${fn:length(res.careerList)}</strong> 건
						</div>
					</div>

				</div>
				<div class="list">
					<c:forEach items="${res.careerList}" var="career">
					<div class="item">
						<div class="term-wrap">
							<div class="term">${fn:replace(career.jncmpYm, '-', '.')} ~ ${fn:replace(career.rsgntnYm, '-', '.')}</div>

						</div>
						<div class="content">
							<div class="content-header">
								<div class="main-txt hosp-name">${career.coNm}</div>
								<div class="sub-txt job-area">${career.deptNm}</div>
								<div class="sub-txt line">/</div>
								<div class="sub-txt job-position">${career.jbgdNm}</div>
							</div>
							<div class="content-body">
								<div class="info">
									<div class="item">
										<div class="label">재직여부</div>
										<div class="line"></div>
										<div class="value">
											${career.hdofYn}

										</div>
									</div>
								</div>

							</div>
						</div>
					</div>
					</c:forEach>
				</div>
			</div>
			<!--//경력-->

			<!--기술 숙련도-->
			<div class="section">
				<div class="header">
					<img src="${pageContext.request.contextPath}/resources/img/resume/ic_computer.png" />
					<h2 class="title">기술 숙련도</h2>
					<div class="term">
						<div class="total">
							총 <strong>${fn:length(res.techList)}</strong> 건
						</div>
					</div>
					<div class="list">
						<table width="100%" class="resume-table">
							<tbody>

							<c:forEach items="${res.techList}" var="tech" varStatus="stat">
							<c:if test="${stat.count%2 eq 1}">
								<tr>
							</c:if>

								<th style="width: 25%">${tech.techNm}</th>
								<td style="width: 25%">${tech.skillLevel}</td>

							<c:if test="${stat.count%2 eq 0}">
								</tr>
							</c:if>

							<c:if test="${fn:length(res.techList)%2 eq 1 && stat.last}">
								<th> - </th>
								<td> - </td>
								</tr>
							</c:if>

							</c:forEach>
							</tbody>

						</table>
					</div>
				</div>
			</div>
			<!--//기술 숙련도-->

			<!--자기소개서-->
			<div class="section">
				<div class="header">
					<img src="${pageContext.request.contextPath}/resources/img/resume/ic_self.png" />
					<h2 class="title">자기소개서</h2>
				</div>
				<div class="list">
					<div class="item">
						<div class="txt">
							<textarea name="ttt" id="ttt" cols="108" rows="10">${res.resumeIntroConn}</textarea>
							</div>

					</div>
				</div>
			</div>

			<!--//자기소개서-->
			<!--다름없-->
			<div class="sign">
				<div class="message">위의 모든 내용은 사실과 다름없음을 확인합니다.</div>
				<div class="text-wrap">
					<div class="date">작성일 :  <fmt:formatDate value="${res.regDt}" pattern="yyyy.MM.dd"/>
					</div>
					<div class="writer">작성자 : ${res.userInfo.userNm}</div>
				</div>
			</div>
			<!--//다름없-->

		</div>
		<!--// resume-preview-->
	</div>


</body>
</html>

<script type="text/javascript"> // 프린트 버튼 숨기기
	function openPrintPreview() {
		var viewType = "preview"

		window.onbeforeprint = function() {
			$(".btn-printer").hide();
		}

		window.onafterprint = function() {
			$(".btn-printer").show();
		}
		window.print();
	}
</script>

