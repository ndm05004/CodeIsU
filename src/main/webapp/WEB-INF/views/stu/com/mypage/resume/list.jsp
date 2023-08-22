<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- VS코드 작업용입니다. 사용하고지워주세요 -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script> -->
<!-- <link rel="stylesheet" href="https://demos.adminmart.com/free/bootstrap/freedash-lite/src/dist/css/style.min.css" /> -->
<!-- /VS코드 작업용입니다. 사용하고지워주세요 -->
<style>
.stepcon1 {
    width: 100%;
    font-size: 16px;
    margin-bottom: 14px;
    color: #666;
    border: 1px solid #DFE0E5;
    padding: 10px;
    box-sizing: border-box;
}
.tit_square01, .content .tit_square01 {
margin: 3px 0 15px;
padding: 0 0 0 13px;
background: url(/resources/img/h4.png) no-repeat 0 4px;
font-size: 22px;
font-weight: 700;
color: #000;
}

.myperson_list {width:100%;  margin-bottom:15px; margin-left:0px; color:#666;}
.myperson_list tr.ptit {border:1px solid #c4dbea; font-size:13px; text-align:center; color:#666;}
.myperson_list th {margin-bottom:20px !important; padding: 20px 0px;  margin-left:0px; background-color:#f3f8fc; border:none; font-weight:500; color:#666; font-size:18px;}
.myperson_list span.tnew {color:#e74249; font-weight:500;}
.myperson_list span.tjnew {color:#e74249;}
.myperson_list span.tma {color:#fd901b; font-weight:500;}

.myperson_list tbody.form01 tr {border-bottom:1px solid #c2dae9;}
.myperson_list tbody.form01 td {color:#333; font-size:16px;}
.myperson_list tbody.form01 td.title {text-align:left;}
.myperson_list tbody.form01 td.title a.tit01 {overflow:hidden; font-size:14px;font-weight:500;}
.myperson_list tbody.form01 td a.tit02 {color:#84a7ca; font-size:14px; font-weight:500; text-decoration:underline;}
.myperson_list tbody.form01 td.title a.tit03 {overflow:hidden; display:inline-block; color:#3689FF; font-weight:500; font-size:18px; text-decoration:underline;}
.myperson_list tbody.form01 td.title .tit04{overflow:hidden; font-weight:500; font-size:14px;color:#000;}
.myperson_list tbody.form01 td.title a.tit05 {overflow:hidden; display:inline-block; color:#638db8; font-weight:500; font-size:14px; padding-top:3px;}
.myperson_list tbody.form01 td.title .tit06 {overflow:hidden; font-size:14px; color:#000;
    white-space: nowrap;
    display: inline-block;
    text-overflow: ellipsis;
    overflow: hidden;
    width: 550px;
}
.myperson_list tbody.form01 td.title .tit07 {overflow:hidden; font-size:14px; color:#777;}
.myperson_list tbody.form01 td a.tit08 {color:#f26522; font-size:14px; text-decoration:underline;}
.myperson_list tbody.form01 td a.tit09 {color:#666; font-weight:500; font-size:14px; text-decoration:underline;}
.myperson_list tbody.form01 td .lijungic {background:#5CA1E6; font-size:11px; color:#fff; padding:2px 4px;font-family: "Malgun Gothic","맑은 고딕",sans-serif;letter-spacing:-1px; font-weight:500;}
.myperson_list tbody.form01 span.redate {font-weight:bold; color:#f48d00;}

.myperson_list tbody.form01 td.matchnum {padding:10px 0px 10px 10px; text-align:left; font-size:15px;  font-weight:bold;}
.myperson_list tbody.form01 td.matchnum span {text-decoration:underline; color:#eb0000}



.myperson_list .tabtit {border-bottom:2px solid #3689FF; width:100%; padding:0px;}
.myperson_list .tabtit table {position:block; width:100%; padding:0px;}

.myperson_list .tabtit td.consec {border:2px solid #3689FF; background:#3689FF; text-align:center;color:#fff; font-size:15px; font-weight:500;}
.myperson_list .tabtit td.consec span{color:#ffff00; }
.myperson_list .tabtit td.con01 {border-left:1px solid #ccc; border-right:1px solid #ccc; border-top:1px solid #ccc; text-align:center; padding:0px;}
.myperson_list .tabtit td.con02 {border-top:0px; padding:0px;}
.blue4
{
    border: solid 1px #3076ab;
    background: #4e96cd;
    font:11px dotum, "돋움", gulim, "굴림", sans-serif;
	color: #fff;
    padding:5px 10px;
    padding:4px 8px 1px 8px;
    font-weight:bold;


}

.blue4:hover
{
    border: solid 1px #5a9ed2;
    background: #7bb7de;
    font:11px dotum, "돋움", gulim, "굴림", sans-serif;
		color: #fff;
    padding:5px 10px;
    padding:4px 8px 1px 8px;
    font-weight:bold;
}



</style>



<div class="row">
	<div class="col-12">
		<div class="card mb-2">
			<div class="card-body">
			    <h4 class="tit_square01">내 이력서 관리</h4>

				<div class="stepcon1">
					<ul class="mb-0">
						<li><b>·</b> 이력서를 작성하면 상담담당자가 확인이 가능합니다.</li>
						<li><b>·</b> 상담이 신청 및 진행 시, 이력서가 담당자 조회가 가능해집니다. </a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-12">
			<div class="card">
					<div class="card-body">
	<div class="myperson">
		<div class="row">
			<div class="col-6 d-flex flex-column justify-content-end">
				<div class="myperson_ttit">
					총 <font>${fn:length(resList)}</font>건
				</div>
			</div>
			<div class="col-6">
				<a href="/stu/mypage/resume/write">
					<div class="my-1" style="margin-top: -15px; float: right; color: white; font-weight: bold; font-size: 14px; border-radius: 5px; background-color: #4a62c4; box-shadow: 0 1px 2px 0px silver; width: 100px !important; height: 37px; text-align: center; line-height: 37px;">
						<i class="ion-plus-round"></i> 이력서등록
					</div>
				</a>
			</div>

		</div>

		<div class="d-flex align-items-end" style="width: 100%;"></div>


		<table class="myperson_list" id="ResumeTable">
			<colgroup>
				<col width="10%">
				<col width="*%">
				<col width="10%">
				<col width="25%">
			</colgroup>
			<thead>
				<tr class="ptit">
					<th scope="col">순번</th>
					<th scope="col">이력서</th>
					<th scope="col">수정일</th>
					<th scope="col">미리보기 / 수정 / 삭제</th>
				</tr>
			</thead>
			<tbody class="form01">
				<c:forEach items="${resList}" var="res" varStatus="stat">
				<tr>
					<td class="text-center">${stat.count}</td>
					<td class="title py-1">
						<ul class="my-0">
							<li style="line-height: 26px;" idx="${res.resumeNo}" id="resIdx">
								<c:if test='${res.mainResumeYn eq "Y"}'><a href="#" class="blue4">대표</a></c:if>
								<a href="javascript:goPreview('${res.resumeNo}')" class="tit03 1ResumeDetails align-middle">${res.resumeNm}</a>
							</li>
							<li><span class="tit06">${res.resumeIntroConn}</span></li>
						</ul>
					</td>
					<td class="text-center"><fmt:formatDate value="${res.regDt}" pattern="yyyy.MM.dd"/></td>
					<td class="text-center"><a href="javascript:goPreview('${res.resumeNo}')" class="white2" style="padding: 4px 8px 1px 8px; background-color: #f9f9f9; border: 1px solid #bbb; font-weight: bold; font-size: 14px;" >미리보기</a>
					<a href="javascript:void(0);" class="white2" style="padding: 4px 8px 1px 8px; background-color: #f9f9f9; border: 1px solid #bbb; font-weight: bold; font-size: 14px;" >수정</a>
					<a href="javascript:void(0);" class="white2" style="padding: 4px 8px 1px 8px; background-color: #f9f9f9; border: 1px solid #bbb; font-weight: bold; font-size: 14px;" >삭제</a>
					<a href="#" onclick="mainSet('${res.resumeNo}')" class="white2" style="padding: 4px 8px 1px 8px; background-color: #f9f9f9; border: 1px solid #bbb; font-weight: bold; font-size: 14px;" >대표설정</a></td>
				</tr>
				</c:forEach>
				<c:if test="${resList[0].resumeNo eq null}">
				<tr>
					<td colspan="4" class="text-center"> 아직 작성된 이력서가 없습니다. </td>
				</tr>
				</c:if>
			</tbody>
		</table>

		<div style="width: 100%;">
			<div style="text-end" font-family: "'Nanum Gothic', sans-serif; font-weight: bold; font-size: 14px; color: #292929; letter-spacing: -0.5px; margin-top: -3px;">
				이력서 <span style="color: #355abb;">대표</span> 설정을 누르면 대표이력서로 노출됩니다.

			</div>
			<div style="clear: both;"></div>
		</div>

		<div style="background: #e6f2fb; padding: 20px; margin: 15px 0px 30px 0px; border: 1px solid #c3d4e0; color: #666;">

			<span style="font-weight: 500; padding-bottom: 10px; display: block; font-size: 15px; color: #4480ae;">이력서는! </span> 이력서 작성은 취업할 때 매우 중요합니다. 이는 자신의 경력과 능력을 간결하고 효과적으로 전달하는 첫 인상을 남기기 때문입니다. 잘 구성된 이력서는 기업에 전문성과 열정을 어필하며, 뛰어난 자질을 강조하여 경쟁력을 높일 수 있습니다. 간결하고 명확한 정보, 적절한 포맷, 키워드 사용, 오탈자/문법 오류를 피하는 등의 요소를 고려하여 프로페셔널한 이미지를 전달하는 것이 필요합니다. 좋은 이력서를 작성하면 좋은 기회를 얻을 수 있으며, 자신을 어필하는데 큰 도움이 됩니다.
		</div>

	</div>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
function goPreview(resumeNo) { // 이력서 미리보기 팝업
    var popWidth = "970";
    var popHeight = "900";
    var posLeft = (screen.width) ? (screen.width - popWidth) / 2 : 0;
    var posTop = (screen.height) ? (screen.height - popHeight) / 2 : 0;
    var optionTxt = stringFormat("height={0},width={1},top={2},left={3}, toolbar=no, menubar=no, scrollbars=yes, resizable=no", popHeight, popWidth, posTop, posLeft);

    var url = "/resume/view?no=" + resumeNo;
    window.open(url, "이력서 미리보기", optionTxt);
}
function stringFormat(text) {
    if (arguments.length <= 1) return text;

    for (var i = 0; i <= arguments.length - 2; i++) {
        text = text.replace(new RegExp("\\{" + i + "\\}", "gi"), arguments[i + 1]);
    }

    return text;
}
</script>

<script>// 대표이력서 설정
function mainSet(resNo){
	console.log('resNo', resNo);


    // 클릭된 버튼의 부모 노드 (td)를 찾음

	// 	var resIdxNode = document.querySelector(`li[idx="\${resNo}"]`);

	// 	var representativeElement = document.querySelector('a.blue4');


	// 	resIdxNode.insertBefore(representativeElement, resIdxNode.firstChild);


	const swalWithBootstrapButtons = Swal.mixin({
		customClass: {
		    confirmButton: 'btn btn-success',
		    cancelButton: 'btn btn-danger'
		  },
		  buttonsStyling: false
		})

		swalWithBootstrapButtons.fire({
		  title: '대표이력서로 설정하시겠습니까?',
		  text: "대표이력서로 설정되면 상담담당자에게 노출됩니다.",
		  icon: 'question',
		  showCancelButton: true,
		  confirmButtonText: '대표이력서 설정',
		  cancelButtonText: '취소',
		  reverseButtons: false
		}).then((result) => {
		  if (result.isConfirmed) {
				console.log("전송완료", resNo);
				var data = { resumeNo : resNo};
				$.ajax({
					type : "POST",
					contentType: 'application/json;charset=utf-8',
					url : "/stu/mypage/resume/ajax/mainresset?${_csrf.parameterName}=${_csrf.token}",
					data : JSON.stringify(data),
					dataType : 'text',
					error : function() {
						console.log('통신실패!!');
					},
					success : function(res) {
						console.log(res);
						swalWithBootstrapButtons.fire(
							'설정완료',
							'대표이력서 설정 성공.',
							'success'
						).then((result) => {
							var resIdxNode = document.querySelector(`li[idx="\${resNo}"]`);
							var representativeElement = document.querySelector('a.blue4');
							resIdxNode.insertBefore(representativeElement, resIdxNode.firstChild);
						})
					}
				});

			}

		})


}

</script>


<script> // 글 작성 성공 실패시
<c:if test="${writeResult eq 'OK'}">writeSuccess()</c:if>
<c:if test="${writeResult eq 'FAILED'}">writeFailed()</c:if>


function writeSuccess() {
	Swal.fire(
					'이력서작성 등록 성공 !',
					'success'
					)
}

function writeFailed() {
	Swal.fire(
					'이력서작성 등록 실패 !',
					'error'
					)
}

</script>