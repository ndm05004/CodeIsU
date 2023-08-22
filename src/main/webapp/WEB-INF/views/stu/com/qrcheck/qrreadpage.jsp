<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>CodeIsU 스마트QR 출결시스템</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="/jsQR/docs/jsQR.js"></script>
  <link href="https://fonts.googleapis.com/css?family=Ropa+Sans" rel="stylesheet">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js" integrity="sha512-57oZ/vW8ANMjR/KQ6Be9v/+/h6bq9/l3f0Oc7vn6qMqyhvPd1cvKBRWWpzu0QoneImqr2SkmO4MSqU+RpHom3Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.min.css" integrity="sha512-ELV+xyi8IhEApPS/pSj66+Jiw+sOT1Mqkzlh8ExXihe4zfqbWkxPRi8wptXIO9g73FSlhmquFlUOuMSoXz5IRw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="/dist/css/style.css" rel="stylesheet">
<script src="/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.12/dist/sweetalert2.all.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.12/dist/sweetalert2.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f9fbfd;
      font-family: 'Ropa Sans', sans-serif;
      color: #333;
      max-width: 640px;
      margin: 0 auto;
      position: relative;
    }

    #githubLink {
      position: absolute;
      right: 0;
      top: 12px;
      color: #2D99FF;
    }

    h1 {
      margin: 10px 0;
      font-size: 40px;
    }

    #loadingMessage {
      text-align: center;
      padding: 40px;
      background-color: #eee;
    }

    #canvas {
      width: 100%;
    }

    #output {
      margin-top: 20px;
      background: #eee;
      padding: 10px;
      padding-bottom: 0;
    }

    #output div {
      padding-bottom: 10px;
      word-wrap: break-word;
    }

    #noQRFound {
      text-align: center;
    }
  </style>
</head>
<body>
  <div class="container-md">

  <nav class="navbar bg-white">
    <div class="container-fluid">
      <span class="navbar-brand mb-0 h1"><img src="/resources/img/codeisu_logo_m.gif" style="height: 24px;" alt="" ></span>
      <span class="h4">스마트QR 출결시스템</span>
    </div>
  </nav>

  
</a>
</a>

<div class="row">
  <div class="col-12">
      <div class="card">
          <div class="card-body">
            <img src="${pageContext.request.contextPath}<sec:authentication property='principal.member.userProfile'/>" alt="user" class="rounded-circle"
            width="40">
            <span class="text-dark"><sec:authentication property="principal.member.userNm"/></span>
              <span class="page-title text-truncate text-dark font-weight-medium mb-1">님 환영합니다.</span>
      
          </div>
      </div>
  </div>
</div>
<h4 class="page-title text-truncate text-dark font-weight-medium mb-1">나의 출결 내역</h4>

<div class="row">
  <div class="col-12">
      <div class="card">
          <div class="card-body text-center">

            <div class="row">
              <div class="col-3">
                <div id="" class="text-muted">날짜</div>
              </div>
              <div class="col-3">
                <div id="" class="text-muted">입실</div>
              </div>
              <div class="col-3">
                <div id="" class="text-muted">퇴실</div>
              </div>
              <div class="col-3">
                <div id="" class="text-muted">상태</div>
              </div>
            </div>
            <div class="row ">
              <div class="col-3">
                <div ><div id="pDate"></div></div>
              </div>
              <div class="col-3">
                <div id="sTime">${attd.attdAbmiYmd}</div>
              </div>
              <div class="col-3 ">
                <div id="eTime">${attd.attdLeaveYmd}</div>
              </div>
              <div class="col-3 ">
                <div id="attdStatus">${attd.attdCd}</div>
              </div>
            </div>

          </div>
      </div>
  </div>
</div>


<div class="row">
  <div class="col-12">
    <div class="card">
      <div class="card-body">

        <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
          <input type="radio" class="btn-check" name="attdSelect" id="btnradio1" autocomplete="off" checked>
          <label class="btn btn-outline-primary" for="btnradio1">입실</label>
          <input type="radio" class="btn-check" name="attdSelect" id="btnradio2" autocomplete="off" >
          <label class="btn btn-outline-primary" for="btnradio2">퇴실</label>
        </div>
        <span class="page-title text-truncate text-dark font-weight-medium mb-1">스마트QR인증 (현재시간: <span id="pTime"></span>)</span>


        <div id="loadingMessage">🎥 CodeIsU 스마트QR 출결시스템을 위해 <br />스마트폰 카메라 권한을 활성화해주세요!</div>
        <canvas id="canvas" hidden></canvas>
        <div id="output" hidden>
          <div id="outputMessage">스마트QR 출결코드를 인식해주세요</div>
          <div hidden><b>인식완료:</b> <span id="outputData"></span></div>
        </div>



      </div>
    </div>
  </div>
</div>


  </div>
<script>// 오늘날짜, 현재시간 나타냄
    function getFormattedDate() {
        const now = new Date();
        const year = now.getFullYear();
        const month = String(now.getMonth() + 1).padStart(2, '0');
        const day = String(now.getDate()).padStart(2, '0');

        const formattedDate = month + '/' + day ;
        return formattedDate;
    }

    // 오늘 날짜를 표시하는 함수 호출하여 표시
    document.getElementById('pDate').innerText = getFormattedDate();

    function updateClock() {
        const now = new Date();
        const hours = String(now.getHours()).padStart(2, '0');
        const minutes = String(now.getMinutes()).padStart(2, '0');
        const seconds = String(now.getSeconds()).padStart(2, '0');

        const timeString = hours + ':' + minutes + ':' + seconds;
        document.getElementById('pTime').innerText = timeString;
    }

    // 최초에 한 번 호출하여 초기값 설정
    updateClock();

    // 1초마다 updateClock 함수 호출하여 시간을 갱신
    setInterval(updateClock, 1000);
</script> 



<script> // QRjs
    var video = document.createElement("video");
    var canvasElement = document.getElementById("canvas");
    var canvas = canvasElement.getContext("2d");
    var loadingMessage = document.getElementById("loadingMessage");
    var outputContainer = document.getElementById("output");
    var outputMessage = document.getElementById("outputMessage");
    var outputData = document.getElementById("outputData");

    var timer; // 쿨타임을 위해 시간을 바꿈
    var attdSelect = document.getElementsByName("attdSelect");

    var attdState = 'loading'; // 출결 상태



    function drawLine(begin, end, color) {
      canvas.beginPath();
      canvas.moveTo(begin.x, begin.y);
      canvas.lineTo(end.x, end.y);
      canvas.lineWidth = 4;
      canvas.strokeStyle = color;
      canvas.stroke();
    }

    // Use facingMode: environment to attemt to get the front camera on phones
    navigator.mediaDevices.getUserMedia({ video: { facingMode: "environment" } }).then(function(stream) {
      video.srcObject = stream;
      video.setAttribute("playsinline", true); // required to tell iOS safari we don't want fullscreen
      video.play();
      requestAnimationFrame(tick);
    });

    function tick() {
      loadingMessage.innerText = "⌛ 화면을 로딩중입니다"
      if (video.readyState === video.HAVE_ENOUGH_DATA) {
        loadingMessage.hidden = true;
        canvasElement.hidden = false;
        outputContainer.hidden = false;

        canvasElement.height = video.videoHeight;
        canvasElement.width = video.videoWidth;
        canvas.drawImage(video, 0, 0, canvasElement.width, canvasElement.height);
        var imageData = canvas.getImageData(0, 0, canvasElement.width, canvasElement.height);
        var code = jsQR(imageData.data, imageData.width, imageData.height, {
          inversionAttempts: "dontInvert",
        });




        if (code) { // QR코드가 인식되었을 경우


          if (code.data.substr(0, 15) == 'codeisuQRCheck-') {

            if(!timer) {
            //ajax
            console.log('쿨타임 1초')
            var ipsilTime = $('#pTime').text().substr(0,5);
            $('#sTime').text(ipsilTime);
            $('#attdStatus').text("출석");
            document.getElementById("btnradio2").checked = true;

            
            timer = 'cooltime'; // 값을 줘서 재실행을 막음
            Swal.fire(
              '입실 체크 완료!',
              '<sec:authentication property="principal.member.userNm"/>님 정상적으로 출결처리 되었습니다.',
              'success'
            )



            setTimeout(function(){
              timer=null;
            }, 5000)
          }


          }







          drawLine(code.location.topLeftCorner, code.location.topRightCorner, "#FF3B58");
          drawLine(code.location.topRightCorner, code.location.bottomRightCorner, "#FF3B58");
          drawLine(code.location.bottomRightCorner, code.location.bottomLeftCorner, "#FF3B58");
          drawLine(code.location.bottomLeftCorner, code.location.topLeftCorner, "#FF3B58");
          outputMessage.hidden = true;
          outputData.parentElement.hidden = false;
          // outputData.innerText = code.data;
          outputData.innerText = '스마트QR 출결시스템 QR코드가 인식되었습니다.';
        } else {
          outputMessage.hidden = false;
          outputData.parentElement.hidden = true;
        }
      }
      requestAnimationFrame(tick);
    }

    function sendQRcode(token) {
      // ajax


    }
  </script> 


<!--
  <script>// 출석체크 로직


	// 출석체크
	var header = '${_csrf.headerName}';
	var token =  '${_csrf.token}';
	var userNo = "<sec:authentication property='principal.member.userNo'/>"

  var attendYn = false;


	$(function(){
		let sBtn = $("#sBtn");
		let eBtn = $("#eBtn");

		startTime()
		userCheck(userNo);

		//입실 버튼 클릭 시
		sBtn.on("click", function(){
			let time = $("#clock").text();
			let dayInfo = $("#dDay").text();

			time = time.substring(0,5);
			$("#sTime").text(time);

			data = {
				"attdAbmiYmd" : time,
				"stuNo" : userNo,
				"attdDt" : dayInfo
			}

			inClass(data);
		})

		//퇴실 버튼 클릭 시
		eBtn.on("click", function(){
			let time = $("#clock").text();
			let dayInfo = $("#dDay").text();

			time = time.substring(0,5);
			$("#eTime").text(time);

			data = {
				"attdLeaveYmd" : time,
				"stuNo" : userNo,
				"attdDt" : dayInfo
			}

			outClass(data);
		})

	})

	function startTime() {
		var today = new Date();
		var h = today.getHours();
		var m = today.getMinutes();
		var s = today.getSeconds();
		h = checkTime(h);
		m = checkTime(m);
		s = checkTime(s);
		document.getElementById('clock').innerHTML =
		h + ":" + m + ":" + s;
		var t = setTimeout(startTime, 500);

		var yyyy = today.getFullYear();
		var mm = String(today.getMonth() + 1).padStart(2, '0');
		var dd = String(today.getDate()).padStart(2, '0');
		var formattedDate = yyyy + "-" + mm + "-" + dd;

		$("#dDay").text(formattedDate);
	}

	function checkTime(i) {
		if (i < 10) {i = "0" + i}; // 숫자가 10보다 작을 경우 앞에 0을 붙여줌
		return i;
	}

	function userCheck(userNo){
		$.ajax({
			url : "/stu/dong/usercheck",
			type : "get",
			data : {"userNo" : userNo},
			dataType : "text",
			success : function(res){
				let dayInfo = $("#dDay").text();

				data = {
					"stuNo" : userNo,
					"attdDt" : dayInfo
				}

				if(res == "inData"){
					selectData(data)
				}else{
					attdInsert(data);
				}
			}
		})
	}

	function selectData(data){
		$.ajax({
			url : "/stu/dong/selectData",
			type : "get",
			data : data,
			dataType : "json",
			success : function(res){

				//입실 정보가 있을 경우
				if(res.attdAbmiYmd != null){
					//퇴실 정보가 있을 경우
					if(res.attdLeaveYmd != null){
						$("#sTime").text(res.attdAbmiYmd)
						$("#eTime").text(res.attdLeaveYmd)
					}else{
						$("#sTime").text(res.attdAbmiYmd)
					}
					$("#attdStatus").text(res.attdCd);
					$("#sBtn").prop("disabled", true);
					$("#eBtn").prop("disabled", false);
				}else{
					$("#sBtn").prop("disabled", false);
					$("#eBtn").prop("disabled", true);
				}
			}
		})
	}

	function attdInsert(data){
		$.ajax({
			url : "/stu/dong/attdInsert",
			type : "post",
			contentType : "application/json;charset=utf-8",
			beforeSend : function(xhr){
				xhr.setRequestHeader(header, token);
			},
			data : JSON.stringify(data),
			dataType : "text",
			success : function(res){
				console.log(res)

				if(res == "실패"){
					alert("실패");
				}else{
					$("#dDay").text(res);
				}
			}
		})
	}

	function inClass(data){
		$.ajax({
			url : "/stu/dong/inClass",
			type : "post",
			contentType : "application/json;charset=utf-8",
			beforeSend : function(xhr){
				xhr.setRequestHeader(header, token);
			},
			data : JSON.stringify(data),
			dataType : "text",
			success : function(res){
				let dayInfo = $("#dDay").text();

				data = {
					"stuNo" : userNo,
					"attdDt" : dayInfo
				}

				if(res === "OK"){
          // 입실 성공
          Swal.fire(
          '출석',
          '입실이 완료되었습니다!',
          'success'
          ).then((result) => {
            let sBtn = $("#sBtn");
            let eBtn = $("#eBtn");

            selectData(data)
            // 입실 스타일 변경

          })


				}
			}
		})
	}

	function outClass(data){
		$.ajax({
			url : "/stu/dong/outClass",
			type : "post",
			contentType : "application/json;charset=utf-8",
			beforeSend : function(xhr){
				xhr.setRequestHeader(header, token);
			},
			data : JSON.stringify(data),
			dataType : "text",
			success : function(res){

				let dayInfo = $("#dDay").text();

				data = {
					"stuNo" : userNo,
					"attdDt" : dayInfo
				}
				if(res === "OK"){
          Swal.fire(
          '출석',
          '퇴실이 완료되었습니다!',
          'success'
          ).then((result) => {
            selectData(data)

          })
				}
			}
		})
	}

  </script>
-->
</body>
</html>
