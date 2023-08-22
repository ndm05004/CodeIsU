<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="row">
    <div class="col-4">
        <div id="datepicker"></div>
    </div>
    <div class="col-8">
        <table class="table">
            <thead>
              <tr class="table-light">
                <th scope="col">이름</th>
                <th scope="col">입실</th>
                <th scope="col">퇴실</th>
                <th scope="col">출결상태</th>
              </tr>
            </thead>
            <tbody id="mytbody">
            </tbody>
        </table>
    </div>
</div>
<script>
    datepickerSet()
    onSelect: function datepickerSet(){
        $("#datepicker").datepicker({
            dateFormat : "yy-mm-dd",
            showMonthAfterYear:true,
            yearSuffix: "년",
            dayNames : ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
            dayNamesMin : ['일','월','화','수','목','금','토'],
            monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12'],
            monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            maxDate: 0,
            onSelect: function(dateText, datePicker) {

                var dateInfo = {
                    "attdDt" : dateText
                }
                startAttdTable(dateInfo)
            }
        });
    }
    function getFormattedDate() {
        var today = new Date();
        var yyyy = today.getFullYear();
        var mm = today.getMonth() + 1;
        var dd = today.getDate();

        if (mm < 10) {
            mm = "0" + mm;
        }
        if (dd < 10) {
            dd = "0" + dd;
        }
        return yyyy + "-" + mm + "-" + dd;
    }

    // 첫 화면 로딩
    // 오늘 날짜 받아오기
    var todayDate = getFormattedDate();
    let mydata = {
        "attdDt" : todayDate
    }
    // 화면에 데이터 뿌리기
    startAttdTable(mydata);

    function startAttdTable(data){
        console.log(data);
        $.ajax({
            url : "/tch/dam/attdan/attdanList",
            type : "get",
            data : data,
            dataType : "json",
            success : function(res){
                console.log(res);
                var str = "";

                if(res.length == 0){
                    str += `
                    <tr>
                        <td colspan="4" class="p-2">조회할 정보가 없습니다.</td>
                    </tr>
                    `
                }else{
                    for(let i=0; i<res.length; i++){
                        str += `
                        <tr class="bTr">
                        <input type="hidden" class="stuNo" value="\${res[i].stuNo}" />
                            <td class="stuName p-2">\${res[i].userNm}</td>
                            <td class="p-2">\${res[i].attdAbmiYmd}</td>
                            <td class="p-2">\${res[i].attdLeaveYmd}</td>
                            <td class="attdCheck p-2">\${res[i].cdNm}</td>
                        </tr>
                        `
                    }
                }

                $("#mytbody").html(str);

            },
            error : function(xhr){
                alert("상태 : " + xhr.status);
            }
        })
    }

</script>