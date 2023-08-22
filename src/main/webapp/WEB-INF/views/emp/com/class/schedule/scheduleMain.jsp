<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style type="text/css">
#firstBox{
	text-align: left;
}
/* 일요일 날짜: 빨간색 */
.fc-day-sun a {
    color: red;
}

.fc-day-mon a {
    color: black;
}

.fc-day-tue a {
    color: black;
}

.fc-day-wed a {
    color: black;
}

.fc-day-thu a {
    color: black;
}

.fc-day-fri a {
    color: black;
}

/* 토요일 날짜: 파란색 */
.fc-day-sat a {
    color: blue;
}

.fc-event-title-container{
	height: 10px;
	display: flex;
	justify-content: center; /* 수평 가운데 정렬 */
	align-items: center; /* 수직 가운데 정렬 */
}
</style>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
<div id="firstBox">
</div>
<div id='calendar'>
</div>

<!--
	달력이 정상적으로 뜰 때 함수 실행이 잘 되지 않음
	하지만 달력이 정상적으로 뜨지 않으면 함수가 정상적으로 실행함
	정상적으로 실행할 때도 뭔가 이상하게 움직임
 -->

<script>
mainSchedule();

function mainSchedule(){

	$.ajax({
		url : "/emp/class/svlfList",
		type : "get",
		dataType : "json",
		success : function(res){

			var str = "";

			str += `
					<label class="form-label" style="display: inline;">연수과정 : </label>
					<select id="svlfNo" name="svlfNo" class="form-select" style="display: inline; width:200px;">
					<option value = "empty">-- 선택하세요 --</option>`

					for(let i=0; i<res.length; i++){
						str += `
							<option value="\${res[i].svlfNo}">\${res[i].svlfNm}</option>
						`
					}

			str +=`
				</select>
			`

			$("#firstBox").html(str);
			setTimeout(() => {
				getCalander();
			}, 100);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function upCalander(data){

	$.ajax({
		url : "/emp/class/sbjctInfo",
		type : "get",
		data : data,
		dataType : "json",
		success : function(res){

			var calendarEl = document.getElementById('calendar');

			var events = [];
			for(let i=0; i<res.length; i++){

				let scdule = "("+res[i].scduHr+")";
				let titleName = res[i].sbjctNm + scdule;

				let endDate = new Date(res[i].sbjctDdlb);
		        endDate.setDate(endDate.getDate() + 1);
		        endDate = endDate.toISOString().split('T')[0];

				events.push({
					title : titleName,
					start : res[i].sbjctBgng,
					end : endDate,
					backgroundColor : "#008000",
					sortIdx: i
				});
			}

			var calendar = new FullCalendar.Calendar(calendarEl, {
				locale: "ko",
				initialView : 'dayGridMonth',
				events : events,
				headerToolbar : {
					left : 'prev,next', //
					center : 'title',
					right : 'dayGridMonth,dayGridWeek,dayGridDay'
				},
				eventOrder: 'sortIdx'

			});
			//달력이 요소 내부에 있고 해당 요소의 너비가 동적으로 변경되었을 때 크기를 재조정.
			//calendar.updateSize()
			calendar.render();
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}

function getCalander(){

	var calendarEl = document.getElementById('calendar');

	var calendar = new FullCalendar.Calendar(calendarEl, {
		locale: "ko",
		initialView : 'dayGridMonth',
		/* events : [ {
			title : '스프링 오전',
			start : '2023-07-01',
			end : '2023-07-21'
		}, {
			title : '데이터 베이스 오후',
			start : '2023-07-01',
			end : '2023-07-18'
		} ],
 */		headerToolbar : {
			left : 'prev,next', //
			center : 'title',
			right : 'dayGridMonth,dayGridWeek,dayGridDay'
		},

	});
	//달력이 요소 내부에 있고 해당 요소의 너비가 동적으로 변경되었을 때 크기를 재조정.
	//calendar.updateSize()
	calendar.render();
}

$(function(){

	$("#svlfNo").on("change", function(){

		var optionValue = this.value;

		if(optionValue != "empty"){
			var data = {
				"svlfNo" : optionValue
			}

			upCalander(data);
		}else{
			getCalander();
		}
	})

})
</script>
