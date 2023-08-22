<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div class="">
  <div class="row card-columns">
    <c:forEach items="${classroomList}" var="myclass">
      <div class="col-sm-6 col-lg-4">
        <div class="card myClassCard" data-sbjctCd = "${myclass.sbjctCd}">
          <div class="card-body">
            <h4 class="card-title">${myclass.sbjctNm}</h4>
            <p class="card-text">${myclass.userNm}</p>
            <p class="card-text">
              <small class="text-muted">${myclass.sbjctBgng} ~ ${myclass.sbjctDdlb} ${myclass.scduHr}</small>
            </p>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
</div>
<script>
  // 카드를 클릭했을 때
  $(document).on("click", ".myClassCard", function(e) {
    var sbjctCd = $(this).attr("data-sbjctCd");
    console.log(sbjctCd);
    location.href = "/stu/classroom/assign?sbjctCd=" + sbjctCd;
  })
</script>

