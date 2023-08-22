<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<style>
  .task {
    border: 1px solid #e6e3e2;
  }
  .taskCn {
    border: 1px solid #e6e3e2;
  }

  p.task {
    background-color: #f4f2f2;
  }
  p.taskCn {
    background-color: #f4f2f2;
  }

  .msubBtn {
    background-color: #344767;
    color: white;
  }
  .mcanBtn {
    border: 1px solid #e6e3e2;
  }

  .circle {
    width: 20px;
    height: 20px;
    border-radius: 50%;
  }

  #thumnailBox {
    border: 1px solid black;
    width: 200px;
    height: 200px;
  }

  #fileZone {
    border: 1px solid gray;
    height: 230px;
  }
  .modal-dialog {
    max-width: 650px;
  }

  .iconBtn {
    cursor: pointer;
  }
  .allSave {
    cursor: pointer;
  }

  .storageItem {
    display: flex;
    align-items: center;
  }

  .itemTitle {
    color: black;
  }

  tr {
    cursor: pointer;
  }

  label.necessary::after {
    content: "*";
    color: red;
    margin-left: 4px;
  }

  th {
    border-bottom: 1px solid #d2d7dc;
    background: #f9fafb;
    border-top: 1px solid black;
    font-size: 1rem;
  }

  .table {
    width: 95%;
  }

  .table-container {
    display: flex;
    justify-content: center;
  }

  .table th {
    font-weight: 400;
  }

  .my-auto {
    font-size: 1rem;
  }
</style>
<script
  src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"
  integrity="sha512-XMVd28F1oH/O71fzwBnV7HucLxVwtxf26XV8P4wPk26EDxuGZ91N8bsOttmnomcCD3CS5ZMRL50H0GgOHvegtg=="
  crossorigin="anonymous"
  referrerpolicy="no-referrer"
></script>
<script
  src="https://cdnjs.cloudflare.com/ajax/libs/jszip-utils/0.1.0/jszip-utils.min.js"
  integrity="sha512-3WaCYjK/lQuL0dVIRt1thLXr84Z/4Yppka6u40yEJT1QulYm9pCxguF6r8V84ndP5K03koI9hV1+zo/bUbgMtA=="
  crossorigin="anonymous"
  referrerpolicy="no-referrer"
></script>
<script
  src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"
  referrerpolicy="no-referrer"
></script>

<div class="card mt-3" id="storageList"></div>

<div
  class="modal fade"
  id="storageModal"
  role="dialog"
  aria-labelledby="storageModal"
  aria-hidden="true"
>
  <div class="modal-dialog d-flex justify-content-center" role="document">
    <div class="modal-content" id="storageModalBody"></div>
  </div>
</div>

<script>
  //서버에서 발행된 헤더네임과 토큰갑사 저장
  var header = "${_csrf.headerName}";
  var token = "${_csrf.token}";

  const projNo = "${projNo}";
  stuNo = "${userNo}";

  let page;
  let searchType;
  let searchWord;

  function kbToMb(fileSumSizeNum) {
    if (fileSumSizeNum > 1024) {
      fileSumSizeNum = fileSumSizeNum / 1024;
      fileSumSizeNum = parseFloat(fileSumSizeNum.toFixed(2));
      fileSumSizeNum = fileSumSizeNum + "MB";
    } else if (fileSumSizeNum < 0) {
      fileSumSizeNum = 0 + "KB";
    } else {
      fileSumSizeNum = fileSumSizeNum + "KB";
    }
    return fileSumSizeNum;
  }

  function byteToKbToMb(fileSumSizeNum) {
    if (fileSumSizeNum >= 1024 * 1024) {
      return (fileSumSizeNum / (1024 * 1024)).toFixed(2) + "MB";
    } else if (fileSumSizeNum >= 1024) {
      return (fileSumSizeNum / 1024).toFixed(2) + "KB";
    } else {
      return fileSumSizeNum + "Bytes";
    }
  }

  function subFileSize(fileSize, fileSumSize, fileSumSizeNum, fileSizeNum) {
    let isMB = fileSize.includes("MB");
    let isKB = fileSize.includes("KB");
    let isByte = fileSize.includes("Byte");

    let sIsMB = fileSumSize.includes("MB");
    let sIsKB = fileSumSize.includes("KB");
    let sIsByte = fileSumSize.includes("Byte");

    if (isKB && sIsKB) {
      fileSumSizeNum = fileSumSizeNum - fileSizeNum;
    } else if (isKB && sIsMB) {
      fileSumSizeNum = fileSumSizeNum * 1024 - fileSizeNum;
    } else if (isKB && sIsByte) {
      fileSumSizeNum = fileSumSizeNum / 1024 - fileSizeNum;
    } else if (isByte && sIsMB) {
      fileSumSizeNum = fileSumSizeNum * 1024 - fileSizeNum / 1024;
    } else if (isByte && sIsByte) {
      fileSumSizeNum = fileSumSizeNum / 1024 - fileSizeNum / 1024;
    } else if (isByte && sIsKB) {
      fileSumSizeNum = fileSumSizeNum - fileSizeNum / 1024;
    } else if (isMB && sIsMB) {
      fileSumSizeNum = fileSumSizeNum * 1024 - fileSizeNum * 1024;
    } else if (isMB && sIsKB) {
      fileSumSizeNum = fileSumSizeNum - fileSizeNum * 1024;
    } else if (isMB && sIsByte) {
      fileSumSizeNum = fileSumSizeNum / 1024 - fileSizeNum * 1024;
    }

    fileSumSizeNum = parseFloat(fileSumSizeNum.toFixed(2));
    return fileSumSizeNum;
  }

  function sumFileSize(fileSize, fileSumSize, fileSumSizeNum, fileSizeNum) {
    let isMB = fileSize.includes("MB");
    let isKB = fileSize.includes("KB");
    let isByte = fileSize.includes("Byte");

    let sIsMB = fileSumSize.includes("MB");
    let sIsKB = fileSumSize.includes("KB");
    let sIsByte = fileSumSize.includes("Byte");

    if (isKB && sIsKB) {
      fileSumSizeNum = fileSumSizeNum + fileSizeNum;
    } else if (isKB && sIsMB) {
      fileSumSizeNum = fileSumSizeNum * 1024 + fileSizeNum;
    } else if (isKB && sIsByte) {
      fileSumSizeNum = fileSumSizeNum / 1024 + fileSizeNum;
    } else if (isByte && sIsMB) {
      fileSumSizeNum = fileSumSizeNum * 1024 + fileSizeNum / 1024;
    } else if (isByte && sIsByte) {
      fileSumSizeNum = fileSumSizeNum / 1024 + fileSizeNum / 1024;
    } else if (isByte && sIsKB) {
      fileSumSizeNum = fileSumSizeNum + fileSizeNum / 1024;
    } else if (isMB && sIsMB) {
      fileSumSizeNum = fileSumSizeNum * 1024 + fileSizeNum * 1024;
    } else if (isMB && sIsKB) {
      fileSumSizeNum = fileSumSizeNum + fileSizeNum * 1024;
    } else if (isMB && sIsByte) {
      fileSumSizeNum = fileSumSizeNum / 1024 + fileSizeNum * 1024;
    }

    fileSumSizeNum = parseFloat(fileSumSizeNum.toFixed(2));
    console.log("fileSumSizeNum : : : : ", fileSumSizeNum);
    return fileSumSizeNum;
  }

  const storageList = (projNo, page, searchType, searchWord) => {
    if (page == null) {
      page = 1;
    }

    if (searchType == null) {
      searchType = "title";
    }

    $.ajax({
      url: "/pms/project/storageList",
      data: {
        projNo: projNo,
        currentPage: page,
        searchType: searchType,
        searchWord: searchWord,
      },
      type: "get",
      dataType: "json",
      success: function (res) {
        console.log(res);
        console.log(res.pagingVO);
        console.log(res.pagingVO.dataList);

        const pageNum =
          res.pagingVO.totalRecord -
          (res.pagingVO.currentPage - 1) * res.pagingVO.screenSize;
        const dataList = res.pagingVO.dataList;
        const pagingHTML = res.pagingVO.pagingHTML;

        let projectStorageList = `

        <form class="input-group input-group-outline" id="searchForm">

          <div class="container mt-5">
	        <div class="row">
		        <div class="col-5 pe-2">
			        <button type="button" id="insertStorageBtn" class="ms-4 btn btn-outline-secondary msubBtn">
			      		 등록
			        </button>
		        </div>
		        <div class="col-2">
		        </div>

				<div class="col-4 ms-6" style="border: none;">
			        <form class="input-group input-group-outline" id="searchForm" style="border: none;">
		              <input type="hidden" name="page" id="page" />
                  <input type="hidden" name="page" id="page" value="1">
					  <div class="d-flex justify-content-end border rounded bg-white" style="border: none;">
						  <select class="w-60 form-control" id="searchType"  style="border: none;">
			                  <option value="title" id="searchTypeTitle">제목
			                  </option>
			                  <option value="writer" id="searchTypeWriter">작성자</option>
			                  <option value="titleWriter" id="searchTypeTitleWriter">제목+작성자</option>
		          </select>
		            <span style="height:8px;color: #e2e2e2;/* line-height: 38px; */">| </span>
		            <input type="text" id="searchWord" name="searchWord" class="form-control" placeholder="Search" style="border: none;">
					      <button type="button" id="searchBtn" class="w-10 btn btn-default mb-0 search">
							  <i class="fas fa-search" aria-hidden="true"></i>
						  </button>
				      </div>
				    </form>
				</div>

        </form>


  <div class="table-container">
    <table class="table align-items-center mb-0">
      <thead>
        <tr>
          <th class="ps-0">번호</th>
          <th class="ps-0">제목</th>
          <th class="ps-0">등록자</th>
          <th class="ps-0">등록일</th>

          <th class="ps-0" style="text-align:right;">조회수</th>

        </tr>
      </thead>
      <tbody>
        `;

        for (let i = 0; i < dataList.length; i++) {
          let thumnails = "";
          if (dataList[i].atchFileList[0].fileNm != null) {
            for (let j = 0; j < dataList[i].atchFileList.length; j++) {
              thumnails += `
              <a href="javascript:;" class="avatar avatar-xs rounded-3" data-bs-toggle="tooltip" data-bs-placement="bottom" aria-label=\${dataList[i].atchFileList[j].fileNm} data-bs-original-title=\${dataList[i].atchFileList[j].fileNm} >
              <img src="\${dataList[i].atchFileList[j].fileThumb}" class="avatar avatar-sm rounded-3">
              </a>
              `;
            }
          }
          projectStorageList += `
        <tr>
          <td class="ps-0">

            <div class="my-auto">
                \${pageNum-i}
            </div>

          </td>
          <td class="ps-0">
            <div class="my-auto">
              <div class="row">
                <div class="col-2">
                    <div class="avatar-group mt-2">
                      \${thumnails}
                    </div>
                </div>
                <div class="col-3">
                  \${dataList[i].strTitle}
                </div>
                </div>
              </div>

            </div>
          </td>
          <td class="ps-0">
            <div class="my-auto">
              \${dataList[i].userNm}
            </div>

            </td>
            <td class="ps-0">
              <div class="my-auto">
                \${dataList[i].strRegDt}
              </div>
            </td>
            <td class="ps-0">
              <div class="my-auto" style="text-align:right;">
                \${dataList[i].strViews}
              </div>
            </td>
          <input type="hidden" class="strNo" value=\${dataList[i].strNo}>
        </tr>
        `;
        }

        projectStorageList += `
            </tbody>
            </table>
        </div>
        <div class="card-footer clearfix" id="pagingArea">
            \${pagingHTML}
        </div>
        `;
        $("#storageList").html(projectStorageList);
        $("#page").val(page);
        $("#searchType").val(searchType);
        $("#searchWord").val(searchWord);
        console.log(
          "page, searchType, searchWord : ",
          page,
          searchType,
          searchWord
        );
        pagingClick();

        insertBtn();
      },
      error: function (xhr) {
        console.log("storageList 상태: " + xhr.status);
      },
    });
  };

  storageList(projNo, page, searchType, searchWord);

  const pagingClick = () => {
    let searchForm = $("#searchForm");
    let pagingArea = $("#pagingArea");

    let searchBtn = $("#searchBtn");

    let shWord = "";
    let shType = "";

    searchBtn.on("click", function () {
      shWord = $("#searchWord").val();
      shType = $("#searchType").val();

      storageList(projNo, page, shType, shWord);
    });

    pagingArea.on("click", "a", function (event) {
      event.preventDefault();
      var pageNo = $(this).data("page");
      searchForm.find("#page").val(pageNo);

      shWord = $("#searchWord").val();
      shType = $("#searchType").val();

      storageList(projNo, pageNo, shType, shWord);
    });
  };

  const storageInsert = () => {
    $("#insertSaveBtn").on("click", function () {
      console.log("insertValidation() : : :  : ", insertValidation());
      if (insertValidation()) {
        console.log("storageInsert() 실행");

        let form = $("#insertForm")[0];
        let formData = new FormData(form);
        console.log("formData", formData);

        // FormData의 key 확인
        for (let key of formData.keys()) {
          console.log(key);
        }

        for (let value of formData.values()) {
          console.log(value);
        }

        $.ajax({
          url: "/pms/project/insertStorage?${_csrf.parameterName}=${_csrf.token}",
          type: "POST",
          data: formData,
          enctype: "multipart/form-data",
          processData: false,
          contentType: false,
          cache: false,
          success: function (data) {
            console.log("성공");
            $("#storageModal").modal("hide");
            storageList(projNo, page, searchType, searchWord);
          },
          error: function (request) {
            console.log("code: " + request.status);
          },
        });
      }
    });
  };

  const insertBtn = () => {
    let insertStorageBtn = $("#insertStorageBtn");

    insertStorageBtn.on("click", function () {
      const insetModalBody = `

        <div class="modal-header">
          <h5 class="modal-title font-weight-normal" id="taskinsertModalLabel">자료 등록</h5>
        </div>
        <div class="modal-body">
          <form id="insertForm" enctype="multipart/form-data">
            <div class="container">
              <input type="hidden" id="stuNo" name="stuNo" value=\${stuNo} class="form-control task mb-1" />
              <input type="hidden" id="projNo" name="projNo" value=\${projNo} class="form-control task mb-1" />

              <div class="row mb-2">

                <div class="col-2 pe-0 mb-0">
                  <label class="necessary">
                  제목
                  </label>
                </div>

                <div class="col mb-0">
                  <input class="form-control pe-0 ps-0 task" id="storageTitle" type="text" name="strTitle" />
                </div>

            </div>

            <div class="row">
              <div class="col-md-2 pe-0 fs-6" id="fileSumCount">첨부 0개</div>
              <div class="col-md-2 ps-0 fs-6" id="fileSumSize">0KB</div>
              <div class="col-md-8 text-end pe-0">

                <label for="fileList" >
                  <img class="filter-orange size-m iconBtn" src="/resources/img/pms/upload.svg" />
                <label>
                <input type="file" multiple="multiple" id="fileList" name="fileList" class="form-control-file text-xs w-100 ps-5" style="display: none;"/>

                </div>
            </div>
            <div class="row">
              <div class='col-sm overflow-auto' id='fileZone'></div>
            </div>
          </form>
        </div>

        <div class="modal-footer">
          <button type="button" id="insertSaveBtn" class="btn bg msubBtn">등록</button>

          <button type="button" id="insertStorageBtn" class="btn btn-outline-secondary" data-bs-dismiss="modal">
            <i class="fas fa=search"></i>취소
          </button>
        </div>
      `;
      $("#storageModalBody").html(insetModalBody);

      $("#storageModal").modal("show");
      fileEvent();
      storageInsert();
      autoComplete();
    });
  };

  $("#storageModalBody").on("click", ".iconBtn.delete", function () {
    console.log("삭제하는 이미지");

    let atchFileSeq = $(this).prop("id");

    console.log("삭제하려는 이미지의 id : ", atchFileSeq);

    if (!atchFileSeq.includes("new")) {
      let prtn = `<input type='hidden' name='atchFileSeq' id='\${atchFileSeq}FileSeq' value='\${atchFileSeq}' />`;

      $("#insertForm").append(prtn);
    } else {
      let itemId = atchFileSeq + "Item";

      console.log("itemId : ", itemId);

      let item = $("#" + itemId).html();

      console.log("item : ", item);

      item = item.trim();

      let prtn = `<input type='hidden' name='noInsertItem' id='\${atchFileSeq}FileSeq' value='\${item}' />`;
      $("#insertForm").append(prtn);
    }

    // 삭제하려는 파일 num input요소에 넣음 위까지

    // 여기부턴 삭제하려는 파일 css변경
    let rowId = $(this).closest(".row").prop("id");

    console.log("rowId : " + rowId);

    $("#" + atchFileSeq + "row").css("background-color", "lightgray");
    // 여기까지

    // 파일 크기 재계산
    let fileSizeId = atchFileSeq + "fileSize";

    fileSize = $("#" + fileSizeId).html();

    fileSize = fileSize.trim();

    console.log("fileSize : " + fileSize);

    let fileSumCount = $("#fileSumCount").html();
    let fileSumSize = $("#fileSumSize").html();

    let fileSumSizeNum = parseFloat(fileSumSize);
    let fileSizeNum = parseFloat(fileSize);

    console.log("fileSumSize : " + fileSumSize);
    console.log("fileSize : " + fileSize);

    console.log("fileSumSizeNum : " + fileSumSizeNum);
    console.log("fileSizeNum : " + fileSizeNum);

    fileSumSizeNum = subFileSize(
      fileSize,
      fileSumSize,
      fileSumSizeNum,
      fileSizeNum
    );

    fileSumSize = kbToMb(fileSumSizeNum);

    $("#fileSumSize").html(fileSumSize);
    // 여기까지

    // 파일 갯수 바꾸는 곳
    console.log("fileSumCount : " + fileSumCount);

    let regex = /[^0-9]/g; // 숫자가 아닌 문자열을 선택하는 정규식
    fileSumCount = fileSumCount.replace(regex, ""); // 원래 문자열에서 숫자가 아닌 모든

    console.log("fileSumCount : " + fileSumCount);

    fileSumCount -= 1;

    fileSumCount = "첨부 " + fileSumCount + "개";

    $("#fileSumCount").html(fileSumCount);
    // 여기까지

    // 클래스 변경
    $(this).attr("src", "/resources/img/pms/corner-down-left.svg");

    $(this).removeClass("delete").addClass("restore");
  });

  $("#storageModalBody").on("click", ".iconBtn.restore", function () {
    console.log("복원하는 이미지");

    let atchFileSeq = $(this).prop("id");
    console.log("복원하려는 이미지의 id : ", atchFileSeq);
    // 클래스 변경
    $(this).attr("src", "/resources/img/pms/trash-2.svg");
    $(this).removeClass("restore").addClass("delete");

    // 배경 변경
    $("#" + atchFileSeq + "row").css("background-color", "white");

    let fileSizeId = atchFileSeq + "fileSize";

    fileSize = $("#" + fileSizeId).html();

    fileSize = fileSize.trim();

    console.log("fileSize : " + fileSize);

    let fileSumCount = $("#fileSumCount").html();
    let fileSumSize = $("#fileSumSize").html();

    let fileSumSizeNum = parseFloat(fileSumSize);
    let fileSizeNum = parseFloat(fileSize);

    console.log("fileSumSize : " + fileSumSize);
    console.log("fileSize : " + fileSize);

    console.log("fileSumSizeNum : " + fileSumSizeNum);
    console.log("fileSizeNum : " + fileSizeNum);

    fileSumSizeNum = sumFileSize(
      fileSize,
      fileSumSize,
      fileSumSizeNum,
      fileSizeNum
    );

    fileSumSize = kbToMb(fileSumSizeNum);

    $("#fileSumSize").html(fileSumSize);
    // 여기까지

    // 파일 갯수 바꾸는 곳
    console.log("fileSumCount : " + fileSumCount);

    let regex = /[^0-9]/g; // 숫자가 아닌 문자열을 선택하는 정규식
    fileSumCount = fileSumCount.replace(regex, ""); // 원래 문자열에서 숫자가 아닌 모든

    console.log("fileSumCount : " + fileSumCount);

    fileSumCount = parseInt(fileSumCount) + 1;

    fileSumCount = "첨부 " + fileSumCount + "개";

    $("#fileSumCount").html(fileSumCount);
    // 여기까지

    let deleteId = atchFileSeq + "FileSeq";

    $("input").remove("#" + deleteId);
  });

  let url = [];
  let filename = [];

  $("#storageModalBody").on("click", ".allSave", function () {
    console.log("전체저장");
    const fileZoneElement = document.getElementById("fileZone");
    const rows = fileZoneElement.querySelectorAll(".row");

    let idx = 0;
    for (const row of rows) {
      console.log("rows[" + idx + "] = ", row);
      idx++;
      fileDownLoad(row);
    }

    let zip = new JSZip();

    zipName = filename[0];
    let lastDotIndex = zipName.lastIndexOf(".");
    zipName = zipName.substring(0, lastDotIndex);

    for (let i = 0; i < idx; i++) {
      zip.file(filename[i], urlToPromise(url[i]), { binary: true });
    }
    console.log("url", url);
    console.log("filename", filename);
    zip.generateAsync({ type: "blob" }).then(function callback(blob) {
      saveAs(blob, zipName);
    });

    url = [];
    filename = [];
  });

  $("#storageModalBody").on("click", ".iconBtn.save", function () {
    let row = $(this).closest(".row");
    console.log("saveBtn", row);

    let filePathElement = row.find(".filePath");
    let fileTitleElement = row.find(".fileNm");

    let fileTitle = fileTitleElement.val();
    let filePath = filePathElement.val();

    let downloadLink = document.createElement("a");
    downloadLink.href = filePath;
    downloadLink.download = fileTitle;

    console.log(downloadLink);

    downloadLink.click();
  });

  const fileDownLoad = (row) => {
    let filePathElement = row.querySelector(".filePath");
    let fileTitleElement = row.querySelector(".fileNm");
    console.log(filePathElement);
    console.log(fileTitleElement);

    let fileTitle = fileTitleElement.value;
    let filePath = filePathElement.value;

    url.push(filePath);
    filename.push(fileTitle);
  };

  function urlToPromise(url) {
    return new Promise(function (resolve, reject) {
      JSZipUtils.getBinaryContent(url, function (err, data) {
        if (err) {
          reject(err);
        } else {
          resolve(data);
        }
      });
    });
  }

  $("#storageModalBody").on("click", "#updateBtn", function () {
    console.log("수정버튼");

    Swal.fire({
      title: "수정하시겠습니까?",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "확인",
      cancelButtonText: "취소",
    }).then((result) => {
      if (result.value) {
        const strNo = $("#strNo").val();

        let data = {
          strNo: strNo,
        };

        console.log(data);

        $.ajax({
          url: "/pms/project/StorageDetail",
          type: "GET",
          data: data,
          dataType: "json",
          success: function (res) {
            console.log(res);

            let fileNumber = res.atchFileList.length;
            let fileSizeSum = 0;
            let file = "";

            if (res.atchFileList[0].fileNm != null) {
              for (let i = 0; i < res.atchFileList.length; i++) {
                let byteToKilobyte = res.atchFileList[i].fileSize;
                fileSizeSum += byteToKilobyte;
                byteToKilobyte = byteToKbToMb(byteToKilobyte);

                fileName = res.atchFileList[i].fileNm;
                if (fileName.length > 23) {
                  fileName =
                    fileName.substring(0, 20) +
                    "..." +
                    res.atchFileList[i].fileExtn;
                }
                file += `
          <div class="row mt-2 mb-2" id="\${res.atchFileList[i].atchFileSeq}row">
              <div class="col-md-1">
                <img src="\${res.atchFileList[i].fileThumb}" class="avatar avatar-sm rounded-3 me-2"/>
              </div>

              <div class="col-md-8 pe-0 storageItem itemTitle" title="\${res.atchFileList[i].fileNm}">
                \${fileName}
                </div>
              <div class="col-md-2 ps-0 storageItem" id="\${res.atchFileList[i].atchFileSeq}fileSize">
                \${byteToKilobyte}
                </div>
              <div class="col-md-1 storageItem">
                  <img class="filter-orange size-m iconBtn delete" id="\${res.atchFileList[i].atchFileSeq}" src="/resources/img/pms/trash-2.svg"/>

              </div>

              </div>`;
              }
            }

            fileSizeSum = byteToKbToMb(fileSizeSum);

            let insetModalBody = `
          <div class="modal-header">
              <h5 class="modal-title font-weight-normal" id="taskUpdateModalLabel">
                자료 수정하기
              </h5>
            </div>
            <div class="modal-body">
              <form id="insertForm" enctype="multipart/form-data">
              <div class="container">
                <div class="row mb-2">
                    <h5><input class="form-control mb-0 pe-0 ps-0 task" type="text" name="strTitle" value="\${res.strTitle}"/></h5>
                    <p>\${res.strRegDt}</p>
                </div>
                `;

            //if (res.atchFileList[0].fileSize != 0) {
            insetModalBody += `
          <div class="row">
            <div class="col-md-2 pe-0 fs-6" id="fileSumCount" >

            </div>
            <div class="col-md-2 ps-0 fs-6" id="fileSumSize" >

            </div>

            <div class="col-md-8 text-end pe-0">

              <label for="fileList" >
                <img class="filter-orange size-m iconBtn" src="/resources/img/pms/upload.svg" />
              <label>
              <input type="file" multiple="multiple" id="fileList" name="fileList" class="form-control-file text-xs w-100 ps-5" style="display: none;"/>

            </div>

            </div>
              <div class="row">
            <div class='col-sm overflow-auto' id='fileZone'>
              \${file}
            </div>
            `;
            //}
            insetModalBody += `      </div> `;

            insetModalBody += `
                <input type="hidden" name="strNo" id="strNo" value="\${res.strNo}">
                <input type="hidden" name="atchFileNo" id="atchFileNo" value="\${res.atchFileNo}">


                </form>
                </div>
                <div class="modal-footer">
                  <button type="button" id="updateSaveBtn" class="btn bg msubBtn">
                      저장
                  </button>


                  <button
                    type="button"
                    id="UpdateStorageBtn"
                    class="btn btn-outline-secondary"
                    data-bs-dismiss="modal"
                  >
                    <i class="fas fa=search"></i>취소
                  </button>

                  <div>

                    </div>
                </div>
      `;
            $("#storageModalBody").html(insetModalBody);

            let fileSumCount = `첨부 \${fileNumber}개`;

            let fileSumSize = `\${fileSizeSum}`;

            $("#fileSumCount").html(fileSumCount);
            $("#fileSumSize").html(fileSumSize);

            $("#storageModal").modal("show");

            fileEvent();
          },
        });
      }
    });
  });

  $("#storageModalBody").on("click", "#updateSaveBtn", function () {
    console.log("storageInsert() 실행");

    let form = $("#insertForm")[0];
    let formData = new FormData(form);
    console.log("formData", formData);

    // FormData의 key 확인
    for (let key of formData.keys()) {
      console.log(key);
    }

    for (let value of formData.values()) {
      console.log(value);
    }
    console.log("안돌아감");

    $.ajax({
      url: "/pms/project/updateStorage?${_csrf.parameterName}=${_csrf.token}",
      type: "PUT",
      data: formData,
      enctype: "multipart/form-data",
      dataType: "text",
      processData: false,
      contentType: false,
      cache: false,
      success: function (data) {
        console.log(data);
        $("#storageModal").modal("hide");
        Swal.fire({
          icon: "success",
          title: "수정되었습니다.",
          showConfirmButton: false,
          timer: 1500,
        });
        storageList(projNo, page, searchType, searchWord);
      },
      error: function (request) {
        console.log("code: " + request.status);
      },
    });
  });

  $("#storageModalBody").on("click", "#deleteBtn", function () {
    console.log("삭제버튼");

    Swal.fire({
      title: "삭제하시겠습니까?",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "확인",
      cancelButtonText: "취소",
    }).then((result) => {
      if (result.value) {
        const strNo = $("#strNo").val();
        const atchFileNo = $("#atchFileNo").val();

        let data = {
          strNo: strNo,
          atchFileNo: atchFileNo,
        };

        $.ajax({
          url: "/pms/project/StorageDelete",
          data: JSON.stringify(data),
          type: "delete",
          dataType: "text",
          contentType: "application/json;charset=utf-8",
          beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
          },
          success: function (res) {
            console.log("삭제성공");
            $("#storageModal").modal("hide");
            Swal.fire({
              icon: "success",
              title: "삭제되었습니다.",
              showConfirmButton: false,
              timer: 1500,
            });
            storageList(projNo, page, searchType, searchWord);
          },
          error: function (request) {
            console.log("code: " + request.status);
          },
        });
      }
    });
  });

  $("#storageList").on("click", "tr", function () {
    let strNo = $(this).find(".strNo").val();

    console.log("strNo  " + strNo);
    let data = {
      strNo: strNo,
    };

    $.ajax({
      url: "/pms/project/StorageDetail",
      type: "GET",
      data: data,
      dataType: "json",
      success: function (res) {
        console.log(res);

        let fileNumber = res.atchFileList.length;
        let fileSizeSum = 0;
        let file = "";

        if (res.atchFileList[0].fileNm != null) {
          for (let i = 0; i < res.atchFileList.length; i++) {
            let fileName = res.atchFileList[i].fileNm;
            console.log("fileName.length : ", fileName.length);

            let byteToKilobyte = res.atchFileList[i].fileSize;

            fileSizeSum += byteToKilobyte;

            byteToKilobyte = byteToKbToMb(byteToKilobyte);

            if (fileName.length > 23) {
              fileName =
                fileName.substring(0, 20) +
                "..." +
                res.atchFileList[i].fileExtn;
            }

            file += `<div class="row mt-2 mb-2">
              <div class="col-md-1">
                <img src="\${res.atchFileList[i].fileThumb}" class="avatar avatar-sm rounded-3 me-2 imgSource"/>
                <input type="hidden" class="fileNm" value="\${res.atchFileList[i].fileNm}">
                <input type="hidden" class="filePath" value="\${res.atchFileList[i].filePath}">
                </div>

              <div class="col-md-8 pe-0 storageItem itemTitle" id="\${res.atchFileList[i].fileNm}.(\${i})">
                \${fileName}
                </div>
              <div class="col-md-2 ps-0 storageItem" id="\${res.atchFileList[i].atchFileSeq}byteToKilobyte">
                \${byteToKilobyte}
                </div>
              <div class="col-md-1 storageItem">
                  <img class="filter-orange size-m iconBtn save" id="\${res.atchFileList[i].atchFileSeq}" src="/resources/img/pms/download.svg"/>
                </div>

              </div>`;
          }

          fileSizeSum = byteToKbToMb(fileSizeSum);
        }

        let insetModalBody = `
          <div class="modal-header">
              <h5 class="modal-title font-weight-normal" id="taskinsertModalLabel">
                자료 상세보기
              </h5>
            </div>
            <div class="modal-body">

              <div class="container">
                <div class="row mb-2">
                    <h5 class="mb-0">\${res.strTitle}</h5>
                    <p>\${res.strRegDt}</p>
                </div>
                `;

        if (res.atchFileList[0].fileNm != null) {
          insetModalBody += `
          <div class="row">
              <div class="col-md-2 pe-0 fs-6">첨부 \${fileNumber}개</div>
              <div class="col-md-2 pe-0 ps-0 fs-6">\${fileSizeSum}</div>
              <div class="col-md-2 pe-0 ps-0 fs-6 allSave">모두저장</div>
            </div>
              <div class="row">
            <div class='col-sm overflow-auto' id='fileZone'>
              \${file}
            </div>
            `;
        }
        insetModalBody += `      </div> `;

        insetModalBody += `
                <input type="hidden" id="strNo" value="\${res.strNo}">
                <input type="hidden" id="atchFileNo" value="\${res.atchFileNo}">
                </div>
                <div class="modal-footer">
                  <button type="button" id="updateBtn" class="btn bg msubBtn">
                      수정
                  </button>

                  <button type="button" id="deleteBtn" class="btn bg msubBtn">
                      삭제
                  </button>

                  <button
                    type="button"
                    id="insertStorageBtn"
                    class="btn btn-outline-secondary"
                    data-bs-dismiss="modal"
                  >
                    <i class="fas fa=search"></i>취소
                  </button>

                  <div>

                    </div>
                </div>
      `;
        $("#storageModalBody").html(insetModalBody);

        $("#storageModal").modal("show");
      },
    });
  });

  const fileEvent = () => {
    console.log("const fileEvent2 = () => {  실행");
    const fileInput = document.getElementById("fileList");
    fileInput.addEventListener("change", setThumbnail);
  };

  let name = [];
  let originalName = [];
  let size = [];
  let extention = [];

  const extFile = (extName) => {
    const extensionMap = {
      xlsx: "s_xlsx.png",
      xls: "s_xlsx.png",
      xlsm: "s_xlsx.png",
      xltm: "s_xlsx.png",
      xlam: "s_xlsx.png",
      xlsb: "s_xlsx.png",
      xltx: "s_xlsx.png",
      docx: "s_docx.png",
      doc: "s_docx.png",
      htm: "s_htm.png",
      html: "s_htm.png",
      pdf: "s_pdf.png",
      hwp: "s_hwp.png",
      xml: "s_xml.png",
      zip: "s_zip.png",
      ppt: "s_ppt.png",
      pptx: "s_ppt.png",
    };

    const defaultImage = "s_etc.png";

    let src = "/resources/bbs/storage/";

    src += extensionMap[extName] || defaultImage;

    return src;
  };

  const setThumbnail = (event) => {
    let oldItem = document.querySelectorAll(".newItemRow");

    if (oldItem.length > 0) {
      let delSizeNum = 0;
      for (let i = 0; i < oldItem.length; i++) {
        oldItem[i].remove();
        delSizeNum += parseFloat(size[i]);
      }

      delSize = kbToMb(delSizeNum);
      delSizeNum = parseFloat(delSize);

      let curSize = $("#fileSumSize").html();
      let curSizeNum = parseFloat($("#fileSumSize").html());

      curSizeNum = subFileSize(delSize, curSize, curSizeNum, delSizeNum);

      curSizeNum = kbToMb(curSizeNum);

      $("#fileSumSize").html(curSizeNum);

      // 숫자 다시 넣기
      let fileOldSumCount = $("#fileSumCount").html();

      let regex = /[^0-9]/g; // 숫자가 아닌 문자열을 선택하는 정규식
      fileOldSumCount = fileOldSumCount.replace(regex, ""); // 원래 문자열에서 숫자가 아닌 모든

      fileNewSumCount = fileOldSumCount - oldItem.length;

      fileNewSumCount = "첨부 " + fileNewSumCount + "개";

      $("#fileSumCount").html(fileNewSumCount);
    }

    name = [];
    size = [];
    extentions = [];
    originalName = [];

    let newFileSize = 0;
    fileName = "";

    for (var image of event.target.files) {
      fileSize = byteToKbToMb(image.size);

      fileName = image.name;
      originalName.push(fileName);
      let lastDotIndex = fileName.lastIndexOf(".");
      let extention = fileName.substring(lastDotIndex + 1);

      if (fileName.length > 23) {
        fileName = fileName.substring(0, 20) + "..." + extention;
        console.log("fileName : : :", fileName);
      }

      extentions.push(extention);
      name.push(fileName);
      size.push(fileSize);
      newFileSize += fileSize;
    }

    // 파일 크기 재계산
    let idx = 0;
    for (var image of event.target.files) {
      fileSize = size[idx];

      console.log("fileSize : : : : ", fileSize);

      let fileSumSize = $("#fileSumSize").html();
      let fileSumSizeNum = parseFloat(fileSumSize);
      let fileSizeNum = parseFloat(fileSize);

      fileSumSizeNum = sumFileSize(
        fileSize,
        fileSumSize,
        fileSumSizeNum,
        fileSizeNum
      );
      fileSumSize = kbToMb(fileSumSizeNum);

      $("#fileSumSize").html(fileSumSize);
      // 여기까지
      idx += 1;
    }

    // 파일 갯수 바꾸는 곳
    let fileSumCount = $("#fileSumCount").html();

    let regex = /[^0-9]/g; // 숫자가 아닌 문자열을 선택하는 정규식
    fileSumCount = fileSumCount.replace(regex, ""); // 원래 문자열에서 숫자가 아닌 모든

    fileSumCount = parseInt(fileSumCount) + parseInt(idx);

    fileSumCount = "첨부 " + fileSumCount + "개";

    $("#fileSumCount").html(fileSumCount);

    let cnt = 0;

    for (var image of event.target.files) {
      var reader = new FileReader();

      reader.onload = function (event) {
        console.log("event : ", event);
        console.log("image : ", image);
        let src = "";

        if (
          !(
            extentions[cnt] === "png" ||
            extentions[cnt] === "jpg" ||
            extentions[cnt] === "jpeg" ||
            extentions[cnt] === "gif"
          )
        ) {
          src = extFile(extentions[cnt]);
        } else {
          src = event.target.result;
        }

        fileSize = byteToKbToMb(image.size);

        let file = "";
        file += `<div class="row mt-2 mb-2 newItemRow" id="new\${cnt}row">`;

        file += `
          <div class="col-md-1">
            <img src="\${src}" class="avatar avatar-sm rounded-3 me-2"/>
          </div>

          <div class="col-md-8 pe-0 storageItem itemTitle" title="\${originalName[cnt]}" id="new\${cnt}Item">
            \${name[cnt]}
            </div>
          <div class="col-sm-2 ps-0 storageItem" id="new\${cnt}fileSize">
            \${size[cnt]}
            </div>
          <div class="col-md-1 storageItem">
              <img class="filter-orange size-m iconBtn delete" id="new\${cnt}" src="/resources/img/pms/trash-2.svg"/>
          </div>
          </div>`;
        //console.log("file", file);
        $("#fileZone").append(file);
        cnt += 1;
      };

      reader.readAsDataURL(image);
    }
    console.log(cnt);
  };

  const autoComplete = () => {
    $(document).keydown(function (event) {
      if (event.keyCode == "220") {
        storageAutoComplete();
      }
    });
  };

  const storageAutoComplete = () => {
    document.getElementById("storageTitle").value = "프로세스 흐름도 첨부파일"; // 나중에 고쳐야함
  };

  const insertValidation = () => {
    const title = document.getElementById("storageTitle").value;

    // Validation logic for each field
    if (title.trim() === "") {
      Swal.fire({
        icon: "error",
        title: "제목은 필수입니다.",
      });
      return false;
    }

    if (title.length >= 20 && title.length <= 3) {
      Swal.fire({
        icon: "error",
        title: "제목은 3자 이상, 20자 이하만 가능합니다.",
      });
      return false;
    }

    return true;
  };
</script>
