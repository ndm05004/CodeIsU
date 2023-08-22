<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
#footDiv{
	margin-top: 20px;
	text-align: right;
}

.input-group-text{
	width: 70px;
}

#cnDiv{
	height: 420px;
	padding: 10px;
}
</style>
<div class="row">
	<div class="col-12">
		<div class="card">
			<div class="card-body">
				<div class="row" style="text-align: center;">
					<h1>${hntcVO.hntcNm }</h1>
				</div>
				<div class="row" style="height: 80px">
					<div class="col">
						<div class="row">
							<div class="col-4" style="padding: 0;">
								<div class="input-group">
									<label class="input-group-text">분류</label>
									<input type="text" class="form-control" value="공지사항">
								</div>
							</div>

							<div class="col-4" style="padding: 0;">
								<div class="input-group">
									<label class="input-group-text">등록일</label>
									<input type="text" class="form-control" value="${hntcVO.hntcDt }">
								</div>
							</div>

							<div class="col-4" style="padding: 0;">
								<div class="input-group">
									<label class="input-group-text">조회수</label>
									<input type="text" class="form-control" value="${hntcVO.checkNo }">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col" style="padding: 0;;">
								<div class="input-group">
									<label class="input-group-text">작성자</label>
									<input type="text" class="form-control" value="${hntcVO.userNm }">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="cnDiv">
					${hntcVO.hntcCn }
				</div>
				<div id="footDiv">
					<button id="listBtn" class="btn btn-secondary">목록</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function(){
	var listBtn = $("#listBtn");


	listBtn.on("click", function(){
		location.href = "/stu/notice";
	});
})

</script>