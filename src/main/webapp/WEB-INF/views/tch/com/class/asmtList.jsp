<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
    .menu_title {
        margin: 3px 0 15px;
        padding: 0 0 0 13px;
        background: url(/resources/img/h4.png) no-repeat 0 4px;
        font-size: 22px;
        font-weight: 700;
        color: #000;
    }
    .asmtCardDtl{
        height:65px;
    }

    .asmtCardDtl .stuSbmsnCnt {
        cursor: pointer;
    }
    .scrollable-container {
        max-height: 75px; /* 원하는 최대 높이 설정 */
        overflow-y: auto; /* 세로 스크롤 생성 */
    }
</style>
<div class="">
    <h4 class="menu_title">${temp_title}</h4>
    <div class="row mb-2">
        <div class="col text-end">
          <button type="button" class="btn btn-primary" id="createBtn">만들기</button>
        </div>
    </div>
    <div id="asmtListContainer">

    </div>
    <form id="selectForm" action="/tch/class/asmt/asmtSelectForm" method="get">
        <input type="hidden" name="asmtNo" value="" id="asmtNo">
        <input type="hidden" name="sbjctCd" value="${sbjctCd}" id="sbjctCd">
    </form>
</div>
<script>
    var sbjctCd = document.querySelector("#sbjctCd").value;
    var createBtn = document.querySelector("#createBtn");
    createBtn.addEventListener("click",function(){
        location.href = "/tch/class/asmt/asmtform?sbjctCd=" + sbjctCd;
    })
    amstList();
    feather.replace();
    // 화면에 리스트 뿌리기
    function amstList(){
        $.ajax({
            url: "/tch/class/asmt/asmtList?sbjctCd=" + sbjctCd,
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
                    amstListStr += `<div class="card">`;
                    amstListStr += `    <div class="card-body">`;
                    amstListStr += `        <!--제목, 수정삭제버튼-->`;
                    amstListStr += `        <div class="row">`;
                    let asmtTtl = asmt.asmtTtl;
                    if(asmtTtl.length > 100){
                        asmtTtl = stringSlice(asmtTtl);

                    }
                    amstListStr += '                <div class="col-10 card-title">' + asmtTtl + '</div>';
                    amstListStr += `            <div class="col-2 text-end">`;
                    amstListStr += `                <button type="button" class="btn border-0 shadow-none" data-bs-toggle="dropdown" aria-expanded="false">`;
                    amstListStr += `                    <i data-feather="more-vertical" class="feather-icon"></i>`;
                    amstListStr += `                </button>`;
                    amstListStr += `                <!-- 수정, 삭제 드롭다운 버튼-->`;
                    amstListStr += `                <ul class="dropdown-menu dropdown-menu-end">`;
                    var asmtNo = asmt.asmtNo;
                    var sbjctCd = asmt.sbjctCd;
                    amstListStr += '                    <li><a class="dropdown-item" onclick="selectAsmt(' + asmt.asmtNo +')">보기</a></li>';
                    amstListStr += `                    <li><hr class="dropdown-divider"></li>`;
                    amstListStr += '                    <li><a class="dropdown-item" onclick="deleteAsmt(' + asmt.asmtNo + ')">삭제</a></li>';
                    amstListStr += `                </ul>`;
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
                    amstListStr += '            <div class="col-10 card-text scrollable-container">' + asmt.asmtExpln +'</div>';
                    amstListStr += '            <div class="col-2 text-end fs-2 align-middle stuSbmsnCnt" onclick="asmtSbmsnList(' + asmt.asmtNo + ')">' + asmt.stuSbmsnCnt + '/' + asmt.stuAllCnt + '<span class="fs-4 text-muted"> 제출</span></div>';
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


    // 삭제
    function deleteAsmt (asmtNo){
        console.log("asmtNo" + asmtNo);

        data = {
            asmtNo : asmtNo
        }

        Swal.fire({
            title: '과제 삭제',
            text: "정말로 삭제하시겠습니까?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '확인',
            cancelButtonText: '취소'
            }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '/tch/class/asmt/delete',
                    method: 'post',
                    data: JSON.stringify(data),
                    dataType: 'text',
                    contentType:'application/json; charset=UTF-8',
                    beforeSend: function(xhr) {
                            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                    },
                    success: function(res) {
                        console.log("결과",res);
                        Swal.fire(
                        '삭제완료',
                        '과제 삭제가 완료되었습니다',
                        'success'
                        ).then((result) => {
                          amstList();
                        })
                    },
                    error: function(xhr, status, error) {
                        // 요청이 실패했을 때 처리할 코드 작성
                        alert("미안 실패야");
                    }
                });
            }
		})
    }

    // 수정
    function selectAsmt (asmtNo ){
        console.log("update asmtNo :" + asmtNo);
        console.log("update sbjctCd :" + sbjctCd);
        document.querySelector("#asmtNo").value = asmtNo;
        document.querySelector("#selectForm").submit();
    }

    // 과제
    function asmtSbmsnList(asmtNo){
        console.log("체킁 : ",asmtNo);
        location.href = "/tch/class/asmt/sbmsn?asmtNo=" + asmtNo + "&sbjctCd=" + sbjctCd;
    }
</script>