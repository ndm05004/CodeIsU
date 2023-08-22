
<div class="modal-header">
	<h5 class="modal-title font-weight-normal" id="taskinsertModalLabel">자료 등록</h5>
</div>
<div class="modal-body">
	<form id="insertForm" enctype="multipart/form-data">

		<input type="hidden" id="stuNo" name="stuNo" value=\${stuNo} class="form-control task mb-1" /> <input type="hidden" id="projNo" name="projNo" value=\${projNo} class="form-control task mb-1" />

		<div class="row">
			<h5>
				<input class="form-control pe-0 ps-0 task" type="text" name="strTitle" />
			</h5>
			<hr style="border: solid 1px black;">
		</div>

		<div class="row">
			<div class="col-md-2 pe-0" id="fileSumCount"></div>
			<div class="col-md-2 ps-0" id="fileSumSize"></div>
			<div class="col-md">
				<input type="file" multiple="multiple" id="fileList" name="fileList" class="form-control-file text-xs w-100 ps-5" />
			</div>
		</div>
		<div class="row">
			<div class='col-sm overflow-auto' id='fileZone'></div>
		</div>
		<div class="row">
			<div class="col-sm">
				<div>
					<input type="text" class="form-control pe-0 ps-0 task" name="strCn">
				</div>
			</div>
		</div>

	</form>
</div>

<div class="modal-footer">
	<button type="button" id="insertSaveBtn" class="btn bg msubBtn">등록</button>

	<button type="button" id="insertStorageBtn" class="btn btn-outline-secondary" data-bs-dismiss="modal">
		<i class="fas fa=search"></i>취소
	</button>
</div>
