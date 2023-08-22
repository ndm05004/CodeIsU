<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>조퇴/외출 전체 목록</h1>
<div id="mainCont">
	<div class="col-12">
		<table class="table mTb">
			<thead class="table-dark">
				<tr>
					<th style="text-align: center;" colspan="4" class="p-2">조퇴/외출 전체 목록</th>
				</tr>
				<tr>
					<th class="p-2">분류</th>
					<th class="p-2">작성일</th>
					<th class="p-2">신청일</th>
					<th class="p-2">신청자</th>
				</tr>
			</thead>
			<tbody id="allListBody">
			</tbody>
		</table>
	</div>
</div>

<script>
$(function(){
	attdanAllList();

})

function attdanAllList(){
	$.ajax({
		url : "/emp/stuman/attdanAllList",
		type : "get",
		dataType : "json",
		success : function(res){
			str = "";

			if(res.length == 0){
				str += `
				<tr>
					<td colspan="3" class="p-2">조회할 정보가 없습니다.</td>
				</tr>
				`
			}else{
				if(res.length < 4){
					for(let i=0; i<res.length; i++){

						str += `
						<tr>
						/* 번호로 받아서 업데이트 */
							<input type="hidden" id="attdanCn" value="\${res[i].attdanCn}"/>
							<input type="hidden" id="attdanNo" value="\${res[i].attdanNo}"/>
							<input type="hidden" id="attdanBgng" value="\${res[i].attdanBgng}"/>
							<input type="hidden" id="attdanDdlb" value="\${res[i].attdanDdlb}"/>
							<td class="p-2">\${res[i].cdNm}</td>
							<td class="p-2">\${res[i].attdanWriteDt.substring(0, 10)}</td>
							<td class="p-2">\${res[i].attdanDt}</td>
							<td class="p-2">\${res[i].userNm}</td>
						</tr>
						`
					}
				}else{
					for(let i=0; i<4; i++){

						str += `
						<tr>
							/* 번호로 받아서 업데이트 */
							<input type="hidden" id="attdanCn" value="\${res[i].attdanCn}"/>
							<input type="hidden" id="attdanNo" value="\${res[i].attdanNo}"/>
							<input type="hidden" id="attdanBgng" value="\${res[i].attdanBgng}"/>
							<input type="hidden" id="attdanDdlb" value="\${res[i].attdanDdlb}"/>
							<td class="p-2">\${res[i].cdNm}</td>
							<td class="p-2">\${res[i].attdanWriteDt.substring(0, 10)}</td>
							<td class="p-2">\${res[i].attdanDt}</td>
							<td class="p-2">\${res[i].userNm}</td>
						</tr>
						`
					}
				}
			}

			$("#allListBody").html(str);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}
</script>