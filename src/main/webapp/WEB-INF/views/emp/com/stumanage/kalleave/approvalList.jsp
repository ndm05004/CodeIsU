<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>조퇴/외출 승인 목록 페이지</h1>
<div  class="row">
	<table class="table mTb">
		<thead class="table-dark">
			<tr>
				<th style="text-align: center;" colspan="3" class="p-2">조퇴/외출 허가 목록</th>
			</tr>
			<tr>
				<th class="p-2">분류</th>
				<th class="p-2">신청일</th>
				<th class="p-2">신청자</th>
			</tr>
		</thead>
		<tbody id="approBody">
		</tbody>
	</table>
</div>
<script>
$(function(){
	attdanapproval();
})

function attdanapproval(){
	$.ajax({
		url : "/emp/stuman/attdanapproval",
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
							<td class="p-2">\${res[i].cdNm}</td>
							<td class="p-2">\${res[i].attdanWriteDt.substring(0, 10)}</td>
							<td class="p-2">\${res[i].userNm}</td>
						</tr>
						`
					}
				}else{
					for(let i=0; i<4; i++){

						str += `
						<tr>
							<td class="p-2">\${res[i].cdNm}</td>
							<td class="p-2">\${res[i].attdanWriteDt.substring(0, 10)}</td>
							<td class="p-2">\${res[i].userNm}</td>
						</tr>
						`
					}
				}
			}

			$("#approBody").html(str);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		}
	})
}
</script>