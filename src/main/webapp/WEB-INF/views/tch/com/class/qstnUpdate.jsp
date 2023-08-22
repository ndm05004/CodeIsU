<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="card">
    <div class="card-body">
        <h3 class="fw-bold mb-4">질문답변</h3>
        <div class="cd mb-4">
            <div class="row mb-3">
                <div class="col-1 align-middle">
                    <img src="${qstn.stuProfile}" class="avatar avatar-sm rounded-circle me-2" width="40" height="40">
                </div>
                <div class="col-8">
                    <div class="fs-6">
                        ${qstn.stuNm}
                    </div>
                    <div class="text-muted" id="qstnAnsDt">
                        ${qstn.qstnAnsDt}
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    ${qstn.qstnTtl}
                </div>
            </div>
            <div class="row">
                <div class="col">
                    ${qstn.qstnCn}
                </div>
            </div>
        </div>

        <div class="card mb-3">
            <div class="card-body">
                <div class="row mb-3">
                    <div class="col-1 align-middle">
                        <img src="${qstn.empProfile}" class="avatar avatar-sm rounded-circle me-2" width="40" height="40">
                    </div>
                    <div class="col-10 ">
                        <div class="fs-6">
                          ${qstn.empNm}
                        </div>
                        <div class="text-muted" id="qstnAnsDt">
                          ${qstn.qstnAnsDt}
                        </div>
                    </div>
                    <div class="col-1 text-end">
                    </div>
                </div>

                <div class="row mb-3">
                    <div id="editor"></div>
                </div>
                <div class="text-end">
                    <button type="button" class="btn btn-primary" id="enrollBtn">등록</button>
                </div>
            </div>
        </div>

    </div>
</div>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.css"/>
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script>
    feather.replace();
    var qstnAns = "${qstn.qstnAns}";
    var qstnNo = "${qstn.qstnNo}";
    var btnStr = "";
    var sbjctCd = "${sbjctCd}"
    console.log("체킁" , btnStr);
    var enrollBtn = document.querySelector("#enrollBtn");
    // 에디터 추가 코드
    const Editor = toastui.Editor;
    const editor = new Editor({
        el: document.querySelector('#editor'),
        toolbarItems: [ // 사용할 기능 커스텀 - 파일업로드 삭제
        ['heading', 'bold', 'italic', 'strike'],
        ['hr', 'quote'],
        ['ul', 'ol', 'task', 'indent', 'outdent'],
        ['table', 'code', 'codeblock']
    ],
    height: '300px',
    initialEditType: 'wysiwyg',
    previewStyle: 'vertical'
    });
    editor.setHTML(qstnAns);

    // <button type="button" class="btn btn-danger" id="enrollBtn">삭제</button>
    enrollBtn.addEventListener("click",function(){
        btnStr = document.querySelector("#enrollBtn").innerText;
        var myqstnAns = editor.getHTML();
        if(myqstnAns == ""){
            Swal.fire(
            '질문답변',
            '답변이 작성되지 않았습니다',
            'success'
            ).then((result) => {
                return false;
            })
        }
        console.log("myqstnAns", myqstnAns);
        console.log("qstnNo", qstnNo);
        var data = {
            "qstnAns" : myqstnAns,
            "qstnNo" : qstnNo
        }
        $.ajax({
            url: '/tch/class/qstn/ansinsert',
            method: 'post',
            data: JSON.stringify(data),
            dataType: 'json',
            contentType:'application/json; charset=UTF-8',
            beforeSend: function(xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(res) {
                Swal.fire(
                   '질문답변',
                   '답변이 등록되었습니다',
                   'success'
                ).then((result) => {
	                location.href = "/tch/class/qstn/selectform?qstnNo=" + qstnNo + "&sbjctCd=" + sbjctCd;
                })
            },
            error: function(xhr, status, error) {
                // 요청이 실패했을 때 처리할 코드 작성
                alert("미안 실패야");
            }
        });
    });
</script>