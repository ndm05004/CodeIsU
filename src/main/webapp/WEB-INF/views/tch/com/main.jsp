<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
    .myClassCard{
        cursor: pointer;
    }

    /* 프로젝트내용 마우스오버 */
    .hover-text-container {
      position: relative;
    }

    .hover-text {
    display: none;
    position: absolute;
    width: 400px;
    top: 10%;
    left: 0;
    background-color: #444444;
    color: #ffffff;
    padding: 5px;
    white-space: normal;
    border-radius: 5px;
    transition: all ease 0.5s;
    overflow: hidden;
    overflow-y: auto;
    max-height: 200px; /* 최대 높이를 200px로 설정 */
    }

    .hover-text-container:hover .hover-text {
      display: inline-block;

    }

    /* 과제 내용 마우스 오버 */
    .hover-text-container-asmt {
      position: relative;
    }

    .hover-text-asmt {
    display: none;
    position: absolute;
    width: 300px;
    top: 10%;
    left: 0;
    background-color: #444444;
    color: #ffffff;
    padding: 5px;
    white-space: normal;
    border-radius: 5px;
    transition: all ease 0.5s;
    overflow: hidden;
    overflow-y: auto;
    max-height: 200px; /* 최대 높이를 200px로 설정 */
    }

    .hover-text-container-asmt:hover .hover-text-asmt {
      display: inline-block;

    }
</style>
<!--강사 메인 페이지-->
<div class="row">
  <div class="col-4">
    <div class="card mb-4">
      <div class="card-body">
        <div class="text-muted" id="dateBox"></div>
        <h2 class="" id="timeBox"></h2>
      </div>
    </div>
    <div class="card">
      <div class="card-body">
        <div class="row mb-2">
          <h4 class="card-title">시간표</h4>
        </div>
        <table class="table table-hover m-0">
            <thead>
                <tr>
                    <td colspan="3" class="p-0"></td>
                </tr>
            </thead>
            <tbody>
                <tr id="amClass" data-sbjctCd="">
                    <td>
                        <div class="">오전</div>
                    </td>
                    <td>
                        <div class="" id="amSbjctNm">-</div>
                    </td>
                    <td>
                        <div class="" id="amEmpNo">-</div>
                    </td>
                </tr>
                <tr id="pmClass" data-sbjctCd="">
                    <td>
                        오후
                    </td>
                    <td id="pmSbjctNm">
                        -
                    </td>
                    <td id="pmEmpNo">
                        -
                    </td>
                </tr>
            </tbody>
        </table>
      </div>
		</div>

    <!--과제 리스트-->
    <div class="card" style="height: 268px;">
      <div class="card-body">
        <div class="row mb-2">
          <h4 class="card-title">과제</h4>
        </div>
        <div id="asmtListContainer">

        </div>
      </div>
    </div>
  </div>
  <div class="col-8">
    <div class="card" style="height: 646px;">
      <div class="card-body">
        <div class="row mb-2">
          <h4 class="card-title">질문</h4>
        </div>
        <div id="qstnListContainer">
          
        </div>
      </div>
    </div>
  </div>
</div>
<script>
	var currDt = "";
	// 날짜 넣기
	function currentDateTime() {
		var currentDate = new Date();

		var year = currentDate.getFullYear(); //년
		var month = currentDate.getMonth() + 1; // 월
		var date = currentDate.getDate(); // 일
		currDt = year + "-" + (month < 10 ? "0" + month : month) + "-" + (date < 10 ? "0" + date : date); // 오늘날짜
		
		// 시간
		var hours = currentDate.getHours();
		var minutes = currentDate.getMinutes();
		// 시간, 분, 초를 두 자리 숫자 형태로 조합
		var currTime = (
			(hours < 10 ? "0" + hours : hours) + ":" +
			(minutes < 10 ? "0" + minutes : minutes) + ""
			);
		const dateBox = document.querySelector('#dateBox');
		const timeBox = document.querySelector('#timeBox');
		dateBox.innerText = currDt;
		timeBox.innerText = currTime;
	}
	// 최초 페이지 로딩시 시간 표시
	currentDateTime();
	// 1초마다 시간 업데이트
	setInterval(currentDateTime, 1000);


    // 시간표
	timetableAjax()
	function timetableAjax() {
		$.ajax({
			url: "/tch/timetable",
			type: "get",
			dataType: "json",
            success: function(res) {
                console.log("시간표",res);
				res.forEach(function(sbjct) {
                    console.log("sbjct",sbjct);
					if(sbjct.scduHr == "오전"){
						$("#amSbjctNm").text(sbjct.sbjctNm);
						$("#amEmpNo").text(sbjct.lectureRoomNm);

                        $("#amClass").attr("data-sbjctCd", sbjct.sbjctCd);
					}
					if(sbjct.scduHr == "오후"){
						$("#pmSbjctNm").text(sbjct.sbjctNm);
						$("#pmEmpNo").text(sbjct.lectureRoomNm);

                        $("#pmClass").attr("data-sbjctCd", sbjct.sbjctCd);
					}
				});
            },
            error: function(xhr, status, error) {
                // 요청이 실패했을 때 처리할 코드 작성
                alert("제발");
            }
        });
	}

    // 카드를 클릭했을 때
    $(document).on("click", ".myClassCard", function(e) {
        var sbjctCd = $(this).attr("data-sbjctCd");
        console.log(sbjctCd);
        if(sbjctCd != ""){
            location.href = "/tch/class/asmt?sbjctCd=" + sbjctCd;
        }
    })

  
  // 미답변 질문 리스트
  qstnList()
  function qstnList(){
    $.ajax({
			url: "/tch/qstnlist",
			method: 'get',
			dataType: 'json',
			success: function(res) {
				console.log("res",res);
				var qstnListStr = "";
				if(res == null || res.length == 0){
					qstnListStr += `<div>` ;
					qstnListStr += `    <p>조회하실 게시물이 존재하지 않습니다.</p>`;
					qstnListStr += `</div>`;
				} else {
					res.forEach(function(qstn, index) {
            let marginTop = "0px;"
            if(index > 0){
              marginTop = "25px;"
            }
						var qstnAns = "";
						qstnListStr += '<div class="card qstnListCard mb-0 qstnselect" data-qstnNo="' + qstn.qstnNo +'" data-sbjctCd="' + qstn.sbjctCd + '" style="margin-top: '+ marginTop +'">';
						qstnListStr += `    <div class="card-body collapse show">`
						qstnListStr += `		  <div class="row">`
						qstnListStr += `			  <div class="col-1 d-flex align-items-center pe-0"><img src=\${qstn.stuProfile} class="avatar avatar-sm rounded-circle" width="40" height="40"></div>`
						qstnListStr += `			  <div class="col-2 fs-6">`
						qstnListStr += `			  	<div>`
						qstnListStr += 				  		qstn.stuNm;
						qstnListStr += `			  	</div>`
						qstnListStr += `			  	<div class="text-muted fs-6">`
						qstnListStr += 				  		qstn.qstnDt;
						qstnListStr += `			  	</div>`
						qstnListStr += `			  </div>`
						qstnListStr += `		  	<div class="col-7 d-flex align-items-center hover-text-container">`
						qstnListStr += `		  	  <div class="font-weight-bold lineClear" >`
            qstnListStr += 				  	  stringSlice(qstn.qstnTtl, 30)
						qstnListStr += `		  	  </div>`
						qstnListStr += `		  	  <label class="hover-text card-subtitle mb-1 mt-2 ">\${qstn.qstnTtl}</label>`
						qstnListStr += `		  	</div>`
						qstnListStr += `			  <div class="col-2 position-relative">`
						qstnListStr += `			    <div class="text-muted position-absolute top-50 end-0 translate-middle-y" style="padding-right: 15px;">`
						qstnListStr += `            미답변`;
						qstnListStr += `		  	  </div>`
						qstnListStr += `		  	</div>`
						qstnListStr += `	  	</div>`
						qstnListStr += `    </div>`
						qstnListStr += `</div>`

					})
				}
				document.querySelector("#qstnListContainer").innerHTML = qstnListStr;
			},
			error: function(xhr, status, error) {
			// 요청이 실패했을 때 처리할 코드 작성
			console.error('Request failed. Status:', status);
			}
		});
  }

	// 수정 삭제 
  $(document).on("click", ".qstnselect", function(e) {
    var sbjctCd = $(this).attr("data-sbjctCd");
		var qstnNo = $(this).attr("data-qstnNo");
		location.href = "/tch/class/qstn/selectform?qstnNo=" + qstnNo + "&sbjctCd=" + sbjctCd;
	})



  // 과제 리스트 불러오기
  amstList()
  function amstList(){
        $.ajax({
            url: "/tch/asmtList",
            method: 'get',
            dataType: 'json',
            beforeSend: function(xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(res) {
                console.log("amstList",res);
                let amstListStr = "";
                res.forEach(function(asmt, index) {
                    var marginTop = "mt-0";
                    if(index>0){
                      marginTop = "mt-3"
                    }
                    console.log("asmt",asmt);
                    amstListStr += '<div class="row asmtSbmsn '+ marginTop +'" data-asmtNo="' + asmt.asmtNo + '" data-sbjctCd = "' + asmt.sbjctCd +'">';
                    amstListStr += `    <div class="col-2">`;
                    let asmtTtl = asmt.asmtTtl;
                    if(asmtTtl.length > 20){
                        asmtTtl = stringSlice(asmtTtl);

                    }
                    amstListStr += '      <img src="${pageContext.request.contextPath}/resources/img/classroom/asmtIcon.png" alt="user" width="40" height="40">';
                    amstListStr += '    </div>';
                    amstListStr += '    <div class="col-10 card-title mb-0 hover-text-container-asmt">';
                    amstListStr += '      <div>' + stringSlice(asmtTtl, 18) + '</div>';
                    amstListStr += '      <label class="hover-text-asmt card-subtitle mb-1 mt-2 ">' + asmtTtl + '</label>';
                    amstListStr += `    <!-- 날짜 -->`;
                    amstListStr += '      <div class="card-subtitle mb-2 text-muted fs-6">' +asmt.asmtDdln + '까지</div>';
                    amstListStr += '    </div>';
                    amstListStr += `</div>`;
                })
                document.querySelector("#asmtListContainer").innerHTML = amstListStr;
                feather.replace();
            },
            error: function(xhr, status, error) {
                // 요청이 실패했을 때 처리할 코드 작성
                alert("미안 실패야");
            }
        })
    }
    $(document).on("click", ".asmtSbmsn", function(e) {
        var sbjctCd = $(this).attr("data-sbjctCd");
		    var asmtNo = $(this).attr("data-asmtNo");
        location.href = "/tch/class/asmt/sbmsn?asmtNo=" + asmtNo + "&sbjctCd=" + sbjctCd;
    });

    function stringSlice(str, maxLength) {
        if (str.length > maxLength) {
            return str.substring(0, maxLength) + "...";
        }
        return str;
    }
</script>