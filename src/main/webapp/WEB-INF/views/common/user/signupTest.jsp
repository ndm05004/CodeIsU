<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html dir="ltr">
	<head>
		<meta charset="utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<!-- Tell the browser to be responsive to screen width -->
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta name="description" content="" />
		<meta name="author" content="" />
		<!-- Favicon icon -->
		<link rel="icon" type="image/png" sizes="16x16" href="/assets/images/favicon.png" />
		<title>Freedash Template - The Ultimate Multipurpose admin template</title>
		<!-- Custom CSS -->
		<link href="/dist/css/style.min.css" rel="stylesheet" />
		<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
			<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
	</head>

	<body>
		<div class="main-wrapper">
			<!-- ============================================================== -->
			<!-- Preloader - style you can find in spinners.css -->
			<!-- ============================================================== -->
			<div class="preloader">
				<div class="lds-ripple">
					<div class="lds-pos"></div>
					<div class="lds-pos"></div>
				</div>
			</div>
			<!-- ============================================================== -->
			<!-- Preloader - style you can find in spinners.css -->
			<!-- ============================================================== -->
			<!-- ============================================================== -->
			<!-- Login box.scss -->
			<!-- ============================================================== -->
			<div class="auth-wrapper d-flex no-block justify-content-center align-items-center position-relative" style="background: url(/assets/images/big/auth-bg.jpg) no-repeat center center">
				<div class="auth-box row">
					<div class="col-lg-7 col-md-5 modal-bg-img" style="background-image: url(/assets/images/big/3.jpg)"></div>
					<div class="col-lg-5 col-md-7 bg-white">
						<div class="p-3">
							<div class="text-center">
								<img src="/assets/images/big/icon.png" alt="wrapkit" />
							</div>
							<h2 class="mt-3 text-center">Sign In</h2>
							<p class="text-center">Enter your email address and password to access admin panel.</p>
							<form class="mt-4">
								<div class="row">
									<div class="col-lg-12">
										<div class="form-group mb-3">
											<label class="form-label text-dark" for="uname">Username</label>
											<input class="form-control" id="uname" type="text" placeholder="enter your username" />
										</div>
									</div>
									<div class="col-lg-12">
										<div class="form-group mb-3">
											<label class="form-label text-dark" for="pwd">Password</label>
											<input class="form-control" id="pwd" type="password" placeholder="enter your password" />
										</div>
									</div>
									<div class="col-lg-12 text-center">
										<button type="submit" class="btn w-100 btn-dark">Sign In</button>
									</div>
									<div class="col-lg-12 text-center mt-5">
										Don't have an account? <a href="#" class="text-danger" data-bs-toggle="modal" data-bs-target="#typeModal">Sign Up</a>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- ============================================================== -->
			<!-- Login box.scss -->
			<!-- ============================================================== -->
		</div>
		<!-- ============================================================== -->
		<!-- All Required js -->
		<!-- ============================================================== -->
		<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.0/dist/jquery.min.js"></script>
		<!-- Bootstrap tether Core JavaScript -->
		<script src="/assets/libs/popper.js/dist/umd/popper.min.js"></script>
		<script src="/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
		<!-- ============================================================== -->
		<!-- This page plugin js -->
		<!-- ============================================================== -->
		<script>
			$(".preloader ").fadeOut();
		</script>


		<!--원생/선생 선택 Modal -->
		<div class="modal fade" id="typeModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		  <div class="modal-dialog modal-sm modal-dialog-centered">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="staticBackdropLabel">가입 유형 선택</h1>

		      </div>
		      <div class="modal-body">
		      	<input type="text" name="rplyNum" id="rplyNum"> <br/>
				회원 유형을 선택해주세요.
				<button type="button" class="btn btn-primary" id="stuBtn">원생</button>
				<button type="button" class="btn btn-primary" id="tchBtn">강사</button>
		      </div>
		      <div class="modal-footer d-flex justify-content-center">
		        <button type="button" class="btn btn-primary num-verify-btn" id="numSubmit">전송</button>
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		      </div>
		    </div>
		  </div>
		</div>

		<!-- 이름/연락처 입력Modal -->
		<div class="modal fade" id="phoneModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">Code is U 본인인증</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
                        <form id="phonenum">
						<div class="mb-3">
							<label for="exampleFormControlInput1" class="form-label">이 름</label>
							<input type="text" class="form-control" id="joinName" name="joinName" placeholder="성함을 입력해주세요" required />
						</div>
						<div class="mb-3">
							<label for="exampleFormControlInput1" class="form-label">핸드폰 번호</label>
							<input type="text" class="form-control" id="joinPhone" name="joinPhone" placeholder="연락처를 입력해주세요" required />
						</div>
                        <div class="d-flex justify-content-center ">
                            <button id="phoneCheck" type="button" class="btn btn-dark">본인인증</button>
                            <br/>
                        </div>
                        </form >
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>

		<!--문자번호입력 Modal -->
		<div class="modal fade" id="2ndmodal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		  <div class="modal-dialog modal-sm modal-dialog-centered">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="staticBackdropLabel">문자인증</h1>

		      </div>
		      <div class="modal-body">
		      	<input type="text" name="rplyNum" id="rplyNum"> <br/>
				핸드폰에 전송된 숫자 4자리를 입력해주세요.
		      </div>
		      <div class="modal-footer d-flex justify-content-center">
		        <button type="button" class="btn btn-primary num-verify-btn" id="numSubmit">전송</button>
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		      </div>
		    </div>
		  </div>
		</div>

<div id="test"></div>

	</body>

<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert2/11.7.12/sweetalert2.min.js" integrity="sha512-JbRQ4jMeFl9Iem8w6WYJDcWQYNCEHP/LpOA11LaqnbJgDV6Y8oNB9Fx5Ekc5O37SwhgnNJdmnasdwiEdvMjW2Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>

	const typeModal = new bootstrap.Modal('#typeModal', {});
	const phoneModal = new bootstrap.Modal('#phoneModal', {});

$(function() {
	$('#stuBtn').click(function() {
		phoneModal.show();
		typeModal.hide();
	})

})

</script>
<script>
var hCode = "";
$("#phoneCheck").click(function(){




    $.ajax({
        url: "/user/phonecheck?${_csrf.parameterName}=${_csrf.token}",
        type: "POST",
        data: $("#phonenum").serialize(),
        dataType: "text", //받는것

        success: function (data) {
        	console.log(data)
            alert(data);
        	if(data=="OK") {
        		const myModal = new bootstrap.Modal('#2ndmodal', {});

        		myModal.show();
        	}
        }
    });

})


</script>
<script type="text/javascript">

const header = "${_csrf.headerName}";
const token = "${_csrf.token}";

$("#numSubmit").click(function(){
	var joinPhone = $('#joinPhone').val();
	var rplyNum = $('#rplyNum').val();
	var joinName = $('#joinName').val();

	var data = {
		smsRcvr : joinPhone,
		smsCn : rplyNum,
		userNm : joinName
	}


	$.ajax({
		url: "/user/numcheck",
		type: "POST",
		contentType: 'application/json;charset=utf-8',
		beforeSend: function (xhr) {
		      xhr.setRequestHeader(header, token);
		},
		data: JSON.stringify(data),
		dataType: "text",

		success: function(data) {
			console.log("[문자인증번호 확인 결과]" + data);
			if(data == "MATCH") {
				alert("인증번호가 일치합니다. 회원가입진행");
				location.href='/user/signup';
			} else {
				alert("입력하신 인증번호가 일치하지않습니다.");
			}
		}
	})
})

</script>
</html>
