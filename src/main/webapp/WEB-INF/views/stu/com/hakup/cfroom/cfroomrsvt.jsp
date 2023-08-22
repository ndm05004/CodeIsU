<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
  .menu_title {
  margin: 3px 0 15px;
  padding: 0 0 0 13px;
  background: url(/resources/img/h4.png) no-repeat 0 4px;
  font-size: 22px;
  font-weight: 700;
  color: #000;
  }
  .tdboxHeight {
    height: 40px;
    width: 101px;
    position: relative;
    overflow: hidden;
  }

  .scroll-text {
    position: absolute;
    animation: marquee 10s linear infinite;
    width: 100%;
    max-width: 131px; /* 최대 너비를 지정하여 폭이 넘치지 않도록 설정 */
    overflow: hidden; /* 내용이 넘칠 경우 숨김 처리 */
  }

  .marquee-container {
    display: inline-block;
    position: relative;
    animation: marquee-container 10s linear infinite;
    animation-delay: 1s;
  }

  @keyframes marquee {
    0% {
      transform: translateX(100%);
    }
    100% {
      transform: translateX(-20%);
    }
  }

  @keyframes marquee-container {
    0% {
      transform: translateX(0);
    }
    100% {
      transform: translateX(-100%);
    }
  }
  .dt{
    width : 43px;
  }

  /* 회의실에 hover 했을 때 */
  tr td:not(:first-child){
    cursor: pointer;
  }
  tr td:not(:first-child):hover {
    background-color: #89B6FF;
    color: white; 
  }

  /* 예약된 회의실 스타일 변경 */
  td.reserved {
    background-color: #3246C4;
    color: white;
  }
</style>
<div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
					<div class="container p-0">
					    <h4 class="menu_title">회의실 예약하기</h4>
              <div class="text-muted mb-4">빈 칸 클릭시 예약이 가능합니다.</div>
						<div class="form-group mb-1">
							<input type="date" class="form-control" value="" id="cfroomRsvtDt">
						</div>
						<table class="table table-borderless">
							<thead >
							</thead>
							<tbody >

							</tbody>
						</table>

					</div>
                </div>
            </div>
        </div>
    </div>


	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">회의실 예약</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
          <div class="row">
            <div class="col-3">
              회의실
            </div>
            <div class="col-9 p-0">
              <div id="cfroomRsvtCd"></div>
            </div>
          </div>
          <div class="row">
            <div class="col-3">
              예약 시간
            </div>
            <div class="col-9 p-0">
              <div id="cfroomRsvtHr"></div>
            </div>
          </div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary revtBtn">예약</button>
				</div>
			</div>
		</div>
	</div>
<script>
var tdElements = document.querySelectorAll(".scrolling-text");
tdElements.forEach(function(td) {
  var text = td.innerText;
  td.setAttribute("data-text", text);
});
var currentDate = new Date(); // 현재 날짜와 시간 가져오기
var year = currentDate.getFullYear(); //년
var month = currentDate.getMonth() + 1; // 월
var date = currentDate.getDate(); // 일

var cfroomRsvtDt = document.querySelector("#cfroomRsvtDt"); // 날짜 input 요소
// 처음 화면 로딩시
var currDt = year + "-" + (month < 10 ? "0" + month : month) + "-" + (date < 10 ? "0" + date : date); // 오늘날짜
cfroomRsvtDt.value = currDt; // 날짜 input에 오늘날짜 넣기

var rsvtDt = cfroomRsvtDt.value;
tbodyAjax();

// 날짜가 바뀌면
cfroomRsvtDt.addEventListener("change", function() {
    rsvtDt = cfroomRsvtDt.value;
    // 선택된 날짜에 대한 추가 동작 수행
    tbodyAjax();
});

var userNo = "";
// 화면에 정보 뿌리기
function tbodyAjax(){

	$.ajax({
	    url: '/stu/hak/cfroom/selectdt?rsvtDt=' + rsvtDt,
	    method: 'get',
	    data: rsvtDt,
	    dataType: 'json',
	    beforeSend: function(xhr) {
	               xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");

	    },
	    success: function(resp) {
	    	console.log("resp",resp);
	    	var mettingRoomList = resp.mettingRoomList;
	    	var cfroomRestList = resp.cfroomRestList;
			  userNo = resp.userNo;
        console.log("체킁", userNo)
	    	console.log("mettingRoomList",mettingRoomList);

	    	theadCode = "";
	    	theadCode += `	<tr>`;
	    	theadCode += `		<td></td>`;
        // 첫 글자만 잘라서 층수 구하기
        const floorList = [];
        for (const mettingRoom of mettingRoomList) {
          const room = mettingRoom.mettingRoomNm;
          console.log("room", room)
          const floor = room.slice(0, 1);
          floorList.push(floor);
        }
        // 층수별 개수 계산
        const floorCount = new Map();
        for (let i = 0; i < floorList.length; i++) {
          const floor = floorList[i];
          if (floorCount.has(floor)) {
            floorCount.set(floor, floorCount.get(floor) + 1);
          } else {
            floorCount.set(floor, 1);
          }
        }
        theadCode += `</tr>         `;
        theadCode += `	<td></td> `;
        for (const [key, value] of floorCount.entries()) {
          // 층
          theadCode += `<td class="text-center bg-info text-white border-end p-2" colspan="\${value}">\${key}층</td>`;
        }
        theadCode += `<tr>          `;

          // 회의실 번호
        theadCode += `	<td></td> `;
          for (const mettingRoom of mettingRoomList) {
            // 호
            theadCode += `  <th scope="col" class="text-center p-2 pt-3">\${mettingRoom.mettingRoomNm}</th>`;
        }
	    	theadCode += `</tr>`;



	    	tbodyCode = "";

	    	// 회의실 예약 목록
        for(var i=9; i<=21; i++) {
          tbodyCode += `<tr>`;
          if(i<10){
            var hour = "0" +i;
          } else {
            var hour = i;
          }
          tbodyCode += `<td class="dt p-0 fs-6 align-middle tdboxHeight">\${hour}시</td>`
          for (const mettingRoom of mettingRoomList) {
            // 속성에 시간과 강의실 정보 넣기
            tbodyCode += `   <td style="border: 1px solid; width: 101px;"`;
            if(i<10){
              var hour = "0" +i;
            } else {
              var hour = i;
            }
            tbodyCode += `		  data-rsvtHr="\${hour}"`;
            tbodyCode += `			data-mettingRoomNm="\${mettingRoom.mettingRoomNm }"`;
            tbodyCode += `			data-cfroomCd="\${mettingRoom.cfroomCd }"`;


            // 예약자가 있는지 확인하여 스타일 조절
            var reserved = "";
            if(cfroomRestList != null){
                for (const cfroomRest of cfroomRestList) {
                  if(cfroomRest.cfroomCd== mettingRoom.cfroomCd && cfroomRest.rsvtHr == hour){
                    reserved = "reserved";
                    if(cfroomRest.stuNo == userNo){
                      reserved = "myreserved";
                    }
                  }
                }
            }
            // 내가 예약한 곳이라면 
            if (reserved=="myreserved") {
              tbodyCode += ` class="tdboxHeight cfroomBtn text-center p-0 align-middle scrolling-text reserved"`;
            } 
            // 이미 예약된 곳이라면
            if(reserved == "reserved") {
              tbodyCode += ` class="tdboxHeight cfroomBtn text-center p-0 align-middle scrolling-text bg-light"`;
            }
            if(reserved == ""){
              tbodyCode += ` class="tdboxHeight cfroomBtn text-center p-0 align-middle scrolling-text"`;

            }


            tbodyCode += `      ">`;
            tbodyCode += `    	  <div class="scroll-text  marquee-container align-middle txtDiv">`;
            // td에 추가
            if(cfroomRestList != null){
                for (const cfroomRest of cfroomRestList) {
                  if(cfroomRest.cfroomCd== mettingRoom.cfroomCd && cfroomRest.rsvtHr == hour){
                    tbodyCode += `    <div class="fs-6 align-middle" data-userNo="\${cfroomRest.stuNo}">\${cfroomRest.lectureRoomNm} \${cfroomRest.userNm}</div>`;
                  }
                }

            }
              tbodyCode += `	    </div>`;
              tbodyCode += `  </td>     `;
            }
            tbodyCode += `</tr>`;
        }


	    	var thead = document.getElementsByTagName("thead")[0];
	    	var tbody = document.getElementsByTagName("tbody")[0];

	    	thead.innerHTML = theadCode;
	    	tbody.innerHTML = tbodyCode;
	    }, // Success 끝
	    error: function(xhr, status, error) {
	      // 요청이 실패했을 때 처리할 코드 작성
	      alert("제발");
	    }
	});
}


$(document).ready(function() {
	var rsvtHr = "";
	var cfroomCd = "";
	var mettingRoomNm = "";

	const modal = new bootstrap.Modal('#exampleModal', {});
	$(document).on("click", ".cfroomBtn", function() { // 동적 이벤트 바인딩
		// 예약현황 가져오기
		var rsvt = $(this).find('.txtDiv').text().trim();
		vsrtUserNo = $(this).find('.txtDiv').find('div').attr("data-userNo"); // 예약한 유저 정보 가져오기
    //alert("지금 날짜"+currDt);
    //alert("입력된 날짜"+rsvtDt);
 		if((rsvtDt < currDt) || (rsvt!= "" && (userNo != vsrtUserNo))){
			modal.hide();
		} else {
			// <button type="button" class="btn btn-primary revtBtn">예약</button>
			if(userNo == vsrtUserNo){
				$(".revtBtn").removeClass('btn-primary').addClass('btn-danger').text('예약취소');
			} else {
				$(".revtBtn").removeClass('btn-danger').addClass('btn-primary').text('예약');

			}
			modal.show();
		}

		const cfroomRsvtCd = document.querySelector("#cfroomRsvtCd");
		const cfroomRsvtHr = document.querySelector("#cfroomRsvtHr");

		rsvtHr = $(this).attr("data-rsvtHr");
		cfroomCd = $(this).attr("data-cfroomCd");
		mettingRoomNm = $(this).attr("data-mettingRoomNm");
		var cfroomRsvtDt = document.querySelector("#cfroomRsvtDt").value;
		console.log("rsvtHr",rsvtHr);
		console.log("cfroomCd",mettingRoomNm);

		cfroomRsvtCd.textContent = mettingRoomNm;
		cfroomRsvtHr.textContent = rsvtHr + "시 ~ " + (parseInt(rsvtHr)+1) + "시";

	});
	$(".revtBtn").click(function() {
    let data = {
      "rsvtDt":document.querySelector("#cfroomRsvtDt").value,
      "rsvtHr": rsvtHr,
      "cfroomCd":cfroomCd
    }
		var revtBtnText = $(this).text();
    console.log("revtBtnText",revtBtnText);
		if(revtBtnText == '예약'){
			$.ajax({
				url: '/stu/hak/cfroom',
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
							'예약 완료',
							'예약이 완료되었습니다',
							'success'
          ).then((result) => {
            tbodyAjax();
          })
				},
				error: function(xhr, status, error) {
				  // 요청이 실패했을 때 처리할 코드 작성
				  alert("제발");
				}
			});

		} else {
			Swal.fire({
				title: '예약취소',
				text: "정말로 취소하시겠습니까?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: '확인',
				cancelButtonText: '취소'
				}).then((result) => {
				if (result.isConfirmed) {
					$.ajax({
						url: '/stu/hak/cfroom/delete',
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
							'예약 취소가 완료되었습니다',
							'success'
							).then((result) => {
							  tbodyAjax();
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
	})
});

</script>