<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- VS코드 작업용입니다. 사용하고지워주세요 -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script> -->
<!-- <link rel="stylesheet" href="https://demos.adminmart.com/free/bootstrap/freedash-lite/src/dist/css/style.min.css" /> -->
<!-- /VS코드 작업용입니다. 사용하고지워주세요 -->

<style>
.tit_square01, .content .tit_square01 {
margin: 3px 0 15px;
padding: 0 0 0 13px;
background: url(/resources/img/h4.png) no-repeat 0 4px;
font-size: 22px;
font-weight: 700;
color: #000;
}

</style>
<div class="row">
	<div class="col-12">
		<div class="card">
			<div class="card-body w-75 " style="margin-left: auto;margin-right: auto;">
				<h4 class="tit_square01">회원정보 변경</h4>
				<form action="/user/signup?${_csrf.parameterName}=${_csrf.token}" id="joinForm" method="post" enctype="multipart/form-data">

					<div class="row mb-3">
						<label for="userNo" class="col-sm-4 col-form-label">원생번호</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="stuNo" value="${userData.stuNo}" readonly />
						</div>
					</div>
					<div class="row mb-3">
						<label for="userNm" class="col-sm-4 col-form-label">이름</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="userNm" value="${userData.userNm}" readonly>
						</div>
					</div>
					<div class="row mb-3">
						<label for="userBrdt" class="col-sm-4 col-form-label">생년월일</label>
						<div class="col-sm-8">
							<input type="date" class="form-control" name="userBrdt" value="${userData.userBrdt}" readonly>
						</div>
					</div>
					<div class="row mb-3">
						<label for="userGender" class="col-sm-4 col-form-label">성별</label>
						<div class="col-sm-8 d-flex justify-content-evenly">

							<input type="radio" id="M" name="userGender" value="M" <c:if test="${userData.userGender eq 'M'}">checked</c:if>><label for="M" style="font-size: 22px;">남성</label> <input type="radio" id="F" name="userGender" value="F" <c:if test="${userData.userGender eq 'F'}">checked</c:if>> <label for="F" style="font-size: 22px;">여성</label>
						</div>
					</div>
					<div class="row mb-3">
						<label for="userPswd" class="col-sm-4 col-form-label">비밀번호</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="userPswd">
						</div>
					</div>
					<div class="row mb-3">
						<label for="userPswd2" class="col-sm-4 col-form-label">비밀번호 확인</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="userPswd2">
						</div>
					</div>
					<div class="row mb-3">
						<label for="userEmlAddr" class="col-sm-4 col-form-label">이메일</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="userEmlAddr" value="${userData.userEmlAddr}">
						</div>
					</div>
					<div class="row mb-3">
						<label for="userPhoneno" class="col-sm-4 col-form-label">핸드폰 번호</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="userPhoneno" value="${userData.userPhoneno}">
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-7 mx-0">
							<label for="userAddr" class="form-label">기본주소</label> <input type="text" class="form-control" name="userAddr" placeholder="기본주소를 입력해주세요" value="${userData.userAddr}">
						</div>
						<div class="col-md-2 ps-0">
							<label for="userZip" class="form-label">우편번호</label> <input type="text" class="form-control" name="userZip" value="${userData.userZip}">
						</div>
						<div class="col-md-2 ps-0 d-flex align-items-end justify-content-end">
							<button type="button" class="btn btn-primary" onclick="postcode()">검색</button>
						</div>
					</div>

					<div class="col mb-3">
						<label for="userDaddr" class="form-label">상세주소</label> <input type="text" class="form-control" name="userDaddr" placeholder="상세주소를 입력해주세요" value="${userData.userDaddr}">
					</div>
					<div class="row mb-3">
						<label for="profileFile" class="col-sm-4 col-form-label">프로필사진 변경</label>
						<div class="col-sm-8">
							<input type="file" class="form-control" name="profileFile">
						</div>
					</div>
		       		 <div class="row-lg-12 text-center mb-3">
                             <button type="button" id="modifyBtn" class="btn w-100 btn-dark">회원정보 변경</button>
                         </div>




				</form>

			</div>
		</div>
	</div>
</div>