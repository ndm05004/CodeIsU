<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    .menu_title {
      margin: 3px 0 30px;
      padding: 0 0 0 13px;
      background: url(/resources/img/h4.png) no-repeat 0 4px;
      font-size: 22px;
      font-weight: 700;
      color: #000;
    }
    .scrollable-container {
        max-height: 75px; /* 원하는 최대 높이 설정 */
        overflow-y: auto; /* 세로 스크롤 생성 */
    }
</style>
<form action="/stu/classroom/assign/sbmsn/result" method="get" id="sbmsnResultForm">
	<input type="hidden" name="asmtNo" value="" id="asmtNo">
    <input type="hidden" name="sbjctCd" value="${sbjctCd}" id="sbjctCd">
</form>
<div class="">
	<h4 class="menu_title">${temp_title}</h4>
    <div id="asmtListContainer" class="">

    </div>
</div>
<script>
      // 오늘 날짜
    var currentDate = new Date(); // 현재 날짜와 시간 가져오기
    var year = currentDate.getFullYear(); //년
    var month = currentDate.getMonth() + 1; // 월
    var date = currentDate.getDate(); // 일
    var hours = currentDate.getHours(); // 시
    var minutes = currentDate.getMinutes(); // 분

    // 한 자리 수인 경우 앞에 0을 붙여 두 자리로 만들기
    var formattedMonth = month < 10 ? "0" + month : month;
    var formattedDate = date < 10 ? "0" + date : date;
    var formattedHours = hours < 10 ? "0" + hours : hours;
    var formattedMinutes = minutes < 10 ? "0" + minutes : minutes;
    var currDt = year + "-" + formattedMonth + "-" + formattedDate + " " + formattedHours + ":" + formattedMinutes;

    var sbjctCd = document.querySelector("#sbjctCd").value;
    amstList();
    feather.replace();
    // 화면에 리스트 뿌리기
    function amstList(){
        $.ajax({
            url: "/stu/classroom/assign/asmtList?sbjctCd=" + sbjctCd,
            method: 'get',
            dataType: 'json',
            beforeSend: function(xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(res) {
                console.log("amstList",res);
                let amstListStr = "";
                for(let i=0; i<res.length; i++) {
                    let asmt = res[i];
                    console.log("asmt",asmt);
                    // 제출완료여부
                    var submitYn;
                    var textColor;
                    if(asmt.qstSbmsnYn == "Y"){
                      textColor = "text-primary";
                      submitYn = "제출완료";
                      amstListStr += '<div class="card" onclick="resultSbmsn('+ asmt.asmtNo +')">';
                    } else if(asmt.asmtDdln <currDt) {
                      textColor = "text-muted";
                      submitYn = "기간만료"
                      amstListStr += '<div class="card">';
                    } else {
                      textColor = "text-danger";
                      submitYn = "미제출"
                      amstListStr += '<div class="card" onclick="sbmsn('+ asmt.asmtNo +')">';
                    }
                    amstListStr += `    <div class="card-body">`;
                    amstListStr += `        <!--제목, 수정삭제버튼-->`;
                    amstListStr += `        <div class="row">`;
                    let asmtTtl = asmt.asmtTtl;
                    if(asmtTtl.length > 100){
                        asmtTtl = stringSlice(asmtTtl);

                    }
                    amstListStr += '            <div class="col-10 card-title">' + asmtTtl + '</div>';
                    amstListStr += '            <div class="col-2 text-end '+ textColor + '">';
                    amstListStr +=                  submitYn;
                    amstListStr += `            </div>`;
                    amstListStr += `        </div>`;
                    amstListStr += `        <!-- 날짜 -->`;
                    amstListStr += `        <div class="row">`;
                    amstListStr += '            <div class="card-subtitle mb-2 text-muted">' + asmt.asmtDt + '작성  ·  ' + asmt.asmtDdln + '까지</div>';
                    amstListStr += `        </div>`;
                    amstListStr += `        <!-- 내용, 제출인원 -->`;
                    amstListStr += `        <div class="row asmtCardDtl ">`;
                    let asmtExpln = asmt.asmtExpln;
                    if(asmtExpln.length > 221){
                        asmtExpln = stringSlice(asmtExpln);
                    }
                    amstListStr += '            <div class="col-10 card-text scrollable-container">' + asmtExpln +'</div>';
                    amstListStr += '            <div class="col-2 text-end fs-2 align-middle">' + asmt.stuSbmsnCnt + '/' + asmt.stuAllCnt + '제출</div>';
                    amstListStr += `        </div>`;
                    amstListStr += `    </div>`;
                    amstListStr += `</div>`;
                }
                document.querySelector("#asmtListContainer").innerHTML = amstListStr;
                feather.replace();
            },
            error: function(xhr, status, error) {
                // 요청이 실패했을 때 처리할 코드 작성
                alert("미안 실패야");
            }
        })
    }

    function stringSlice(str, maxLength) {
        if (str.length > maxLength) {
            return str.substring(0, maxLength) + "...";
        }
        return str;
    }

    function sbmsn(asmtNo){
        //console.log("asmtNo " , asmtNo);
        location.href = "/stu/classroom/assign/sbmsn?asmtNo=" + asmtNo + "&sbjctCd=" + sbjctCd;
    }

    function resultSbmsn(asmtNo){
        //console.log("asmtNo " , asmtNo);
        document.querySelector("#asmtNo").value = asmtNo;
        document.querySelector("#sbmsnResultForm").submit();

    }

</script>