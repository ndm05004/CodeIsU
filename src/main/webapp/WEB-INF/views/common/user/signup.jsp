<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/assets/images/favicon.png">
    <title>회원가입</title>
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/dist/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-bulma@5.0.15/bulma.min.css">
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
        <div class="auth-wrapper d-flex no-block justify-content-center align-items-center position-relative">
            <div class="row text-start justify-content-center">

                <div class="col-lg-10 col-md-9 bg-white">
                    <div class="p-3">
                        <h2 class="mt-3 text-center mb-5"><b>CodeIsU 회원가입</b></h2>
                        <form action="/user/signup?${_csrf.parameterName}=${_csrf.token}" id="joinForm" method="post" enctype="multipart/form-data">
                            <div class="row mb-3">
                            <label for="svlfNm" class="col-sm-4 col-form-label">교육과정명</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" name="svlfNm" value="${userData.svlfNm}" readonly>
                            </div>
                            </div>
                            <div class="row mb-3">
                                <label for="userNo" class="col-sm-4 col-form-label">원생번호</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="userNo" value="${userData.userNo}" readonly/>
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

                                    <input type="radio" id="M" name="userGender" value="M" <c:if test="${userData.userGender eq 'M'}">checked</c:if>>
                                    <label for="M" style="font-size: 22px;">남성</label>
                                    <input type="radio" id="F" name="userGender" value="F" <c:if test="${userData.userGender eq 'F'}">checked</c:if>>
                                    <label for="F" style="font-size: 22px;">여성</label>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label for="userPswd" class="col-sm-4 col-form-label">비밀번호</label>
                                <div class="col-sm-8">
                                    <input type="password" class="form-control" name="userPswd">
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label for="userPswd2" class="col-sm-4 col-form-label">비밀번호 확인</label>
                                <div class="col-sm-8">
                                    <input type="password" class="form-control" name="userPswd2">
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label for="userEmlAddr" class="col-sm-4 col-form-label">이메일</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="userEmlAddr">
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label for="userPhoneno" class="col-sm-4 col-form-label">핸드폰 번호</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="userPhoneno" value="${userData.userPhoneno}" readonly >
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-7 mx-0">
                                    <label for="userAddr" class="form-label">기본주소</label>
                                    <input type="text" class="form-control" name="userAddr" placeholder="기본주소를 입력해주세요">
                                </div>
                                <div class="col-md-2 ps-0">
                                    <label for="userZip" class="form-label">우편번호</label>
                                    <input type="text" class="form-control" name="userZip">
                                </div>
                                <div class="col-md-2 ps-0 d-flex align-items-end justify-content-end">
                                    <button type="button" class="btn btn-primary" onclick="postcode()">검색</button>
                                </div>
                            </div>

                            <div class="col mb-3">
                                <label for="userDaddr" class="form-label">상세주소</label>
                                <input type="text" class="form-control" name="userDaddr" placeholder="상세주소를 입력해주세요">
                            </div>
                            <div class="row mb-3">
                                <label for="profileFile" class="col-sm-4 col-form-label">프로필사진</label>
                                <div class="col-sm-8">
                                    <input type="file" class="form-control" name="profileFile" required>
                                </div>
                            </div>

                            <div class="row mb-4">
                                <div class="form-check col d-flex justify-content-center">
                                    <input class="form-check-input" type="checkbox" value="Y" id="userPrvcYn" name="userPrvcYn">
                                    <label class="form-check-label" for="userPrvcYn">
                                        개인정보 동의
                                    </label>
                                    <button type="button" class="btn btn-primary mx-7">약관읽기</button>
                                </div>
                            </div>

                            <div class="row-lg-12 text-center mb-3">
                                <button type="button" id="joinBtn" class="btn w-100 btn-dark">회원가입</button>
                            </div>
                            <div class="row-lg-12 text-center mb-3">
                                이미 회원이신가요? <a href="#" class="text-danger">로그인하기</a>
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="${pageContext.request.contextPath}/assets/libs/popper.js/dist/umd/popper.min.js "></script>
    <script src="${pageContext.request.contextPath}/assets/libs/bootstrap/dist/js/bootstrap.min.js "></script>
    <!-- ============================================================== -->
    <!-- This page plugin js -->
    <!-- ============================================================== -->
    <script>
        $(".preloader ").fadeOut();
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert2/11.7.12/sweetalert2.min.js" integrity="sha512-JbRQ4jMeFl9Iem8w6WYJDcWQYNCEHP/LpOA11LaqnbJgDV6Y8oNB9Fx5Ekc5O37SwhgnNJdmnasdwiEdvMjW2Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- 다음주소api -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script> // 주소API 설정
    function postcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    // document.getElementById("sample6_extraAddress").value = extraAddr;

                } else {
                    // document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementsByName("userZip")[0].value = data.zonecode;
                document.getElementsByName("userAddr")[0].value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementsByName("userDaddr")[0].focus();
            }
        }).open();
    }
</script>
<script>
$(function() {
    $('#joinBtn').on("click", function(){
        event.preventDefault();

        var form = $('#joinForm')[0];
        var formData = new FormData(form);

        console.log("data", formData);

        $.ajax({
            url : '/user/signup?${_csrf.parameterName}=${_csrf.token}',
            type: 'POST',
            data: formData,
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            cache: false,
            success: function (data) {
                if (data == "OK") {

                    Swal.fire(
                        '원생번호 [${userData.userNo}] 가입성공',
                        '로그인페이지로 이동합니다.',
                        'success'
                        ).then((result) => {
                            if(result.isConfirmed) {
                                location.href = "/";
                            }
                        })
                } else {
                    Swal.fire(
                        '가입실패',
                        '초기 로그인페이지로 이동합니다.',
                        'error'
                        )
                }
            }



        })
    })
})

</script>
<script> // 자동완성
    const autoComplete = () => {
        $(document).keydown(function (event) {
          if (event.keyCode == "220") {
            storageAutoComplete();
          }
        });
      };

      const storageAutoComplete = () => {
            $('input[name="userPswd"]').val('1234123412');
            $('input[name="userPswd2"]').val('1234123412');
            $('input[name="userEmlAddr"]').val('kimnew@ddit.or.kr');
            $('input[name="userAddr"]').val('대전시 중구 에러동');
            $('input[name="userZip"]').val('12312');
            $('input[name="userDaddr"]').val('4층 404호');
            const checkbox = document.getElementById("userPrvcYn");
            checkbox.checked = true;

      };
      autoComplete();

    </script>

</body>

</html>