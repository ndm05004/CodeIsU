<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!-- Favicon icon -->
<link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/assets/images/favicon.png">
<title>로그인</title>
<!-- Custom CSS -->
<link href="${pageContext.request.contextPath}/dist/css/style.css" rel="stylesheet">
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-bulma@5.0.15/bulma.min.css">
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
		<div class="auth-wrapper d-flex no-block justify-content-center align-items-center position-relative" style="background: url(/assets/images/login_bg.png) no-repeat center center; background-size: cover;">
			<div class="col-md-3">

				<div class="card">
					<div class="card-body">
						<div class="mb-5 text-center"><img src="${pageContext.request.contextPath}/assets/images/ddit_logo01.png" height="45px"></div>
						<div class="">
							<form class="mt-4" action="/login" method="post">
								<div class="row">
									<div class="col-lg-12">
										<div class="form-group mb-3">
											<input class="form-control" id="uname" type="text" name="userNo" placeholder="아이디">
										</div>
									</div>
									<div class="col-lg-12">
										<div class="form-group mb-2">
											<input class="form-control" id="pwd" type="password" name="userPswd" placeholder="비밀번호">
										</div>
									</div>
									<c:if test="${failMsg ne null && failMsg ne ''}">
										<div class="col-lg-12 fs-6">
											<p style="color: red; font-weight: 600;">${failMsg}</p>
										</div>
									</c:if>
			
									<div class="col-lg-12 mb-5">
									<input type="checkbox" id="remember-me" name="remember-me" />
									<label for="remember-me" >로그인 유지하기</label>
									</div>
			
									<div class="col-lg-12 text-center">
										<button type="submit" class="btn btn-primary w-100">로그인</button>
									</div>
									<div class="col-lg-12 text-center mt-2">
										<a href="#" class="text-muted" data-bs-toggle="modal" data-bs-target="#findIdModal">아이디 찾기</a> | <a href="#" class="text-muted" data-bs-toggle="modal" data-bs-target="#findPsModal">비밀번호 찾기</a> | <a href="#" class="text-muted" data-bs-toggle="modal" data-bs-target="#stuPhoneModal">회원가입</a>
									</div>
									<div class="col-lg-12 text-center mt-2">
									시연 로그인 :
										<select id="idSelector">
											<option value="0">로그인 정보를 선택해주세요</option>
											<option value="1">원생:S2301201 홍기태</option>
											<option value="2">원생:S2302101 김취준</option>
											<option value="3">행정직원:E2301001 김행정</option>
											<option value="5">강사:E2302007 김강사 </option>
											<option value="4">강사:E2302001 설경희</option>
											<option value="6">원생: 김신규</option>
										</select>

									</div>
								</div>
								<sec:csrfInput/>
							</form>
						</div>

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
	<script src="${pageContext.request.contextPath}/assets/libs/popper.js/dist/umd/popper.min.js "></script>
	<script src="${pageContext.request.contextPath}/assets/libs/bootstrap/dist/js/bootstrap.min.js "></script>
	<!-- ============================================================== -->
	<!-- This page plugin js -->
	<!-- ============================================================== -->
	<script>
        $(".preloader ").fadeOut();
    </script>




		<!-- 이름/연락처 입력Modal -->
		<div class="modal fade" id="stuPhoneModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">Code is U 본인인증</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="text-center mb-2">
						회원가입은 사전에 등록된 원생만 <br>핸드폰번호 문자인증 후 가입가능합니다. <br>
						</div>
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
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
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
		      <div class="modal-body text-center">
		      	<input type="text" name="rplyNum" id="rplyNum"> <br/>
				<br/>
				<div id="timer0" class="text-center" >[05:00]</div>

				핸드폰에 전송된<br>숫자 4자리를 입력해주세요.
		      </div>
		      <div class="modal-footer d-flex justify-content-center">
		        <button type="button" class="btn btn-primary num-verify-btn" id="numSubmit">전송</button>
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		      </div>
		    </div>
		  </div>
		</div>

		<!-- 원생 번호찾기/사번찾기 Modal -->
		<div class="modal fade" id="findIdModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">원생번호 / 사번 찾기</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="text-center mb-2">
						이름과 이메일 주소를 입력하면 <br>아이디(원생번호/사번)를 찾을 수 있습니다.<br/>
						</div>
												<form>
						<div class="mb-3">
							<label for="idfind-name" class="form-label">이 름</label>
							<input type="text" class="form-control" id="idfind_name" name="idfind_name" placeholder="성함을 입력해주세요" required />
						</div>
						<div class="mb-3">
							<label for="idfind-brdt" class="form-label">생년월일</label>
							<input type="text" class="form-control" id="idfind_brdt" name="idfind_brdt" placeholder="생년월일을 입력해주세요" required />
						</div>
						<div class="mb-3">
							<label for="idfind-email" class="form-label">이메일 주소</label>
							<input type="text" class="form-control" id="idfind_email" name="idfind_email" placeholder="이메일주소를 입력해주세요" required />
						</div>
												<div class="d-flex justify-content-center ">
														<button id="idfind-btn" type="button" class="btn btn-dark">아이디 조회</button>
														<br/>
												</div>
												</form >
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 비밀번호 Modal -->
		<div class="modal fade" id="findPsModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">비밀번호 찾기</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="text-center mb-2">
						아래 내용을 입력하면 <br>임시 비밀번호가 전송됩니다. <br>
						</div>
												<form>
						<div class="mb-3">
							<label for="psfind_id" class="form-label">아이디 (원생번호/사번)</label>
							<input type="text" class="form-control" id="psfind_id" name="psfind_id" placeholder="아이디를 입력해주세요" required />
						</div>
						<div class="mb-3">
							<label for="psfind_brdt" class="form-label">생년월일</label>
							<input type="text" class="form-control" id="psfind_brdt" name="psfind_brdt" placeholder="생년월일을 입력해주세요" required />
						</div>
						<div class="mb-3">
							<label for="psfind_phone" class="form-label">핸드폰번호</label>
							<input type="text" class="form-control" id="psfind_phone" name="psfind_phone" placeholder="이메일주소를 입력해주세요" required />
						</div>
												<div class="d-flex justify-content-center ">
														<button id="psfind-btn" type="button" class="btn btn-dark">비밀번호 찾기</button>
														<br/>
												</div>
												</form >
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>




</body>



<script> <!-- 자동로그인 -->
var idSelector = document.getElementById("idSelector");
var unameInput = document.getElementById("uname");
var pwdInput = document.getElementById("pwd");

idSelector.addEventListener("change", function() {
	var selectedValue = idSelector.value;

	switch (selectedValue) {
		case "1":
			unameInput.value = "S2301201";
			pwdInput.value = "1234123412";
			break;
		case "2":
			unameInput.value = "S2302101";
			pwdInput.value = "1234123412";
			break;
		case "3":
			unameInput.value = "E2301001";
			pwdInput.value = "1234123412";
			break;
		case "4":
			unameInput.value = "E2302001";
			pwdInput.value = "1234123412";
			break;
		case "5":
			unameInput.value = "E2302007";
			pwdInput.value = "1234123412";
			break;
		case "6":
			unameInput.value = "S2308025";
			pwdInput.value = "1234123412";
			break;
		default:
			break;
	}
})

</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert2/11.7.12/sweetalert2.min.js" integrity="sha512-JbRQ4jMeFl9Iem8w6WYJDcWQYNCEHP/LpOA11LaqnbJgDV6Y8oNB9Fx5Ekc5O37SwhgnNJdmnasdwiEdvMjW2Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<script> <!-- 아이디 찾기 -->
$('#idfind-btn').on('click', function(){
	let idfind_name = $('#idfind_name').val();
	let idfind_email = $('#idfind_email').val();
	let idfind_brdt = $('#idfind_brdt').val();

	let data = {
		userNm : idfind_name,
		userEmlAddr : idfind_email,
		userBrdt : idfind_brdt
	}

	$.ajax({
        url: "/user/findid?${_csrf.parameterName}=${_csrf.token}",
				contentType: 'application/json;charset=utf-8',
        type: "POST",
        data: JSON.stringify(data),
        dataType: "json", //받는것

        success: function (data) {
        	console.log(data)
					$('#findIdModal').modal('hide');
        	if(data.state=="EXIST") {

						Swal.fire({
							title: '아이디 조회 결과',
							text: `회원님의 아이디는 \${data.id} 입니다. `
						})
						
        	} else {
						Swal.fire({
							title: '아이디 조회 결과',
							text: `찾으시는 정보가 없습니다`
						})
					}
        }
    });

})

// 아이디 찾기 결과값 전달

</script>
<script> <!-- 비밀번호 찾기 -->
	$('#psfind-btn').on('click', function(){
		let psfind_id = $('#psfind_id').val();
		let psfind_brdt = $('#psfind_brdt').val();
		let psfind_phone = $('#psfind_phone').val();
	
		let data = {
			userNo : psfind_id,
			userPhoneno : psfind_phone,
			userBrdt : psfind_brdt
		}
		console.log("비밀번호찾기 시도", data);
		$.ajax({
					url: "/user/findps?${_csrf.parameterName}=${_csrf.token}",
					contentType: 'application/json;charset=utf-8',
					type: "POST",
					data: JSON.stringify(data),
					dataType: "text", //받는것
	
					success: function (res) {
						console.log(data)
						$('#findIdModal').modal('hide');
						if(res=="OK") {
	
							Swal.fire({
								title: '임시비밀번호 발급',
								text: `임시비밀번호가 \${psfind_phone}로 전송되었습니다. `
							})
							
						} else {
							Swal.fire({ 
								title: '비밀번호 찾기 결과',
								text: `일치하는 정보가 없습니다`
							})
						}
					}
			});
	
	})
	
	// 아이디 찾기 결과값 전달
	
	</script>


<script> <!-- 회원가입 -->
var hCode = "";
$("#phoneCheck").click(function(){



    $.ajax({
        url: "/user/phonecheck?${_csrf.parameterName}=${_csrf.token}",
        type: "POST",
        data: $("#phonenum").serialize(),
        dataType: "text", //받는것

        success: function (data) {

        	if(data=="OK") {
        		const myModal = new bootstrap.Modal('#2ndmodal', {});

        		myModal.show();
				timerStart();


        	} else if(data=="EXIST") {
						Swal.fire(
                        '이미 가입한 회원!',
                        '이미 가입된 회원입니다. 비밀번호 찾기를 이용해주세요.',
                        'error'
                        )
	
					} else {
						Swal.fire({
											title: '원생 불일치!',
											icon: 'error',
											html: `입력하신 이름과 핸드폰번호로 <br> 일치하는 원생이 없습니다. <br> 다시 확인해주세요.`,
											confirmButtonText: '확인',
										});
					}
        }, 
				error: function () {
					Swal.fire(
                        '서버오류!',
                        '서버오류입니다. 다시 시도해주세요!',
                        'error'
                        )
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


					
						
						Swal.fire({
						title: '인증번호 일치!',
						icon: 'success',
						html: '회원가입페이지로 이동합니다.',
						confirmButtonText: '확인',
}).then((result) => {
                            if(result.isConfirmed) {
                                location.href = "/user/signup";
                            }
                        })

			} else {
				Swal.fire(
                        '인증번호 불일치!',
                        '입력하신 인증번호가 일치하지않습니다.',
                        'error'
                        )
			}
		}
	})
})

</script>
<script> // 카운트다운 5분
  var countdownElement = document.getElementById('countdown');
  var timeInSeconds = 300; // 5 minutes

  function updateCountdown() {
    var minutes = Math.floor(timeInSeconds / 60);
    var remainingSeconds = timeInSeconds % 60;

    // Add leading zero for minutes and seconds less than 10
    minutes = minutes < 10 ? '0' + minutes : minutes;
    remainingSeconds = remainingSeconds < 10 ? '0' + remainingSeconds : remainingSeconds;

    countdownElement.textContent = "[" + minutes + ":" + remainingSeconds + "]";

    if(timeInSeconds > 0) {
      timeInSeconds--;
    } else {
      clearInterval(interval);
    }
  }

</script>

<script>
const autoComplete = () => {
    $(document).keydown(function (event) {
      if (event.keyCode == "220") {
        storageAutoComplete();
      }
    });
  };

  const storageAutoComplete = () => {
		document.querySelector('#joinName').value = "김신입";
		document.querySelector('#joinPhone').value = "01090007608";
  };
  autoComplete();

</script>

<script>// 5분 타이머
function timerStart(){
	let timeLeft = 5 * 60; // 5분을 초로 환산
	const timerDisplay = document.getElementById('timer0');

	function updateTimerDisplay() {
		const minutes = Math.floor(timeLeft / 60).toString().padStart(2, '0');
		const seconds = (timeLeft % 60).toString().padStart(2, '0');
		timerDisplay.textContent = `[\${minutes}:\${seconds}]`;
	}

	setInterval(() => {
		if (timeLeft > 0) {
			timeLeft--;
			updateTimerDisplay();
		} else {
			// 타이머 종료 시 실행할 코드
			alert("타이머가 종료되었습니다!");
			clearInterval(this);  // 타이머 중지
		}
	}, 1000);
}
</script>

</html>


