<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
.menu_title {
margin: 3px 0 15px;
padding: 0 0 0 13px;
background: url(/resources/img/h4.png) no-repeat 0 4px;
font-size: 22px;
font-weight: 700;
color: #000;
}
.pr-0{
    padding-right: 0px;
}
.pl-0{
    padding-left: 0px;
}
.wave {
    text-align: center;
    width: 10px;
}

.attdanTime{
	display: inline-block;
    width: 182px;
}

.title {
    width: 85px;
	height: 45px;
}
.btnTh {
    width:90px;
}
#deleteBtn {
    border: none;
    background-color: white;
}


/* 프로젝트내용 마우스오버 */
.hover-text-container {
 	position: relative;
}

.hover-text {
  display: none;
  position: absolute;
  width: 600px;
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

</style>
<div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
    <h4 class="menu_title">조퇴 외출</h4>
    <div class="d-flex justify-content-end mb-2">
        <button type="button" class="btn btn-primary" id="enrollBtn">신청</button>
    </div>
    <!-- 생성된 리스트 -->
    <div id="attdanListBox">

    </div>

    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">조퇴/외출</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="w-100 modalTable">
                    <tr class="mb-1">
                        <td class="title">성명</td>
                        <td>${stuVo.userNm}</td>
                    </tr>
                    <tr class="mb-1">
                        <td class="title">종류</td>
                        <td>
                            <select class="form-select mr-sm-2" id="attdanCdSelect">
                                <c:forEach items="${attdanCmCdVO}" var="attdanCmCdVO">
	                                <option selected value="${attdanCmCdVO.cdTypeId}-${attdanCmCdVO.cdVl}">${attdanCmCdVO.cdNm}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr class="mb-1">
                        <td class="title">신청날짜</td>
                        <td><input type="date" class="form-control" value="2008-05-13T22:33:00" id="attdanDt"></td>
                    </tr>
                    <tr class="mb-1 inputTimeTr" id="inputTimeTr">
                    <tr class="">
                        <td class="title ">사유</td>
                        <td><textarea class="form-control font-weight-normal" id="attdanCn" maxlength="100" rows="3"></textarea></td>
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

    // 시간
    var hours = currentDate.getHours();
    var minutes = currentDate.getMinutes();
    // 시간, 분, 초를 두 자리 숫자 형태로 조합
    var currTime = (
        (hours < 10 ? "0" + hours : hours) + ":" +
        (minutes < 10 ? "0" + minutes : minutes) + ""
        );

    var attdanListBox = document.querySelector("#attdanListBox");
    var modal = new bootstrap.Modal('#myModal', {});
    // modal
    var enrollBtn = document.querySelector("#enrollBtn");
    var attdanCd = "";
    enrollBtn.addEventListener("click", function() {
        modal.show();
    })


    var startTime = currTime;
    var endTime = currTime;
    $('#myModal').on('shown.bs.modal', function () {
        const inputTimeTr = document.querySelector('.inputTimeTr');
        // modal input date에 현재 날짜 넣기
        var attdanDt = document.querySelector("#attdanDt");
        attdanDt.value = currDt;
        attdanDt.min = currDt;
        var attdanCdSelect = $('#attdanCdSelect');
        attdanCd = attdanCdSelect.val();
        // modal의 조퇴/외출에 따른 시간 입력요소 추가
        $(document).on("change", "#attdanCdSelect", function(e) {
            attdanCd = $(this).val(); // 선택된 옵션의 값을 가져옵니다.
            // modal 조퇴 선택시
            if (attdanCd == "S003-2"){
                // tr에 시간 input 지우기
                inputTimeTr.innerHTML = "";
            }
            // modal 외출 선택시
            if (attdanCd == "S003-1"){
                // tr 에 시간 input 추가
                var tdStr = '';
                tdStr += '<td class="title">시간</td>';
                tdStr += '<td>';
                tdStr += '  <input type="time" class="form-control attdanStartTime attdanTime" value="22:33:00" id = "starTime">';
                tdStr += '  ~';
                tdStr += '  <input type="time" class="form-control attdanEndTime attdanTime" value="22:33:00" id = "endTime">';
                tdStr += '</td>';

                inputTimeTr.innerHTML = tdStr;
                var attdanStartTime = document.querySelector(".attdanStartTime");
                var attdanEndTime = document.querySelector(".attdanEndTime");
                attdanStartTime.value = currTime;
                attdanEndTime.value = currTime;

                $(document).on("change", ".attdanStartTime", function() {
                    startTime = $(this).val();
                    console.log(startTime);
                })
                $(document).on("change", ".attdanEndTime", function() {
                    endTime = $(this).val();
                    console.log(endTime);
                })
            }

        })

        // 엔터키를 입력할 때 버튼을 클릭한 효과
        $('#attdanCn').keydown(function(event) {
            if (event.key === 'Enter') {
                $('#modalEnrollBtn').click();
            }
        });
    })
    // 조퇴/외출 신청
    $(document).on("click", "#modalEnrollBtn", function(e) {
        var attdanCn = $("#attdanCn").val();
        if(attdanCn == ""){
            Swal.fire({
                title: '입력 오류',
                text: "조퇴/외출 사유를 입력해주세요",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'

            }).then((result) => {
            })
        } else {
            // modal 조퇴 선택시
            if (attdanCd == "S003-2"){
                startTime = null;
                endTime = null;
            } 
            let data = {
                "attdanDt": $("#attdanDt").val(),
                "attdanBgng": startTime,
                "attdanDdlb":endTime,
                "attdanCd":attdanCd,
                "attdanCn": attdanCn
            }
            console.log("data", data);
            $.ajax({
                url: '/stu/hak/attdan',
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
                      '조퇴/등록',
                      '조퇴/외출 신청이 완료되었습니다',
                      'success'
                      ).then((result) => {
                        attdanList();
                        // 모달 내용 초기화
                        // 모달 내용 초기화
                        var attdanCdSelect = document.getElementById("attdanCdSelect");

                        // 모든 옵션의 selected 속성 제거
                        for (var i = 0; i < attdanCdSelect.options.length; i++) {
                            attdanCdSelect.options[i].removeAttribute("selected");
                        }

                        // value 값이 "S003-2"인 옵션을 선택 상태로 변경
                        for (var i = 0; i < attdanCdSelect.options.length; i++) {
                            if (attdanCdSelect.options[i].value === "S003-2") {
                                attdanCdSelect.options[i].setAttribute("selected", "selected");
                                break; // 해당 옵션을 찾았으므로 루프 종료
                            }
                        }


                        document.querySelector("#attdanDt").value = currDt;
                        document.querySelector("#attdanCn").value = "";
                        document.querySelector("#inputTimeTr").innerHTML = "";
                        

                    })

                },
                error: function(xhr, status, error) {
                    // 요청이 실패했을 때 처리할 코드 작성
                    alert("제발");
                }
            });
        }
    })// 신청 이벤트 끝

    // 글자수 자르는 함수
    function stringSlice(str, maxLength) {
        if (str.length > maxLength) {
            return str.substring(0, maxLength) + "...";
        }
        return str;
    }

    attdanList();
    // 화면에 리스트 뿌려주기
    function attdanList(){
        $.ajax({
            url: '/stu/hak/attdan/attdanList',
            method: 'get',
            dataType: 'json',
            success: function(res) {
                console.log("결과",res);
                console.log("결과",res.length);
                attdanListStr = "";
                attdanListStr += `<table class="table">`;
                attdanListStr += `  <thead>`;
                attdanListStr += `    <tr class="bg-light">`;
                attdanListStr += `      <th scope="col">구분</th>`;
                attdanListStr += `      <th scope="col">날짜</th>`;
                attdanListStr += `      <th scope="col">시간</th>`;
                attdanListStr += `      <th scope="col">사유</th>`;
                attdanListStr += `      <th scope="col">상태</th>`;
                attdanListStr += `      <th scope="col" class="btnTh"></th>`;
                attdanListStr += `    </tr>`;
                attdanListStr += `  </thead>`;
                attdanListStr += `  <tbody>`;
                for(let i=0; i<res.length; i++){
                    var attdanVO = res[i];
                    // 상태
                    let attdanApproval = "";
                    let deleteBtn = ""
                    if(attdanVO.attdanApproval == "Y") {
                        attdanApproval = "승인"
                    } else {
                        attdanApproval = "미결"
                    }

                    // 등록일
                    let attdanBgng = attdanVO.attdanBgng;
                    let attdanDdlb = attdanVO.attdanDdlb;
                    let time = " - "
                    if((attdanBgng == null  || attdanBgng == "") && (attdanDdlb == null  || attdanDdlb == "")){
                    } else {
                        time = attdanBgng + " ~ " + attdanDdlb;
                    }

                    attdanListStr += `    <tr>`;
                    attdanListStr += `      <td scope="row">\${attdanVO.attdanCd}</td>`;
                    attdanListStr += `      <td scope="row">\${attdanVO.attdanDt}</td>`;
                    attdanListStr += `      <td scope="row">\${time}</td>`;
                    var attdanCn = stringSlice(attdanVO.attdanCn, 34)
                    attdanListStr += `      <td scope="row" class="hover-text-container">`;
                    attdanListStr +=            attdanCn;
                    // 마우스 오버시 보일 내용
                    attdanListStr += '          <label class="hover-text card-subtitle mb-1 mt-2 ">' + attdanVO.attdanCn +'</label>';
                    attdanListStr += `      </td>`;
                    attdanListStr += `      <td scope="row">\${attdanApproval}</td>`;
                    attdanListStr += `      <td scope="row" class="text-end">`;
                        if (attdanApproval == "미결"){
                            attdanListStr += `<button type="button" class="text-danger" id="deleteBtn" data-attdanNo="\${attdanVO.attdanNo}">취소</button>`;
                        }
                    attdanListStr += `      </td>`;
                    attdanListStr += `    </tr>`;
                }
                attdanListStr += `  </tbody>`;
                attdanListStr += `</table>`;
                console.log("attdanListStr",attdanListStr);
                attdanListBox.innerHTML = attdanListStr;

            },
            error: function(xhr, status, error) {
                // 요청이 실패했을 때 처리할 코드 작성
                alert("제발");

            }
        });
    }


    $(document).on("click", "#deleteBtn", function(e) {
        let attdanNo = $(this).attr("data-attdanNo");

        Swal.fire({
        title: '조퇴/외출',
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
                        "attdanNo": attdanNo
                }
                console.log("attdanNo",attdanNo)
                $.ajax({
                    url: '/stu/hak/attdan/delete',
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
                        '조퇴/외출 신청 취소가 완료되었습니다',
                        'success'
                        ).then((result) => {
                          attdanList();
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


    // 글자수 제한 alert
    var attdanCn = document.querySelector("#attdanCn");

    attdanCn.addEventListener("input", function() {
        var attdanCnValue = this.value;
        var textCount = attdanCnValue.length;
        
        if (textCount > 100) {
            Swal.fire(
            '글자 수 초과',
            '100자 이상 입력하실 수 없습니다!',
            'error'
            ).then((result) => {
            })
        }
    });
</script>
