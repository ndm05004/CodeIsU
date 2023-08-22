<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="card">
    <div class="card-body">
        <div class="cd mb-4">
            <div class="row mb-3">
                <div class="col-1 align-middle">
                    <img src="${qstn.stuProfile}" class="avatar avatar-sm rounded-circle me-2" width="40" height="40">
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
        
        <div class="card mb-3">
            <div class="card-body">
                <div class="row mb-3">
                    <div class="col-1 align-middle">
                        <img src="${qstn.empProfile}" class="avatar avatar-sm rounded-circle me-2" width="40" height="40">
                    </div>
                    <div class="col-8 fs-6 d-flex align-items-center">    
                        ${qstn.empNm} (강사) 
                    </div>
                    <div class="col-3 position-relative"> 
                        <div class="text-muted position-absolute top-50 end-0 translate-middle-y" style="padding-right: 15px;" id="qstnAnsDt">
                          ${qstn.qstnAnsDt}
                        </div>
                    </div>
                </div>
                
                <div class="row mb-3">
                    <div id="editor"></div>
                    <!--등록되어있으면-->
                    <div class="col-11 " id="qstnAns">
                        ${qstn.qstnAns}
                    </div>
                </div>
                <div class="text-end">
                    <c:set var="btnStr" value="등록"/>
                    <c:if test="${qstn.qstnAns ne null && qstn.qstnAns ne ''}">
                      <c:set var="btnStr" value="수정"/>
                    </c:if>
                    <button type="button" class="btn btn-primary" id="enrollBtn">${btnStr}</button>
                    <c:if test="${qstn.qstnAns ne null && qstn.qstnAns ne ''}">
                        <button type="button" class="btn btn-danger" id="deleteBtn">삭제</button>
                    </c:if>
                </div>
            </div>
        </div>

    </div>
</div>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.css"/>
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script>
    feather.replace();
    var sbjctCd = "${sbjctCd}"
    var qstnAns = $("#qstnAns").text().trim();
    var qstnNo = "${qstn.qstnNo}";
    var btnStr = "";
    console.log("체킁" , btnStr);
    var enrollBtn = document.querySelector("#enrollBtn");
    var editor = null;
    // 에디터 추가 코드
    function editorMake(){
      if (editor === null) {
        const Editor = toastui.Editor;
        editor = new Editor({
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
      }
    }
    // 답변 안달았으면 등록하도록
    if(qstnAns == ""){
      editorMake()
    } else{
      document.querySelector("#enrollBtn").innerText = "수정"
    }
      
    // <button type="button" class="btn btn-danger" id="enrollBtn">삭제</button>
    enrollBtn.addEventListener("click",function(){
      btnStr = document.querySelector("#enrollBtn").innerText;
      if(btnStr === "등록"){
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
                console.log("결과",res);
                location.href = "/tch/class/qstn/selectform?qstnNo=" + qstnNo + "&sbjctCd=" + sbjctCd;
            })
          },
          error: function(xhr, status, error) {
              // 요청이 실패했을 때 처리할 코드 작성
              alert("미안 실패야");
          }
        });
      } else {
        // 수정 버튼을 누르면 수정 폼으로 이동
        location.href = "/tch/class/qstn/updateform?qstnNo=" + qstnNo + "&sbjctCd=" + sbjctCd;
      }
    });

    // 질문 삭제
    $(document).on("click", "#deleteBtn", function(e) {
        var data = {
          "qstnNo" : qstnNo
        }
        $.ajax({
          url: '/tch/class/qstn/ansdelete',
          method: 'post',
          data: JSON.stringify(data),
          dataType: 'json',
          contentType:'application/json; charset=UTF-8',
          beforeSend: function(xhr) {
                  xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
          },
          success: function(res) {
              console.log("삭제 결과",res);
              Swal.fire(
              '질문답변',
              '답변이 삭제되었습니다',
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
    })

    $(document).keydown(function(event) {
        if (event.keyCode == '220') {
          var str = `
          <h4>컬렉션</h4>
          <p>
              컬렉션은 데이터를 모아놓은 그릇이라고 생각하면 돼요. 옷을 넣는 옷장처럼 데이터를 저장하고, 접근하여 처리할 수 있어요.
              추가, 수정, 삭제 등 데이터를 직접 다루기 쉽고, 작은 데이터를 다룰 때 유용합니다.
          </p>

          <h4>스트림</h4>
          <p>
              스트림은 데이터가 흐르는 파이프라인이라고 생각하면 돼요. 데이터를 한 줄씩 처리하는 방식이에요.
              데이터를 한 번에 읽어들이지 않고 필요할 때 처리하며, 데이터를 변환하거나 원하는 결과를 만들어내는 작업에 유용합니다.
              대량의 데이터를 효율적으로 처리할 때 사용됩니다.
          </p>
          `
          editor.setHTML(str);
        }
	  })
</script>