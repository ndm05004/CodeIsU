<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div class="">
    <div id="alert"></div>
    <div class="row">
        <div class="col-2">
            <div class="table-responsive">
                <table class="table table-hover border" id="myTable">
                    <thead>
                        <tr>
                            <th scope="col">이름</th>
                            <th scope="col">점수</th>
                        </tr>
                    </thead>
                    <tbody id="tbody">
                        <c:set value = "0" var = "num"/>
                        <c:forEach items="${sbmsnUserList}" var="userSbmsn">
                            <c:if test = "${userSbmsn.stuNo ne null && userSbmsn.stuNo ne ''}">
                                <c:if test="${num eq 0}">
                                    <tr class="sbmsnUserTr bg-primary" data-stuNo = "${userSbmsn.stuNo}">
                                        <th class="p-2 text-white">${userSbmsn.userNm}</th>
                                        <td class="text-end p-2 text-white"><fmt:formatNumber value="${100/(userSbmsn.qstCnt)*(userSbmsn.scoreCnt)}" type="number" pattern="0" /> 점</td>
                                    </tr>
                                </c:if>
                                <c:if test="${num ne 0}">
                                    <tr class="sbmsnUserTr" data-stuNo = "${userSbmsn.stuNo}">
                                        <th class="p-2">${userSbmsn.userNm}</th>
                                        <td class="text-end p-2"><fmt:formatNumber value="${100/(userSbmsn.qstCnt)*(userSbmsn.scoreCnt)}" type="number" pattern="0" /> 점</td>
                                    </tr>
                                </c:if>
                            </c:if>
                            <c:set value = "${num + 1}" var = "num"/>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="col-10" id="sbmsnResultContainer">

        </div>
    </div>
</div>
<script>
var asmtNo = "${asmtNo}";
var userSbmsn = document.querySelector("#sbmsnResultContainer");
if(!document.querySelector(".sbmsnUserTr")){
    document.querySelector("#myTable").remove();
    document.querySelector("#alert").innerText = "해당 과제를 제출한 학생이 존재하지 않습니다!"
} else{
    start();
}
function start(){
    userSbmsn.innerHTML = "";
    var tbody = document.querySelector("tbody");
    var myTr = tbody.querySelectorAll("tr");
    var firstRow = myTr[0];
    // 맨 처음 화면에 요소 뿌리기
    var mystuNo = firstRow.getAttribute("data-stuNo");
    var myscore = firstRow.querySelector("td").innerText;
    console.log("mystuNo",mystuNo);
    console.log("myscore",myscore);
    var mydata = {
        "stuNo" : mystuNo,
        "asmtNo" : asmtNo
    }
    ajaxFn(mydata, myscore)
}
$(document).on("click", ".sbmsnUserTr", function() {
    // 모든 tr 요소들의 배경색과 텍스트 색상을 초기화
    $(".sbmsnUserTr").removeClass("bg-primary text-white");
    $(".sbmsnUserTr td").removeClass("text-white");
    $(".sbmsnUserTr th").removeClass("text-white");
    // 선택한 tr 요소의 배경색을 primary로 변경하고, 텍스트 색상을 white로 변경
    $(this).addClass("bg-primary");
    $(this).find("td").addClass("text-white");
    $(this).find("th").addClass("text-white");

    userSbmsn.innerHTML = "";
    var stuNo = this.getAttribute("data-stuNo");
    var score = this.querySelector("td").innerText;
    console.log("asmtNo", asmtNo)
    data = {
        "stuNo" : stuNo,
        "asmtNo" : asmtNo
    }
    ajaxFn(data, score)
})
function ajaxFn(data, score){
    $.ajax({
        url: '/tch/class/asmt/sbmsn',
        method: 'post',
        data: JSON.stringify(data),
        dataType: 'json',
        contentType:'application/json; charset=UTF-8',
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(res) {
            console.log(res)
            var sbmsnList = res.sbmsnList;
            var asmtVO = res.asmtVO;
            var atchFileList = res.atchFileList;

            var asmtResultStr = "";
            asmtResultStr += `<div class="container">                                                                                                                                   `;
            // 마감일자, 제출일자
            asmtResultStr += `	<div class="row mb-3">                                                                                                                                     `;
            var qstSbmsnDt = "";
            sbmsnList.forEach(function(sbmsn) {
                qstSbmsnDt = sbmsn.qstSbmsnDt + "제출";
            });
            asmtResultStr += `        <div class="col-10 text-muted">                                                                                                                   `;
            asmtResultStr +=              qstSbmsnDt;
            asmtResultStr += `        </div>                                                                                                                                            `;
            asmtResultStr += `        <div class="col-2 text-danger text-end" id="scoreDiv">                                                                                            `;
            // 점수
            asmtResultStr +=                score
            asmtResultStr += `        </div>                                                                                                                                            `;
            asmtResultStr += `	</div>                                                                                                                                                `;
            asmtResultStr += `	<div class="mb-5">                                                                                                                                                 `;
            // 제목, 설명
            asmtResultStr += '		<h2>' + asmtVO.asmtTtl + '</h2>';
            asmtResultStr += '		<p>' + asmtVO.asmtExpln + '</p>';
            asmtResultStr += `	</div>                                                                                                                                                `;
            // 문제
            asmtResultStr += '		<input type="hidden" name="sbjctCd" value="' + asmtVO.sbjctCd + '">';
            asmtResultStr += `		<div id="asmtContainer">                                                                                                                          `;
            var qstCnt = asmtVO.qstList.length;
            var scoreCnt = 0;
            for(let i=0; i<asmtVO.qstList.length; i++){
                var qst = asmtVO.qstList[i];
                asmtResultStr +=	`				<div class="card qstCard border-dark mb-3">                                                                                               `;
                asmtResultStr +=	`					                                                                                                                                      `;
                asmtResultStr +=	`					<div class="card-body">                                                                                                               `;
                asmtResultStr += `						<div class="qst">                                                                                                                 `;
                asmtResultStr +=	`							<div class="row mb-3 qstTitle">                                                                                               `;
                asmtResultStr +=	'								<div class="col-10">'+ qst.qstCn +'</div>';
                sbmsnList.forEach(function(sbmsn) {
                    if(sbmsn.qstNo == qst.qstNo){
                        if(sbmsn.qstSbmsnAns == qst.qstAns){
                            // 정답을 맞추면
                            asmtResultStr +=	'					<div class="col-2 text-end text-primary">O</div>';
                        } else{
                            // 정답이 틀리면
                            asmtResultStr +=	'					<div class="col-2 text-end text-danger">X</div>';
                        }
                    }
                });
                asmtResultStr +=	`							</div>                                                                                                                        `;
                asmtResultStr +=	`                                                                                                                                                          `;
                asmtResultStr +=	`							<div class="asmttitleimg mb-3">                                                                                               `;
                atchFileList.forEach(function(atchFile) {
                    if(qst.atchFileNo == atchFile.atchFileNo){
                        asmtResultStr +=	'						    <img alt="" src="' + atchFile.filePath +'" style = "width:100%; height: auto;">';
                    }
                });
                asmtResultStr += `							</div>                                                                                                                        `;
                var num = 1;
                for(let j=0; j<sbmsnList.length; j++){
                    var sbmsn = sbmsnList[j];
                    // 해당 문제의 정답비교
                    if(sbmsn.qstNo == qst.qstNo){
                        console.log("i", i)
                        // 객관식
                        if(qst.qstCode == 'M'){
                            asmtResultStr += `							<div class="asmtcardDtl">                                                                                                     `;
                            var qstDtlList = qst.qstDtlList;
                            qstDtlList.forEach(function(qstDtl) {
                                // 정답이랑 다르면 정답을 빨강 //qstDtl.qstDtlNo
                                if(sbmsn.qstSbmsnAns != qst.qstAns && qst.qstAns == num){
                                    asmtResultStr += `                                        <div class="mb-2 text-danger fw-bold">                                                                        `;
                                    asmtResultStr += '                                              정답 : '+ qstDtl.qstDtlCn;
                                    asmtResultStr += `                                        </div>                                                                                                    `;
                                }
                                // 정답이랑 다르면 내가 쓴 답은 검정
                                if(sbmsn.qstSbmsnAns != qst.qstAns && sbmsn.qstSbmsnAns == num){
                                    asmtResultStr += `                                        <div class="mb-2 text-dark fw-bold">                                                                        `;
                                    asmtResultStr +=                                                qstDtl.qstDtlCn;
                                    asmtResultStr += `                                        </div>                                                                                                    `;
                                }
                                // 정답이랑 같으면 정답을 파랑
                                if(sbmsn.qstSbmsnAns == qstDtl.qstDtlNo && qst.qstAns == num){
                                    scoreCnt++;
                                    asmtResultStr += `                                        <div class="mb-2 text-primary fw-bold">                                                                        `;
                                    asmtResultStr +=                                                qstDtl.qstDtlCn;
                                    asmtResultStr += `                                        </div>                                                                                                    `;
                                }
                                // 내가 쓴것도 아니고 정답도 아닌것들은 회색
                                if(sbmsn.qstSbmsnAns != num && qst.qstAns != num){
                                    asmtResultStr += `                                        <div class="mb-2 text-muted">                                                                        `;
                                    asmtResultStr +=                                                qstDtl.qstDtlCn;
                                    asmtResultStr += `                                        </div>                                                                                                    `;
                                }
                                num++;
                            });
                            asmtResultStr += `							</div>                                                                                                                        `;
                        } else {
                            var qstSbmsnAns = sbmsn.qstSbmsnAns;
                            if(qstSbmsnAns == null){
                                qstSbmsnAns = "";
                            }
                            // 주관식
                            asmtResultStr += `                                            <div class="row align-items-center">                                                                          `;
                            asmtResultStr += `                                                <div class="col-1 fw-bold">작성</div>                                                                                `;
                            // 내가 쓴 답이라면
                            if(sbmsn.qstSbmsnAns == qst.qstAns){
                                scoreCnt++;
                                asmtResultStr += `                                                    <div class="col-9 text-primary fw-bold">                                                                      `;
                                asmtResultStr +=                                                         qstSbmsnAns;
                                asmtResultStr += `                                                    </div>                                                                                                `;
                            } else{
                                // 정답이 아니라면
                                asmtResultStr += `                                                    <div class="col-9 text-dark fw-bold">`;
                                asmtResultStr +=                                                         qstSbmsnAns;
                                asmtResultStr += `                                                    </div>                                                                                                `;
                            }
                            asmtResultStr += `                                                <div class="col-2"></div>                                                                                 `;
                            asmtResultStr += `                                            </div>                                                                                                        `;
                            asmtResultStr += `                                            <div class="row">                                                                                      `;
                            // 정답이 아니라면
                            //console.log("정답 체킁", qst.qstAns)
                            if(sbmsn.qstSbmsnAns != qst.qstAns || sbmsn.qstSbmsnAns == null || sbmsn.qstSbmsnAns== ''){
                                asmtResultStr += `                                                    <div class="col-1 text-danger fw-bold">정답</div>                                                                         `;
                                asmtResultStr += `                                                    <div class="col-9 text-danger fw-bold">                                                                         `;
                                asmtResultStr +=                                                         qst.qstAns
                                asmtResultStr += `                                                    </div>                                                                                                `;
                            } 
                            asmtResultStr += `                                            </div>                                                                                       `;
                        }
                    }
                }

                asmtResultStr += `						</div>                                                                                                                            `;
                asmtResultStr += `					</div>                                                                                                                                `;
                asmtResultStr += `				</div>                                                                                                                                    `;
            }
            asmtResultStr += `		</div>                                                                                                                                            `;
            asmtResultStr += `</div>                                                                                                                                                    `;
            userSbmsn.innerHTML = asmtResultStr;
        },
        error: function(xhr, status, error) {
            // 요청이 실패했을 때 처리할 코드 작성
            alert("제발");
        }
    });
}
</script>