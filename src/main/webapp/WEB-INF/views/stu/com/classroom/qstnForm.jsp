<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="card">
    <div class="card-body">
        <h3 class="fw-bold mb-4">질문답변</h3>

		<div class="mb-2">
			<input type="text" class="form-control font-weight-bold" maxlength="60" name="qstnTtl" id="qstnTtl" placeholder="제목">
		</div>
		<div id="editor"></div>
        <div class="text-end">
            <button type="button" class="btn btn-primary" id="enrollBtn">등록</button>
        </div>
    </div>
</div>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.css"/>
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script>
    var enrollBtn = document.querySelector("#enrollBtn");
    var qstFormcd = "${qstFormcd}";
	var sbjctCd = "${sbjctCd}";


	// 에디터 생성
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

	var qstnNo = "";
	if(qstFormcd == "update"){
		//console.log("qstn","${qstn.qstnTtl}");
		//console.log("qstn","${qstn.qstnCn}");
		//console.log("qstn","${qstn.qstnNo}");
        enrollBtn.innerText = "수정";
		document.querySelector("#qstnTtl").value = "${qstn.qstnTtl}";
		editor.setHTML("${qstn.qstnCn}");
		qstnNo = "${qstn.qstnNo}";
    }

    // 등록
    enrollBtn.addEventListener("click",function(){
		//console.log("editor", editor);
		let editorData = editor.getHTML();
		var csrfParameterName = '${_csrf.parameterName}';
		var csrfToken = '${_csrf.token}';
		var qstnTtl = document.querySelector("#qstnTtl").value;
        if(!qstnTtl){
            Swal.fire('제목을 입력해주세요!');
            formData = new FormData(); // 초기화
            return false;
        }
		console.log("과목코드 : ${sbjctCd}");
		console.log("editorData : ",editorData);
		console.log("qstnTtl : ",qstnTtl);
		if(qstFormcd == "insert"){
			$.ajax({
				url: '/stu/classroom/qstn?' + csrfParameterName + '=' + csrfToken,
				method: 'post',
				data: {
					"qstnCn":editorData,
					"sbjctCd":sbjctCd,
					"qstnTtl" : qstnTtl
				},
				dataType: 'json',
				success: function(response) {
					console.log(response);
					Swal.fire(
							'질문',
							'질문 등록이 완료되었습니다',
							'success'
			        ).then((result) => {
						location.href = "/stu/classroom/qstn?sbjctCd=" + sbjctCd;
			        })
				},
				error: function(xhr, status, error) {
				// 요청이 실패했을 때 처리할 코드 작성
				console.error('Request failed. Status:', status);
				}
			});
		} else {
			$.ajax({
				url: '/stu/classroom/qstn/update?' + csrfParameterName + '=' + csrfToken,
				method: 'post',
				data: {
					"qstnCn":	editorData,
					"qstnTtl" : qstnTtl,
					"qstnNo" : qstnNo
				},
				dataType: 'json',
				success: function(response) {
					console.log(response);
			        Swal.fire(
							'질문',
							'질문 수정이 완료되었습니다',
							'success'
			        ).then((result) => {
						location.href = "/stu/classroom/qstn/selectform?qstnNo=" + qstnNo + "&sbjctCd=" + sbjctCd;
			        })
				},
				error: function(xhr, status, error) {
				// 요청이 실패했을 때 처리할 코드 작성
				console.error('Request failed. Status:', status);
				}
			});

		}
	})
	$(document).keydown(function(event) {
		if (event.keyCode == '220') {
			console.log("백슬레쉬 누름");
			document.querySelector("#qstnTtl").value = "컬렉션(Collection)과 스트림(Stream)의 차이점";
			editor.setHTML("자바에서 컬렉션(Collection)과 스트림(Stream)의 차이점은 무엇인가요? ");
		}
	})
</script>