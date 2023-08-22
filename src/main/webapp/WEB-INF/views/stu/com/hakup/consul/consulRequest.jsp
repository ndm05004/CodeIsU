<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

    .deleteBtn {
        cursor: pointer;
    }

    /* 스크롤 */
    .table-container{
      width: 100%;
    }
    .scrolltable{
      display: block;
    }
    .scrolltable thead{
      padding-right: 25px
    }

    .scrolltable tbody{
        display: block;
        max-height: 150px;
        overflow-y: auto;
    }

    #noTable th:nth-of-type(1), #noTable td:nth-of-type(1) { width: 100px; }
    #noTable th:nth-of-type(2), #noTable td:nth-of-type(2) { width: 570px; }
    #noTable th:nth-of-type(3), #noTable td:nth-of-type(3) { width: 150px; text-align: center;}
    #noTable th:nth-of-type(4), #noTable td:nth-of-type(4) { width: 80px; }
    #noTable th:nth-of-type(5), #noTable td:nth-of-type(5) { width: 80px; }
    #noTable th:nth-of-type(6), #noTable td:nth-of-type(6) { width: 80px; }

    #approvTable th:nth-of-type(1), #approvTable td:nth-of-type(1) { width: 100px; }
    #approvTable th:nth-of-type(2), #approvTable td:nth-of-type(2) { width: 470px; }
    #approvTable th:nth-of-type(3), #approvTable td:nth-of-type(3) { width: 220px; text-align: center;}
    #approvTable th:nth-of-type(4), #approvTable td:nth-of-type(4) { width: 80px; }
    #approvTable th:nth-of-type(5), #approvTable td:nth-of-type(5) { width: 80px; }
    #approvTable th:nth-of-type(6), #approvTable td:nth-of-type(6) { width: 110px; }

    #unApprovTable th:nth-of-type(1), #unApprovTable td:nth-of-type(1) { width: 100px; }
    #unApprovTable th:nth-of-type(2), #unApprovTable td:nth-of-type(2) { width: 350px; }
    #unApprovTable th:nth-of-type(3), #unApprovTable td:nth-of-type(3) { width: 300px; }
    #unApprovTable th:nth-of-type(4), #unApprovTable td:nth-of-type(4) { width: 150px; text-align: center;}
    #unApprovTable th:nth-of-type(5), #unApprovTable td:nth-of-type(5) { width: 80px; }
    #unApprovTable th:nth-of-type(6), #unApprovTable td:nth-of-type(6) { width: 80px; }

    /* #noTable, #approvTable,#unApprovTbody */
    /* 프로젝트내용 마우스오버 */
    .hover-text-container {
        position: relative;
    }

    .hover-text {
    display: none;
    position: absolute;
    width: 540px;
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

    .hover-text-container2 {
        position: relative;
    }
    .hover-text2 {
    display: none;
    position: absolute;
    width: 340px;
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

    .hover-text-container2:hover .hover-text2 {
        display: inline-block;

    }
    /* 프로젝트내용 마우스오버 */

</style>
<div class="">
  <h4 class="menu_title">${temp_title}</h4>
  <div class="row mb-2">
    <div class="col text-end">
        <button type="button" class="btn btn-primary" id="enrollBtn">상담신청</button>
    </div>
  </div>
	<div class="dscsnContainer">
		<!--미승인-->
		<div class="row">
			<div class="col-12">
				<div class="card mb-2">
					<div class="card-body pb-1">
						<h4 class="fw-bold">미결</h4>
						<div id="no" class="mb-2 table-container">
                <table class="table scrolltable" id="noTable">
                  <thead class="bg-light">
                      <tr>
                          <th class="p-2">분류</th>
                          <th class="p-2">상담내용</th>
                          <th class="p-2">상담일</th>
                          <th class="p-2">상담원</th>
                          <th class="p-2">상담자</th>
                          <th class="p-2"></th>
                      </tr>
                  </thead>
                  <tbody id="noTbody">

                  </tbody>
                </table>
            	</div>
					</div>
				</div>
			</div>
		</div>
		<!--/.미승인-->
		<!--승인-->
		<div class="row">
			<div class="col-12">
				<div class="card mb-2">
					<div class="card-body pb-1">
						<h4 class="fw-bold">승인</h4>
						<div id="approv" class="table-container">

              <table class="table scrolltable" id="approvTable">
                <thead class="bg-light">
                    <tr>
                        <th class="p-2">분류</th>
                        <th class="p-2">상담내용</th>
                        <th class="p-2">상담일시</th>
                        <th class="p-2">상담원</th>
                        <th class="p-2">상담자</th>
                        <th class="p-2">호실</th>
                    </tr>
                </thead>
                <tbody id="approvTbody">

                </tbody>
              </table>
            </div>
					</div>
				</div>
			</div>
		</div>
		<!-- /.승인-->
		<!--반려-->
		<div class="row">
			<div class="col-12">
				<div class="card mb-2">
					<div class="card-body pb-1">
						<h4 class="fw-bold">반려</h4>
						<div id="unApprov" class="mb-2 table-container">
              <table class="table scrolltable" id="unApprovTable">
                <thead class="bg-light">
                    <tr>
                        <th class="p-2">분류</th>
                        <th class="p-2">상담내용</th>
                        <th class="p-2">반려사유</th>
                        <th class="p-2">상담일</th>
                        <th class="p-2">상담원</th>
                        <th class="p-2">상담자</th>
                    </tr>
                </thead>
                <tbody id="unApprovTbody">

                </tbody>
              </table>
            </div>
					</div>
				</div>
			</div>
		</div>
		<!-- /. 반려-->
	</div>

	<!-- 상담신청 모달 -->
    <div class="modal fade" tabindex="-1" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">상담신청</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <table class="w-100 modalTable">
                        <tr class="">
                            <td class="title">종류</td>
                            <td>
                                <select class="form-select mr-sm-2 mb-2" id="consulCdSelect">
                                    <c:forEach items="${consulCmCdVO}" var="consulCmCdVO">
                                        <option selected value="${consulCmCdVO.cdTypeId}-${consulCmCdVO.cdVl}">${consulCmCdVO.cdNm}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr class="">
                            <td class="title">상담원</td>
                            <td>
                                <select class="form-select mr-sm-2 mb-2" id="userNoSelect">
                                    <c:forEach items="${empList}" var="emp">
                                        <option selected value="${emp.empNo}">${emp.userNm}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>

                        <tr class="">
                            <td class="title">신청날짜</td>
                            <td>
                                <input type="date" class="form-control mb-2" value="" id="dscsnDt" >
                            </td>
                        </tr>
                        <tr>
                            <td class="title">신청내용</td>
                            <td><textarea class="form-control font-weight-normal" id="dscsnCn" maxlength="100" rows="3"></textarea></td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="modalEnrollBtn">등록</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    // 현재 날짜 가져오기
    var currentDate = new Date(); // 현재 날짜와 시간 가져오기
    // 년 월 일
    var year = currentDate.getFullYear(); //년
    var month = currentDate.getMonth() + 1; // 월
    var date = currentDate.getDate(); // 일
    var currDt = year + "-" + (month < 10 ? "0" + month : month) + "-" + (date < 10 ? "0" + date : date); // 오늘날짜

    // 테이블을 넣을 상자
    var no = document.querySelector("#noTbody");
    var approv = document.querySelector("#approvTbody");
    var unApprov = document.querySelector("#unApprovTbody");

    var enrollBtn = document.querySelector("#enrollBtn");
    var modal = new bootstrap.Modal('#myModal', {});
    enrollBtn.addEventListener("click", function() {
        modal.show();
        document.querySelector("#dscsnDt").value = currDt;
        document.querySelector("#dscsnDt").min = currDt;
    })


    $(document).on("click", "#modalEnrollBtn", function() {
        var dscsnCd = document.querySelector("#consulCdSelect").value;
        var empNo = document.querySelector("#userNoSelect").value;
        var dscsnDt = document.querySelector("#dscsnDt").value;
        var dscsnCn = document.querySelector("#dscsnCn").value;
        console.log(dscsnCd, " ", empNo, " ", dscsnDt);
        let data = {
            "dscsnCd" : dscsnCd,
            "empNo" : empNo,
            "dscsnDt" : dscsnDt,
            "dscsnCn" : dscsnCn
        }
        $.ajax({
            url: '/stu/hak/consult',
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
                    '상담 신청 완료',
                    '상담 신청이 완료되었습니다',
                    'success'
                ).then((result) => {
                    modal.hide();
                    firstAjax()
                    // 모달 내용 비우기

                    var consulCdSelect = document.getElementById("consulCdSelect");
                    // 첫 번째 option 요소 선택하기
                    consulCdSelect.selectedIndex = 0;
                    
                    var userNoSelect = document.getElementById("userNoSelect");
                    // 첫 번째 option 요소 선택하기
                    userNoSelect.selectedIndex = 0;

                    document.querySelector("#dscsnDt").value = currDt;

                    document.querySelector("#dscsnCn").value = "";
                    

                })
            },
            error: function(xhr, status, error) {
                // 요청이 실패했을 때 처리할 코드 작성
            }
        });
    })

    // 글자수 자르는 함수
    function stringSlice(str, maxLength) {
        if (str.length > maxLength) {
            return str.substring(0, maxLength) + "...";
        }
        return str;
    }

    // 시작화면에 리스트 뿌리기
    firstAjax()
    function firstAjax(){
        $.ajax({
            url: '/stu/hak/consult/list',
            method: 'post',
            dataType: 'json',
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(res) {
                console.log("결과",res);

                //미승인
                var consulNoList = res.consulNoList
                //승인
                var consulApprovList = res.consulApprovList
                //반려
                var consulUnApprovList = res.consulUnApprovList;

                // 미승인 테이블 생성
                consulNoStr = "";

                consulNoList.forEach(function(consul) {
                    consulNoStr += `    <tr>`;
                    consulNoStr += '        <td class="p-2">'+ consul.dscsnCd +'</td>';
                    consulNoStr += '        <td class="hover-text-container p-2">';
                    consulNoStr +=              stringSlice(consul.dscsnCn, 40);
                    consulNoStr += '            <label class="hover-text card-subtitle mb-1 mt-2">' + consul.dscsnCn +'</label>';
                    consulNoStr += '        </td>';
                    consulNoStr += '        <td class="p-2">'+ consul.dscsnDt +'</td>';
                    consulNoStr += '        <td class="p-2">'+ consul.empNo +'</td>';
                    consulNoStr += '        <td class="p-2">'+ consul.stuNo +'</td>';
                    consulNoStr += '        <td class="p-2 deleteBtn text-danger" data-dscsnNo="'+ consul.dscsnNo +'">취소</td>';
                    consulNoStr += `    </tr>`;
                });

                no.innerHTML = consulNoStr;
                // 미승인 테이블 끝

                // 승인 테이블 생성
                consulApprovStr = "";
                consulApprovList.forEach(function(consulApprov) {
                    consulApprovStr += `    <tr>`;
                    consulApprovStr += '        <td class="p-2">'+ consulApprov.dscsnCd +'</td>';
                    consulApprovStr += '        <td class="hover-text-container p-2">';
                    consulApprovStr +=              stringSlice(consulApprov.dscsnCn, 30);
                    consulApprovStr += '            <label class="hover-text card-subtitle mb-1 mt-2 ">' + consulApprov.dscsnCn +'</label>';
                    consulApprovStr += '        </td>';
                    consulApprovStr += '        <td class="p-2">'+ consulApprov.dscsnDt + ' '+ consulApprov.consulBgngHr + ' ~ ' + consulApprov.consulDdlbHr +'</td>';
                    consulApprovStr += '        <td class="p-2">'+ consulApprov.empNo +'</td>';
                    consulApprovStr += '        <td class="p-2">'+ consulApprov.stuNo +'</td>';
                    consulApprovStr += '        <td class="p-2">'+ consulApprov.consulNm +'</td>';
                    consulApprovStr += `    </tr>`;
                });

                approv.innerHTML = consulApprovStr;
                // 승인 테이블 끝

                // 반려 테이블 생성
                consulUnApprovStr = "";
                consulUnApprovList.forEach(function(consulUnApprov) {
                    consulUnApprovStr += `    <tr>`;
                    consulUnApprovStr += '        <td class="p-2">'+ consulUnApprov.dscsnCd +'</td>';
                    consulUnApprovStr += '        <td class="hover-text-container2 p-2">';
                    consulUnApprovStr +=              stringSlice(consulUnApprov.dscsnCn, 23);
                    consulUnApprovStr += '            <label class="hover-text2 card-subtitle mb-1 mt-2">' + consulUnApprov.dscsnCn +'</label>';
                    consulUnApprovStr += '        </td>';
                    consulUnApprovStr += '        <td class="hover-text-container2 p-2">';
                    consulUnApprovStr +=              stringSlice(consulUnApprov.rejectCn, 20);
                    consulUnApprovStr += '            <label class="hover-text2 card-subtitle mb-1 mt-2">' + consulUnApprov.rejectCn +'</label>';
                    consulUnApprovStr += '        </td>';
                    consulUnApprovStr += '        <td class="p-2">'+ consulUnApprov.dscsnDt +'</td>';
                    consulUnApprovStr += '        <td class="p-2">'+ consulUnApprov.empNo +'</td>';
                    consulUnApprovStr += '        <td class="p-2">'+ consulUnApprov.stuNo +'</td>';
                    consulUnApprovStr += `    </tr>`;
                });

                unApprov.innerHTML = consulUnApprovStr;

                //noTbody 높이를 넘었을 때 스크롤 생성에 대비하여 스크롤의 너비를 뺴준다.
                var listLength = consulNoList.length;
                if(listLength >= 4){
                    $("#noTbody").find("td:last-child").css("width", "calc(80px - 17px)");
                }

                //approvTbody 높이를 넘었을 때 스크롤 생성에 대비하여 스크롤의 너비를 뺴준다.
                var listLength = consulApprovList.length;
                if(listLength >= 4){
                    $("#approvTbody").find("td:last-child").css("width", "calc(80px - 17px)");
                }

                //unApprovTbody 높이를 넘었을 때 스크롤 생성에 대비하여 스크롤의 너비를 뺴준다.
                var listLength = consulUnApprovList.length;
                if(listLength >= 4){
                    $("#unApprovTbody").find("td:last-child").css("width", "calc(100px - 17px)");
                }
                // 미승인 테이블 끝
            },
            error: function(xhr, status, error) {
                // 요청이 실패했을 때 처리할 코드 작성
            }
        });
    }

    $(document).on("click", ".deleteBtn", function(e) {
        let dscsnNo = $(this).attr("data-dscsnNo");

        console.log(dscsnNo);
        Swal.fire({
        title: '상담신청 취소',
        text: "정말로 취소하시겠습니까?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: '확인',
        cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed) {
                let data = {
                        "dscsnNo": dscsnNo
                }
                console.log("dscsnNo",dscsnNo);
                $.ajax({
                    url: '/stu/hak/consult/delete',
                    method: 'post',
                    data: JSON.stringify(data),
                    dataType: 'text',
                    contentType:'application/json; charset=UTF-8',
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                    },
                    success: function(res) {
                        console.log("결과",res);
                        modal.hide();
                        Swal.fire(
                        '삭제완료',
                        '상담 신청 취소가 완료되었습니다',
                        'success'
                        ).then((result) => {
                          firstAjax()
                        })
                    },
                    error: function(xhr, status, error) {
                        // 요청이 실패했을 때 처리할 코드 작성
                    }
                });
            }
        })
    })

    // 글자수 제한 alert
    var dscsnCn = document.querySelector("#dscsnCn");

    dscsnCn.addEventListener("input", function() {
        var dscsnCnValue = this.value;
        var textCount = dscsnCnValue.length;

        if (textCount > 100) {
            Swal.fire(
            '글자 수 초과',
            '100자 이상 입력하실 수 없습니다!',
            'error'
            ).then((result) => {
            })
        }
    });

    // 시연을 위한 자동완성
    // $(document).keydown(function(event) {
    //     if (event.keyCode == '220') {
    //         console.log("백슬레쉬 누름");
    //         document.querySelector("#consulCdSelect").value = "D003-1";
    //         document.querySelector("#userNoSelect").value = "E2302007";
    //         document.querySelector("#dscsnDt").value = "2023-08-08";
    //         document.querySelector("#dscsnCn").value = "제 스펙과 이력서로 네카라 정도는 취업할수 있을까요? 이력서 첨삭부탁드려요. 불안합니다. 프론트엔드가 좋을까요? 백엔드가 좋을까요?";
    //     }
    // })
    var myModal = document.querySelector("#myModal")
    myModal.addEventListener('show.bs.modal', function () {
        $(document).keydown(function(event) {
            if (event.keyCode == '220') {
                console.log("백슬레쉬 누름");
                document.querySelector("#consulCdSelect").value = "D003-1";
                document.querySelector("#userNoSelect").value = "E2302007";
                document.querySelector("#dscsnDt").value = "2023-08-14";
                document.querySelector("#dscsnCn").value = "제 스펙과 이력서로 네카라 정도는 취업할수 있을까요? 이력서 첨삭부탁드려요. 불안합니다. 프론트엔드가 좋을까요? 백엔드가 좋을까요?";
            }
        })
    })
</script>