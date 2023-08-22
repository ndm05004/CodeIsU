<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
    .download {
        cursor: pointer;
    }
    .fileNm:hover {
        color: #3246C4;; /* 커서가 요소 위에 있을 때 변경될 텍스트 색상 */
    }
    .menu_title {
      margin: 3px 0 15px;
      padding: 0 0 0 13px;
      background: url(/resources/img/h4.png) no-repeat 0 4px;
      font-size: 22px;
      font-weight: 700;
      color: #000;
    }
</style>
<div class="card">
    <div class="card-body">
    	<h4 class="menu_title">${temp_title}</h4>
        <div>
            <table class="table table-hover">
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
                    <c:forEach items="${fileList}" var="atchFile">
                        <c:set var="sizeNum" value="${atchFile.fileSize}"/>
                        <c:set var="sizeStr" value=""/>
                        <c:if test="${sizeNum ge 1024}">
                            <c:set var="sizeNum" value="${sizeNum / 1024}"/>
                            <c:set var="sizeStr" value="MB"/>
                        </c:if>
                        <c:if test="${sizeNum lt 1024}">
                            <c:set var="sizeNum" value="${sizeNum}"/>
                            <c:set var="sizeStr" value="KB"/>
                        </c:if>
                         <fmt:formatNumber type="number" maxFractionDigits="0"  value="${sizeNum}" var="num"/>
                        <tr class="download" data-filePath="${atchFile.filePath}">
                            <td class="col-6">${atchFile.fileNm}</td>
                            <td class="col-2 text-center">${atchFile.fileBengDt}</td>
                            <td class="col-2">${atchFile.fileExtn}</td>
                            <!-- <td class="col-2">${num}${sizeStr}</td> -->
                            <td class="col-1">${num}${sizeStr}</td>
                            <td class="col-1 text-primery text-end">
                                <i data-feather="download" class="feather-icon"></i>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

    </div>
</div>
<script>
    var sbjctCd = "${sbjctCd}";

    // 파일 다운로드
    $(document).on("click", ".download", function() {
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


</script>