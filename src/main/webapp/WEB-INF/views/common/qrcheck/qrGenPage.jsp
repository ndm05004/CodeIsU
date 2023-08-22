<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CodeIsU 스마트 출석체크</title>
<style></style>
<link rel="stylesheet" href="/dist/css/font.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.12/dist/sweetalert2.all.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.12/dist/sweetalert2.min.css" rel="stylesheet">
<style>
body {
  background-color: black;
  font-family: 'Noto Sans KR', "Rubik", sans-serif;
}
.wraper {
  margin: auto auto auto auto;
  width: 700px;
  text-align: center;
}

.wraper img {
    display: block;
    margin: 0 auto;
  }
.wraper p {
  color: white;
  font-size: 18px;
}



#divClock {
  font-size: 24px;
  color: white;
}

</style>
</head>
<body>
<div class="wraper">
<img src="/dist/img/ddit_logo05.png" style="width: 60%; margin-top: 8px;" alt="CodeIsU 로고" >
<p>스마트 QR 출석체크</p>

<img id="qrImg" src="" alt="qr코드"  >


<div id="divClock" class="clock">
</div>
<p style="color: black; background: red; font-weight: 600; font-size: 24px;">5초 마다 QR코드 토큰이 갱신됩니다.</p>
<!-- <script>
  var currentDate = new Date().toLocaleDateString();
document.write(currentDate)</script>날짜 -->
</div>
</body>
<script>

$(document).keydown(function(event) {
	  if (event.keyCode == '220') {
	    alert('백슬래시 누름');
	  }
	})
</script>


<script type="text/javascript">
showClock();
  function showClock(){
    var currentDate = new Date();
    var divClock = document.getElementById('divClock');

    var msg = "현재 시간 : ";

    msg += currentDate.getFullYear() +"년 ";
    msg += currentDate.getMonth()+1 + "월 ";
    msg += currentDate.getDate() + "일 ";
    msg += currentDate.getHours()+"시 ";


    msg += currentDate.getMinutes()+"분 ";
    msg += currentDate.getSeconds()+"초";

    divClock.innerText = msg;

    if (currentDate.getMinutes()>58) {    //정각 1분전부터 빨강색으로 출력
      divClock.style.color="red";
    }
    setTimeout(showClock,1000);  //1초마다 갱신
  }
</script>
<script type="text/javascript">
var onceRun = null;
reloadQrCode();
setInterval(reloadQrCode, 5000);

function reloadQrCode() {
  console.log('set타임아웃 실행')
	$.ajax({
		url: "/qrcheck/reloadQR?${_csrf.parameterName}=${_csrf.token}",
		type: "post",
		dataType: "text",
		success: function(res) {
			(function() {
			    if(onceRun == null){
			    	onceRun = "한번 실행완료";
			    	Swal.fire(
			    			  'QR토큰 DB연동',
			    			  '정상적으로 서버와 연결되었습니다',
			    			  'success'
			    			)

			    }
			})()
      if(!(res == "FAILED")) {
        var src = "https://chart.apis.google.com/chart?cht=qr&chs=540x540&chl=";
        var qrImg = document.getElementById('qrImg');
        qrImg.src = src + res;
      } else {
        alert("QR코드 토큰이 DB에 정상적으로 저장되지 않았습니다.");
      }
		},
		error: function() {
      alert('Ajax오류');
		}

	})
}
</script>
</html>