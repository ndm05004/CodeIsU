<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link type="text/css" rel="stylesheet" href="/resources/jsgrid/jsgrid.min.css" />
<link type="text/css" rel="stylesheet" href="/resources/jsgrid/jsgrid-theme.min.css" />

<style>
#resultGrid{
	height: 600px !important;
}
.jsgrid-grid-body{
	height: 460px !important;
}

</style>

<script type="text/javascript" src="/resources/jsgrid/jsgrid.min.js"></script>



	<div class="row">
		<div class="col-12">
			<div class="card mb-2">
				<div class="card-body py-2">
					<div class="input-group flex-nowrap justify-content-end">
						<button type="button" class="btn waves-effect waves-light btn-primary">원생 일괄등록</button>
						<button type="button" class="btn waves-effect waves-light btn-outline-primary" onclick="location.href='/common/bbs/%EC%9B%90%EC%83%9D%20%EC%9D%BC%EA%B4%84%EB%93%B1%EB%A1%9D%20%EC%96%91%EC%8B%9D.xlsx'">엑셀양식 다운</button>
						<div class="custom-file w-25">
							<form id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data"method="post" action= "/emp/stuman/stulist/excelupload?${_csrf.parameterName}=${_csrf.token}">
								<input class="form-control" type="file" id="excelFile" name="excelFile">
							</form>
						</div>
						<button class="btn btn-outline-dark" type="button" onclick="excelUpload()">
							전송
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

<div class="row">
	<div class="col-12">
		<div class="card">
			<div class="card-body">
				<div class="d-flex justify-content-end">
					<!-- <button id="btnFilter" class="btn waves-effect waves-light btn-outline-primary mb-1" type="button"
						onclick="filterClick()">검색</button> -->
					<button id="btnAdd" class="btn waves-effect waves-light btn-primary mb-1" type="button"
						onclick="AddClick()">원생 개별등록</button>
				</div>
				<div id="jsGrid"></div>

			</div>
		</div>
	</div>
</div>


					<!--  엑셀 업로드 결과 모달 -->
					<div class="modal fade" id="resultModal" tabindex="-1" role="dialog"
							aria-labelledby="myLargeModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-xl">
									<div class="modal-content">
											<div class="modal-header">
													<h4 class="modal-title" id="myLargeModalLabel">원생등록 엑셀일괄 등록 결과</h4>
													<button type="button" class="btn-close" data-bs-dismiss="modal"
															aria-hidden="true"></button>
											</div>
											<div class="modal-body">
													<div class="container-fluid">
														<div class="text-center mb-2" id="result-text"></div>
													</div>
													<div class="row">
														<div class="col-12">
														<div id="resultGrid" style="height: 550px !important;"></div>
													  </div>
													</div>
													
													<br>
											</div>
									</div><!-- /.modal-content -->
							</div><!-- /.modal-dialog -->
					</div><!-- /.엑셀 업로드 결과 모달 -->



<script> // 엑셀 POI 업로드

const resultModal = new bootstrap.Modal('#resultModal', {})

function excelUpload() {


	const swalWithBootstrapButtons = Swal.mixin({
		customClass: {
		    confirmButton: 'btn btn-success',
		    cancelButton: 'btn btn-danger'
		  },
		  buttonsStyling: false
		})

		swalWithBootstrapButtons.fire({
		  title: '원생일괄등록 하시겠습니까?',
		  text: "등록 실패시 결과가 출력됩니다.",
		  icon: 'question',
		  showCancelButton: true,
		  confirmButtonText: '원생 일괄등록',
		  cancelButtonText: '취소',
		  reverseButtons: false
		}).then((result) => {
		  if (result.isConfirmed) {
				var options = {
          success : function(result) {
                if(result.state=="OK") {
										Swal.fire({
											title: '원생등록 성공!',
											icon: 'success',
											html: `\${result.successCnt} 건 등록 성공! (실패: \${result.failedCnt} 건)`,
											confirmButtonText: '확인',
										});
										console.log("엑셀업로드 성공! 결과값", result.stuList);
										renderResult(result.stuList);
										$('#result-text').html(`<h3><b>\${result.successCnt} 건 등록 완료</b> (실패:\${result.failedCnt} 건)</h3>`);
										resultModal.show();
										getAjaxList();
                } else {
                    console.log("엑셀 업로드 실패");
										Swal.fire(
													'원생등록 실패, 엑셀파일을 확인해주세요!',
													'error'
													)
                }
            },
            error : function(request, status, error) {
                console.log("error");
                alert("code : " + request.status + "\n" + "message : " + request.responseText + "\n" + "error : " + error);
            },
            type : "POST"
        };
        $("#excelUploadForm").ajaxSubmit(options);
			}
		    
		})
}

</script>

<script>

var data = {};

getAjaxList();

function getAjaxList() {

$.ajax({
	url: "/emp/stuman/stulist/getlist?${_csrf.parameterName}=${_csrf.token}",
	method: "POST",
	dataType: "json",
	success: function(result){
		data = result;
		console.log(result);
		renderGrid();
	},
	error: function() {
		alert("ajax 리스트 불러오기 에러");
	}
})

}


function renderGrid() {

	var typeGender = [
		{	name: "남", value: "M"},
		{	name: "여", value: "F"}
	]

    $("#jsGrid").jsGrid({

    	locale:"ko",
        width: "100%",
        height: "570px",

		// filtering: true, 

        inserting: true,
        editing: true,
        sorting: true,
        paging: true,
				pageSize: 20,


        data: data.stuList,
        controller: {
        	insertItem: function(item) {
        		$.ajax({
							url: "/emp/stuman/stulist/insertstuone?${_csrf.parameterName}=${_csrf.token}",
							contentType: 'application/json; charset=utf-8',
							method: "POST",
							dataType: "json",
							data: JSON.stringify(item),
							success: function(result){
								console.log(result);
								if(result.resultDB == "OK") {
									Swal.fire({
											title: '원생등록 성공!',
											icon: 'success',
											html: `[\${result.userName}] 원생<br> 원생번호 <b>\${result.userID}</b>로 등록되었습니다.`,
											confirmButtonText: '확인'
										});
									AddClick();
									getAjaxList();
								} else {

									Swal.fire(
													'원생등록 실패!',
													'error'
													)
									getAjaxList();
								}

							},
							error: function() {
								alert("원생 등록 실패");
								getAjaxList();
							}
							})
        	}
        },


        fields: [
            { name: "svlfNo", title: "연수과정", type: "select", items: data.svlfList, valueField: "svlfNo", textField: "svlfNm", width: 100, validate: "required" },
            { name: "stuNo", title: "원생번호", type: "text", width: 70, align: "center" , insertTemplate : function() {
var $result = jsGrid.fields.text.prototype.insertTemplate.apply(this, arguments);
$result.attr("placeholder", "미입력시 자동생성");
return $result;
} },
            { name: "userNm", title: "이름", type: "text", width: 40 , align: "center" , validate: "required" },
            { name: "userGender", title: "성별", type: "select", items: typeGender, valueField: "value", textField: "name", width: 30},
            { name: "userBrdt", title: "생년월일",type: "text", width: 40 , align: "center", validate: "required" },
            { name: "userPhoneno", title: "연락처",type: "text" , width: 50 , align: "center", validate: "required" },
            { type: "control", width: 30}


        ]
    });



}

function renderResult(resData) {

var typeGender = [
	{	name: "남", value: "M"},
	{	name: "여", value: "F"}
]
var typeSuccess = [
	{	name: `<button type="button" class="btn btn-success btn-rounded"><i
        class="fas fa-check"></i> 등록성공</button>`, value: "Y"},
	{	name: `<button type="button" class="btn btn-warning btn-rounded"><i
    class="far fa-heart"></i> 등록실패</button>`, value: "N"}
]

	$("#resultGrid").jsGrid({

		locale:"ko",
			width: "100%",
			height: "480px",
			pageSize: 20,

			inserting: false,
			editing: false,
			sorting: true,
			paging: true,


			data: resData,
			fields: [
					{ name: "svlfNo", title: "연수과정", type: "select", items: data.svlfList, valueField: "svlfNo", textField: "svlfNm", width: 80, validate: "required" },
					{ name: "stuNo", title: "원생번호", type: "text", width: 50, align: "center" },
					{ name: "userNm", title: "이름", type: "text", width: 40 , align: "center" , validate: "required" },
					{ name: "userGender", title: "성별", type: "select", items: typeGender, valueField: "value", textField: "name", width: 30},
					{ name: "userBrdt", title: "생년월일",type: "text", width: 40 , align: "center", validate: "required" },
					{ name: "userPhoneno", title: "연락처",type: "text" , width: 50 , align: "center", validate: "required" },
					{ name: "insertSuccess", title: "등록성공여부", type: "select", items: typeSuccess, valueField: "value", textField: "name", width: 60, align: "center"}


			]
	});



}


function filterClick() { //필터버튼
	  if ($('.jsgrid-filter-row').css('display') == "none") {

	    $('.jsgrid-filter-row').css({ display: 'table-row' });
	    $('#btnFilter').text('검색 닫기');
	    return false;
	  }

	  if ($('.jsgrid-filter-row').css('display') == "table-row") {
	    //Add 버튼 숨기기, Hide Add Button
	    $('.jsgrid-filter-row').css({ display: 'none' });
	    $('#btnFilter').text('검색');
	    return false;
	  }
	}
function AddClick() {
	  if ($('.jsgrid-insert-row').css('display') == "none") {
	    //Add 버튼 보이기, Show Add Button
	    $('.jsgrid-insert-row').css({ display: 'table-row' });
	    $('#btnAdd').text('등록닫기');
	    return false;
	  }

	  if ($('.jsgrid-insert-row').css('display') == "table-row") {
	    //Add 버튼 숨기기, Hide Add Button
	    $('.jsgrid-insert-row').css({ display: 'none' });
	    $('#btnAdd').text('원생 개별등록');
	    return false;
	  }
	}
</script>
<script> // 자동완성

// // 해당 클래스 이름(jsgrid-cell jsgrid-align-center)을 가진 요소들을 가져옵니다.
// const inputElements = document.getElementsByClassName('jsgrid-cell jsgrid-align-center')[2].querySelectorAll('input[type="text"]');

// // inputElements는 NodeList이므로, 필요한 경우 배열로 변환해줄 수 있습니다.
// const inputElement = inputElements[0]; // 첫 번째 <input type="text"> 요소를 변수로 할당합니다.



const autoComplete = () => {
    $(document).keydown(function (event) {
      if (event.keyCode == "220") {
        storageAutoComplete();
      }
    });
  };

  const storageAutoComplete = () => {
		const inputElements = document.getElementsByClassName('jsgrid-cell jsgrid-align-center')[2];
		console.log(inputElements);

		const input = inputElements.querySelectorAll('input[type="text"]')[0]
		console.log(input);

		console.log(input.value);
		console.log('키누름');
  };
  autoComplete();



</script>

