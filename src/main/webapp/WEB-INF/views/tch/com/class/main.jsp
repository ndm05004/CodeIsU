<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div class="">
  <div class="row card-columns">
    <h4>수업중</h4>
    <c:forEach items="${classList}" var="myclass">
      <div class="col-sm-6 col-lg-6">
        <div class="card myClassCard" data-sbjctCd = "${myclass.sbjctCd}" style="cursor: pointer;">
          <div class="card-body">
            <h4 class="card-title">${myclass.sbjctNm}</h4>
            <p class="card-text">${myclass.lectureRoomNm} ${myclass.scduHr}</p>
            <p class="card-text">
              <small class="text-muted">${myclass.sbjctBgng} ~ ${myclass.sbjctDdlb}</small>
            </p>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
  <h4>수업완료</h4>
  <div class="lastClassContainer card overflow-auto border" style="height: 500px;">
    <table class="table table-hover m-0 " >
      <thead>
        <tr>
          <th scope="col">수업명</th>
          <th scope="col">강의실</th>
          <th scope="col">수업시간</th>
          <th scope="col">수업날짜</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${lastClassList}" var="myLastClass">
          <tr class="myClassCard" data-sbjctCd = "${myLastClass.sbjctCd}">
            <td>${myLastClass.sbjctNm}</td>
            <td>${myLastClass.lectureRoomNm}</td>
            <td>${myLastClass.scduHr}</td>
            <td>${myLastClass.sbjctBgng} ~ ${myLastClass.sbjctDdlb}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>
<script>
  // 카드를 클릭했을 때
  $(document).on("click", ".myClassCard", function(e) {
    var sbjctCd = $(this).attr("data-sbjctCd");
    console.log(sbjctCd);
    location.href = "/tch/class/asmt?sbjctCd=" + sbjctCd;

  })
</script>

