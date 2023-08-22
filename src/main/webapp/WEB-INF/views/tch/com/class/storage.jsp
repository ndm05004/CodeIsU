<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <style>
        .deleteBtn, .fileNm {
            cursor: pointer;
        }
        .fileNm:hover {
            color: #3246C4;; /* 커서가 요소 위에 있을 때 변경될 텍스트 색상 */
        }
    </style>
    <div class="card">
        <div class="card-body">
            <div class="row mb-5">
                <div class="text-end">
                    <label for="uploadBtn" class=""><i data-feather="upload" class="feather-icon"></i></label>
                    <input type="file" a class="" id="uploadBtn" multiple style="display : none">
                </div>
            </div>
            <div>
                <table class="table">
                    <thead>
                        <tr class="table-light">
                            <th scope="col">이름</th>
                            <th scope="col" class="text-center">날짜</th>
                            <th scope="col">유형</th>
                            <th scope="col">크기</th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody id="mytbody">
                    </tbody>
                </table>
            </div>

        </div>
    </div>
<script>
    var sbjctCd = "${sbjctCd}";
    // 파일 등록
    var uploadBtn = document.querySelector("#uploadBtn");
    uploadBtn.addEventListener("change", function () {
        let formData = new FormData();
        const files = uploadBtn.files;
        console.log(files);
        for (var i = 0; i < files.length; i++) {
            var file = files[i];
            formData.append("fileList", file);
        };
        formData.append("fileTbNm", sbjctCd);

        $.ajax({
            url: '/tch/class/storage/insert',
            method: 'post',
            data: formData,
            dataType: 'text',
            processData: false,
            contentType: false,
            beforeSend: function (xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function (res) {
                console.log(res)
                // 리스트 다시 출력
                storageList()
            },
            error: function (xhr, status, error) {
                // 요청이 실패했을 때 처리할 코드 작성
                alert("제발");
            }
        });
    })
    // 파일 리스트 출력
    storageList()
    function storageList() {
        $.ajax({
            url: '/tch/class/storage/selectlist?sbjctCd=' + sbjctCd,
            method: 'get',
            dataType: 'json',
            contentType: 'text',
            beforeSend: function (xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function (res) {
                feather.replace();
                console.log("결과", res);
                atchFileStr = "";
                for (let i = 0; i < res.length; i++) {
                    var atchFile = res[i];
                    let size = atchFile.fileSize;
                    let fileSize = "";
                    if (size > 1024) {
                        size = size / 1024; // KB로 변환
                        fileSize = size.toFixed(0) + "MB"; // 소수점 두 자리까지 표시
                    } else {
                        fileSize = size + "KB";
                    }
                    atchFileStr += `
                    <tr>
                        <td class="col-6 fileNm" data-filePath="\${atchFile.filePath}">\${atchFile.fileNm}</td>
                        <td class="col-2 text-center">\${atchFile.fileBengDt}</td>
                        <td class="col-2">\${atchFile.fileExtn}</td>
                        <td class="col-1">\${fileSize}</td>
                        <td class="col-1 deleteBtn text-danger text-end" data-atchFileNo="\${atchFile.atchFileNo}" data-atchFileSeq="\${atchFile.atchFileSeq}" data-filePath="\${atchFile.filePath}">
                            <i data-feather="trash-2" class="feather-icon"></i>
                        </td>
                    </tr>
                `
                }
                document.querySelector("#mytbody").innerHTML = atchFileStr;
                feather.replace();
            },
            error: function (xhr, status, error) {
                // 요청이 실패했을 때 처리할 코드 작성
                alert("제발");
            }
        });
    }

    // 파일 다운로드
    $(document).on("click", ".fileNm", function() {
        let fileTitle = $(this).text().trim();
        let filePath = $(this).attr("data-filePath");

        downloadFile(filePath, fileTitle);
    });
    // 파일 다운로드 함수
    function downloadFile(filePath, fileTitle) {
        // 파일 다운로드 엔드포인트에 요청 보내기
        const xhr = new XMLHttpRequest();
        xhr.open("GET", filePath, true);
        xhr.responseType = "blob"; 
        xhr.onload = function() {
            if (xhr.status === 200) {
                // 응답으로 받은 blob 데이터를 파일로 변환하고 다운로드
                const blob = new Blob([xhr.response], { type: "application/octet-stream" });
                const url = URL.createObjectURL(blob);
                const link = document.createElement("a");
                link.href = url;
                link.download = fileTitle;
                link.click();
            }
        };
        xhr.send();
    }

    // 파일 삭제
    $(document).on("click", ".deleteBtn", function() {
        Swal.fire({
            title: '파일 삭제',
            text: "정말로 삭제하시겠습니까?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '확인',
            cancelButtonText: '취소'
            }).then((result) => {
            if (result.isConfirmed) {
                let atchFileNo = $(this).attr("data-atchFileNo");
                let atchFileSeq = $(this).attr("data-atchFileSeq");
                let filePath = $(this).attr("data-filePath");
                let data = {
                    "atchFileNo" : atchFileNo
                    , "atchFileSeq" : atchFileSeq
                    , "filePath" : filePath
                }
                $.ajax({
                    url: '/tch/class/storage/delete',
                    method: 'post',
                    data: JSON.stringify(data),
                    dataType: 'text',
                    contentType: 'application/json; charset=UTF-8',
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                    },
                    success: function (res) {
                        console.log(res)
                        Swal.fire(
                        '삭제완료',
                        '파일 삭제가 완료되었습니다',
                        'success'
                        ).then((result) => {
                            // 리스트 다시 출력
                            storageList()
                        })
                    },
                    error: function (xhr, status, error) {
                        // 요청이 실패했을 때 처리할 코드 작성
                        alert("제발");
                    }
                });
            }
		})
        
    });
</script>