<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="card">
    <div class="card-body">
        <h3 class="fw-bold mb-4">질문답변</h3>
        <div class="card qstnListCard mb-3">
            <div class="card-body collapse show">
                <div class="row mb-3">
                    <div class="col-1 align-middle">
                        <img src="${profile}" class="avatar avatar-sm rounded-circle me-2" width="40" height="40">
                    </div>
                    <div class="col-8 fs-6 d-flex align-items-center">
                        ${qstn.stuNm}
                    </div>
                    <div class="col-3 position-relative">
                    	<div class="text-muted position-absolute top-50 end-0 translate-middle-y" style="padding-right: 15px;">
                        	${qstn.qstnDt}
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col fw-bold fs-3 mb-2">
                        ${qstn.qstnTtl}
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        ${qstn.qstnCn}
                    </div>
                </div>
            </div>
        </div>
        <div class="text-end mb-5">
            <button type="button" class="btn btn-primary" id="enrollBtn">수정</button>
            <button type="button" class="btn btn-danger" id="deleteBtn">삭제</button>
        </div>

        <div class="card border shadow-none">
            <c:set var="qstnAns" value="미답변"/>
            <c:set var="qstnAnsDt" value=""/>
            <c:if test="${qstn.qstnAns ne null && qstn.qstnAns ne ''}">
              <c:set var="qstnAns" value="${qstn.qstnAns}"/>
              <c:set var="qstnAnsDt" value="${qstn.qstnAnsDt}"/>
            </c:if>
            <div class="card-body">
                <div class="row mb-3">
                    <div class="col-1 align-middle">
                        <img src="${tch.userProfile}" class="avatar avatar-sm rounded-circle me-2" width="40" height="40">
                    </div>
                    <div class="col-8 fs-6 d-flex align-items-center"> 
                        ${tch.userNm} (강사) 
                    </div>
                    <div class="col-3 position-relative">
                    	  <div class="text-muted position-absolute top-50 end-0 translate-middle-y" style="padding-right: 15px;">
                            ${qstnAnsDt}
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        ${qstnAns}
                    </div>
                </div>
            </div>
        </div>

        <div id="editor"></div>

    </div>
</div>
<form action="/stu/classroom/qstn/updateform?${_csrf.parameterName}=${_csrf.token}" id="updateForm" method="post" enctype="multipart/form-data">
    <input type="hidden" name="qstnNo" value="${qstn.qstnNo}">
    <input type="hidden" name="sbjctCd" value="${qstn.sbjctCd}">
</form>
<script>
    var qstnNo = "${qstn.qstnNo}";
    var sbjctCd = "${qstn.sbjctCd}";
    var enrollBtn = document.querySelector("#enrollBtn");
    enrollBtn.addEventListener("click",function(){
        console.log("qstnNo : " + qstnNo);
        document.querySelector("#updateForm").submit();
    })
    var deleteBtn = document.querySelector("#deleteBtn");
    deleteBtn.addEventListener("click",function(){
        console.log("qstnNo : " + qstnNo);
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
                var data = {
                    "qstnNo" : qstnNo
                }
                $.ajax({
                    url: '/stu/classroom/qstn/delete',
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
                            location.href = "/stu/classroom/qstn?sbjctCd=" + sbjctCd;
                        })
                    },
                    error: function(xhr, status, error) {
                        // 요청이 실패했을 때 처리할 코드 작성
                        alert("미안 실패야");
                    }
                });
            }
		})

    })
</script>