<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    .form-check-input{
        margin-top: 0.6em;
    }

</style>
<div class="card">
    <div class="card-body">
        <input type="hidden" name="asmtNo" id="asmtNo" value="${asmtNo}">
        <div class="input-group mb-2">
            <span class="input-group-text" id="asmtDdlnLabel" style="width: 85px;">마감기한</span>
            <input type="datetime-local" id="asmtDdln" class="form-control" value="2008-05-13T22:33:00" min = "" aria-describedby="asmtDdlnLabel">
        </div>
        <div class="input-group mb-2">
            <span class="input-group-text" id="asmtTtlLabel" style="width: 85px;">제목</span>
            <input type="text" id="asmtTtl" name="example-input-large" class="form-control form-control-lg font-weight-bold" placeholder="과제 제목" maxlength="100" aria-describedby="asmtTtlLabel">
        </div>
        <div class="input-group mb-4">
            <span class="input-group-text" id="asmtExplnLabel" style="width: 85px;">내용</span>
            <textarea id="asmtExpln" rows="3" class="form-control font-weight-light" placeholder="과제 내용" aria-describedby="asmtExplnLabel"></textarea>
        </div>
        <!-- 문제 card -->
        <div id="asmtContainer">
        </div>
        <div class="d-grid gap-2">
            <button class="btn btn-outline-primary" type="button" id="plusBtn"><i data-feather="plus" class="feather-icon"></i></button>
            <button class="btn btn-primary" type="button" id="submitBtn">완료</button>
        </div>

    </div>

</div>

<script>
    var asmtNo = document.querySelector("#asmtNo").value;
    feather.replace();
    // 오늘 날짜 삽입
    var currentDate = new Date(); // 현재 날짜와 시간 가져오기
    var year = currentDate.getFullYear(); //년
    var month = currentDate.getMonth() + 1; // 월
    var date = currentDate.getDate(); // 일
    var hours = currentDate.getHours(); // 시
    var minutes = currentDate.getMinutes(); // 분

    // 한 자리 수인 경우 앞에 0을 붙여 두 자리로 만들기
    var formattedMonth = month < 10 ? "0" + month : month;
    var formattedDate = date < 10 ? "0" + date : date;
    var formattedHours = hours < 10 ? "0" + hours : hours;
    var formattedMinutes = minutes < 10 ? "0" + minutes : minutes;
    var currDt = year + "-" + formattedMonth + "-" + formattedDate + " " + formattedHours + ":" + formattedMinutes; // 오늘날짜 + 시간

    document.querySelector("#asmtDdln").value = currDt;
    document.querySelector("#asmtDdln").min = currDt;


    // 카드 컨테이너(카드가 추가될 div)
    var asmtContainer = document.querySelector("#asmtContainer");
    var imgiconNum = 0;



    // 객관식/주관식에 따른 문제폼 생성
    // 처음 화면
    var updateCd = "${updateCd}";
    console.log("updateCd", updateCd);
    if(updateCd == 'Y'){
        console.log("체킁" + document.querySelector("#asmtNo").value)
        asmtVo()

    } else {
        document.querySelector("#asmtContainer").innerHTML = cardStr();
    }
    
    $(document).on("change", ".qstCode", function(e) {
        var qstCodeValue = this.value;
        var cardBody = this.closest(".card-body"); // 상위 요소 찾기
        var asmtcardDtl = cardBody.querySelector(".asmtcardDtl");
        console.log(qstCodeValue);
        console.log(asmtcardDtl);
        if (qstCodeValue === "M") {
            // 객관식이라면
            // 주관식 옵션의 selected 속성 제거
            cardBody.querySelector(".sOpdion").removeAttribute("selected");
            // 객관식 옵션에 selected 속성 추가
            cardBody.querySelector(".mOpdion").setAttribute("selected", true);
            var mStr = asmtcardDtlMStr();
            asmtcardDtl.innerHTML = mStr;
        } else {
            // 주관식이라면
            cardBody.querySelector(".mOpdion").removeAttribute("selected");
            cardBody.querySelector(".sOpdion").setAttribute("selected", true);

            var sStr = asmtcardDtlSStr();
            asmtcardDtl.innerHTML = sStr;
        }
    });

    function asmtcardDtlSStr(){
        let sStr = ""
        sStr += `<div class="row align-items-center">`;
        sStr += `    <div class="col-1">답</div>`;
        sStr += `    <div class="col-9"><input type="text" class="form-control font-weight-normal border-0 rounded-0 shadow-none border-bottom border-dark qstnAns length" placeholder="답"></div>`;
        sStr += `    <div class="col-2"></div>`;
        sStr += `</div>`;
        return sStr;
    }

    function asmtcardDtlMStr(){
        let mStr = ""
        mStr += `<div class="form-check mb-2">`;
        mStr += `    <input class="form-check-input" type="radio" name="qstDtlOptions\${imgiconNum}" value="1">`;
        mStr += `    <input type="text" class="form-control font-weight-normal qstDtlCn length" placeholder="답안1">`;
        mStr += `</div>`;
        mStr += `<div class="form-check mb-2">`;
        mStr += `    <input class="form-check-input" type="radio" name="qstDtlOptions\${imgiconNum}" value="2">`;
        mStr += `    <input type="text" class="form-control font-weight-normal qstDtlCn length" placeholder="답안2">`;
        mStr += `</div>`;
        mStr += `<div class="form-check mb-2">`;
        mStr += `    <input class="form-check-input" type="radio" name="qstDtlOptions\${imgiconNum}" value="3">`;
        mStr += `    <input type="text" class="form-control font-weight-normal qstDtlCn length" placeholder="답안3">`;
        mStr += `</div>`;
        mStr += `<div class="form-check mb-2">`;
        mStr += `    <input class="form-check-input" type="radio" name="qstDtlOptions\${imgiconNum}" value="4">`;
        mStr += `    <input type="text" class="form-control font-weight-normal qstDtlCn length" placeholder="답안4">`;
        mStr += `</div>`;
        mStr += `<div class="form-check">`;
        mStr += `    <input class="form-check-input" type="radio" name="qstDtlOptions\${imgiconNum}" value="5">`;
        mStr += `    <input type="text" class="form-control font-weight-normal qstDtlCn length" placeholder="답안5">`;
        mStr += `</div>`;
        return mStr;
    }

    function cardStr(){
        let cardStr = ""
        cardStr += `<div class="card qstCard" data-qstNo = "" data-qstYn = "">`;
        cardStr += `    <div class="card-body collapse show">`;
        cardStr += `        <div class="row mb-4">`;
        cardStr += `            <div class="col-2">`;
        cardStr += `                <select class="form-select mr-sm-2 qstCode">`;
        cardStr += `                    <option selected value="M" class="mOpdion">객관식</option>`;
        cardStr += `                    <option value="S" class="sOpdion">주관식</option>`;
        cardStr += `                </select>`;
        cardStr += `            </div>`;
        cardStr += `            <div class="col-8"></div>`;
        cardStr += `            <div class="col-2 text-end">`;
        cardStr += `                <i data-feather="copy" class="feather-icon copyBtn"></i>`;
        cardStr += `                &nbsp;&nbsp;`;
        cardStr += `                <i data-feather="trash-2" class="feather-icon deleteBtn"></i>`;
        cardStr += `            </div>`;
        cardStr += `        </div>`;
        cardStr += `        <div class="asmt">`;
        cardStr += `            <div class="row mb-3 qstTitle">`;
        cardStr += `                <div class="col-10"><input type="text" class="form-control font-weight-normal qstCn length" placeholder="질문"></div>`;
        cardStr += `                <div class="col-2 text-end">`;
        cardStr += `                    <label for="imgicon\${imgiconNum}" class="filelabel"><i data-feather="image" class="feather-icon"></i></label>`;
        cardStr += `                    <input type="file"a class="file-upload myfile fileSelector" data-no="n\${imgiconNum}" id="imgicon\${imgiconNum}" multiple style = "display : none">`;
        cardStr += `                </div>`;
        cardStr += `            </div>`;
        cardStr += `            <div class="asmttitleimg mb-3"></div>`;
        cardStr += `        </div>`;
        cardStr += `        <div class="asmtcardDtl">`;
        cardStr +=  asmtcardDtlMStr()
        cardStr += `        </div>`;
        cardStr += `    </div>`;
        cardStr += `</div>`;
        return cardStr;
    }

    // 플러스 버튼을 클릭할 때
    $(document).on("click", "#plusBtn", function(e) {
        imgiconNum ++;
        var cardHTML = cardStr(); // cardStr() 함수에서 생성한 문자열로 된 HTML을 변수에 저장
        var tempContainer = document.createElement('div'); // 임시 컨테이너 역할을 할 빈 div 요소 생성
        tempContainer.innerHTML = cardHTML; // HTML 문자열을 div 요소의 innerHTML로 설정하여 노드 객체로 변환
        var newCardContainer = tempContainer.firstChild; // 첫 번째 자식 노드를 가져와 새로운 카드 컨테이너로 사용
        var newCard = newCardContainer.firstChild; // 첫 번째 자식 노드를 가져와 새로운 카드로 사용
        asmtContainer.appendChild(newCardContainer); // 새로운 카드 컨테이너를 추가
        feather.replace();
    })

    // 완료 버튼을 눌렀을 때
    let formData = new FormData();  // 무조건 multipart/form-data
    $(document).on("click", "#submitBtn", function(e){

        var cardBody = this.closest(".card-body"); // 상위 요소 찾기
        var qstList = [];

        var sbjctCd = "${sbjctCd}";
        let asmtTtl =document.querySelector("#asmtTtl").value.trim();
        let asmtExpln =document.querySelector("#asmtExpln").value.trim();
        if(!asmtTtl){
            Swal.fire('과제 제목을 입력해주세요!');
            formData = new FormData(); // 초기화
            return false;
        }
        if(!asmtExpln){
            Swal.fire('과제 내용을 입력해주세요!');
            formData = new FormData(); // 초기화
            return false;
        }

        // 각 card의 정보를 수집하여 List에 추가
        formData.append("asmtTtl", asmtTtl);
        formData.append("asmtExpln", asmtExpln);
        formData.append("asmtDdln", document.querySelector("#asmtDdln").value.replace('T', ' '));
        console.log("날짜 : "+ document.querySelector("#asmtDdln").value.replace('T', ' '))
        formData.append("sbjctCd", sbjctCd);

        var cards = document.querySelectorAll("#asmtContainer .qstCard");

        for(var cardIndex = 0; cardIndex < cards.length; cardIndex++){

            var card = cards[cardIndex];

            // 문제내용
            var qstCn = card.querySelector(".qstCn");
            // 문제 이미지
            var atchFileNo
            // 문제유형
            let qstCode = card.querySelector(".qstCode");

            // 세부문제
            var qstDtlNo;
            var qstDtlCn;
            formData.append("qstList["+cardIndex+"].qstCn",qstCn.value);
            formData.append("qstList["+cardIndex+"].qstCode",qstCode.value);

            // 답이 체크되지 않거나 적혀있지 않을때
            var dtlResult = qstDtlListAndQstAns(qstCode.value, card, cardIndex);
            if (dtlResult == false){
                Swal.fire((cardIndex + 1 )+ '번 문제의 답안을 확인 해 보세요!');
                formData = new FormData();
                return false;
            }

            // 문제가 적혀있지 않을 때
            if(qstCn.value.trim() == ''){
                Swal.fire((cardIndex + 1 )+ '번 문제의 질문을 확인 해 보세요');
                formData = new FormData();
                return false;
            }

            var qstImgs = card.querySelectorAll(".qstTitle input[type=file]");
            if(qstImgs.length > 0){
                for(var z = 0; z < qstImgs[0].files.length; z++){
                    var files = qstImgs[0].files[z];
                    if(files){
                        formData.append("qstList["+cardIndex+"].fileList["+z+"]", files);
                    }
                };
            }
        } // cardList 생성 끝
        console.log("formData:",formData)

        var uploadURL = "";
        if (updateCd == "Y"){
            formData.append("asmtNo", asmtNo);
            $.ajax({
                url: '/tch/class/asmt/update',
                method: 'post',
                data: formData,
                dataType: 'text',
                processData: false,
                contentType: false,
                beforeSend: function(xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success: function(res) {
                    console.log(res)
                    location.href = "/tch/class/asmt?sbjctCd=" + res;
                },
                error: function(xhr, status, error) {
                    // 요청이 실패했을 때 처리할 코드 작성
                    alert("제발");
                    formData = new FormData();
                }
            });
        } else {
            $.ajax({
                url: '/tch/class/asmt',
                method: 'post',
                data: formData,
                dataType: 'text',
                processData: false,
                contentType: false,
                beforeSend: function(xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success: function(res) {
                    console.log(res)
                    Swal.fire(
                      '과제',
                      '과제 등록이 완료되었습니다',
                      'success'
                    ).then((result) => {
                      location.href = "/tch/class/asmt?sbjctCd=" + res;
                    })
                },
                error: function(xhr, status, error) {
                    // 요청이 실패했을 때 처리할 코드 작성
                    alert("제발");
                    formData = new FormData();
                }
            });
        }

    })

    // 카드안에 있는 객관식 리스트를 가져오기
    function qstDtlListAndQstAns(qstCode, card, cardIndex){
        let result = {};
        let qstDtlListResult = [];
        let qstAns = "";
        if(qstCode == "M"){
            // 객관식
            if(!card.querySelector('input[type=radio]:checked')){
                return false;
            }
            qstAns =card.querySelector('input[type=radio]:checked').value;
            var qstDtlOptions = card.querySelectorAll('input[type="radio"]');
            var qstDtlCnInput = card.querySelectorAll('.qstDtlCn');
            console.log("qstAns",qstAns);
            for (var i = 0; i < qstDtlOptions.length; i++) {
                var qstDtlNo = qstDtlOptions[i];
                var qstDtlCn = qstDtlCnInput[i].value.trim();
                if(!qstDtlCn){
                    return false;
                }
                if(!qstDtlNo){
                    return false;
                }
                formData.append("qstList["+cardIndex+"].qstDtlList["+i+"].qstDtlNo",qstDtlNo.value);
                formData.append("qstList["+cardIndex+"].qstDtlList["+i+"].qstDtlCn",qstDtlCn);
                // console.log("qstDtl",qstDtl);
            }
        } else {
            // 주관식
            qstAns = card.querySelector(".qstnAns").value;
            if(qstAns == ""){return false;}

        }
        formData.append("qstList["+cardIndex+"].qstAns",qstAns);
    }


    // 복사 아이콘을 눌렀을 때
    $(document).on("click", ".copyBtn", function(e) {
        imgiconNum++;
        var card = this.closest(".qstCard");
        var newCard = card.cloneNode(true); // 클릭한 카드의 html 가져오기
        var radioButtons = newCard.querySelectorAll('input[type="radio"]');
        var label = newCard.querySelector('.filelabel');
        var myfile = newCard.querySelector('input[type="file"]');
        var asmtTitleImg = newCard.querySelector('.asmttitleimg');
        var qstCard = newCard.querySelector(".qstCard");

        var uniqueName = "qstDtlOptions" + imgiconNum; // 새로운 라디오 버튼 그룹을 위한 고유한 name 생성
        for (const radioButton of radioButtons) {
            radioButton.setAttribute("name", uniqueName);
        }

        var uniimgId= "imgicon" + imgiconNum; // 새로운 라디오 버튼 그룹을 위한 고유한 name 생성
        label.setAttribute("for", uniimgId);
        myfile.setAttribute("id", uniimgId);
        myfile.setAttribute("data-no", "n"+imgiconNum);
        asmtTitleImg.innerHTML = "";
        var parentElement = card.parentElement; // 클릭한 복사 버튼이 속한 카드를 감싸는 부모 요소를 가져옵니다.

        parentElement.insertBefore(newCard, card.nextElementSibling); // 새로운 카드 HTML을 클릭한 복사 버튼 바로 다음에 추가합니다.
        feather.replace();
    })

    var deleteNum = 0;
    // 삭제 아이콘을 눌렀을 때
    $(document).on("click", ".deleteBtn", function(e) {
        var card = this.closest(".qstCard");
        var qstNo = card.getAttribute('data-qstNo');
        if(qstNo == "" || qstNo == null){
        } else {
            formData.append("deleteqstNoList", qstNo)
        }
        card.remove();
        feather.replace();
    })

    $("#asmtContainer").on("change", ".fileSelector", function(event){
        // 파일 수정할 때 - 수정한 파일넘버
        console.log($(this).data("no"));
    //     // 부모 요소 내에서 .asmttitleimg를 선택
        var files = event.target.files;

        var asmttitleimg = $(this).parents(".asmt").find(".asmttitleimg");
        asmttitleimg.html("");
        // var asmttitleimg = parent.querySelector('.asmttitleimg');

        // 선택한 파일이 존재하고 파일의 길이가 0보다 크다면
        if (files && files.length > 0) {
            // Array.from(): 배열로 변환
            // input.files : 선택한 파일 목록
            Array.from(files).forEach(function (file) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    var imgElement = document.createElement("img");
                    imgElement.src = e.target.result;
                    imgElement.style.width = "100%"; // 이미지를 카드의 가로 너비에 맞게 조정
                    imgElement.style.height = "auto"; // 이미지의 세로 높이를 자동으로 조정
                    asmttitleimg.append(imgElement);
                    console.log("f", imgElement);
                };
                reader.readAsDataURL(file);
            });
        }
    });


    // 내용 글자수 제한
    var asmtExpln = document.querySelector("#asmtExpln");

    asmtExpln.addEventListener("input", function() {
        var attdanCnValue = this.value;
        var textCount = attdanCnValue.length;
        
        if (textCount > 400) {
            Swal.fire(
            '글자 수 초과',
            '400자 이상 입력하실 수 없습니다!',
            'error'
            ).then((result) => {
                 
            })
        }
    });

    // 제목 글자수 제한
    var asmtExpln = document.querySelector("#asmtTtl");

    asmtTtl.addEventListener("input", function() {
        var attdanCnValue = this.value;
        var textCount = attdanCnValue.length;
        
        if (textCount > 50) {
            Swal.fire(
            '글자 수 초과',
            '50자 이상 입력하실 수 없습니다!',
            'error'
            ).then((result) => {
                 
            })
        }
    });

    // 그 외
    var length = document.querySelector(".length");

    length.addEventListener("input", function() {
        var attdanCnValue = this.value;
        var textCount = attdanCnValue.length;
        
        if (textCount > 200) {
            Swal.fire(
            '글자 수 초과',
            '200자 이상 입력하실 수 없습니다!',
            'error'
            ).then((result) => {
                 
            })
        }
    });

    // 시연을 위한 자동완성
    $(document).keydown(function(event) {
        if (event.keyCode == '220') {
            document.querySelector("#asmtTtl").value = "고급자바와 관련된 주요 기술 및 패턴";
            var asmtExplnStr = "";
            asmtExplnStr += "이 주제는 고급자바 프로그래밍에서 자주 사용되는 중요한 기술과 디자인 패턴을 다룹니다."
            asmtExplnStr += " 고급자바 개발자들은 자바의 다양한 기능을 잘 이해하고 이를 활용하여 성능 최적화, 비동기 프로그래밍, 멀티스레딩 등을 구현할 수 있어야 합니다."
            asmtExplnStr += " 주제 설명에는 다이나믹 프록시, CompletableFuture와 같은 비동기 기능, 스레드 동기화를 위한 synchronized 키워드 등이 포함될 수 있습니다."
            asmtExplnStr += " 또한, JVM 기반 언어 중 Kotlin에 대한 소개도 함께 포함하여 고급 자바 개발자들이 다른 언어를 활용하는 방법도 이해할 수 있도록 합니다."
            asmtExplnStr += " 이러한 주제들은 고급자바 프로그래밍에 필수적인 지식이며, 개발자들의 역량 향상에 큰 도움이 될 것입니다.";
            document.querySelector("#asmtExpln").value = asmtExplnStr;
            document.querySelector("#asmtDdln").value = '2023-08-14 20:59';
            var cards = document.querySelectorAll(".qstCard");
            console.log("카드개수",cards.length);
            var mNum = 1; //객관식 -> 3개
            var sNum = 1; //주관식 -> 2개
            for(let i=0; i<cards.length; i++){
                var card = cards[i]
                var qstCode = card.querySelector(".qstCode").value;
                if(qstCode == "M"){
                    // 첫번째 객관식
                    if(mNum == 1){
                        // 질문
                        card.querySelector(".qstCn").value = "고급자바에서 사용되는 디자인 패턴 중 객체의 생성을 책임지는 패턴은 무엇인가요?";
    
                        // 답변
                        var qstDtlNo = card.querySelectorAll('input[type="radio"]');
                        var qstDtlCn = card.querySelectorAll('.qstDtlCn');
                        for (let j = 0; j < qstDtlNo.length; j++) {
                            // 첫번째 답
                            if(j==0){ qstDtlCn[j].value = "Singleton 패턴";}
                            // 두번째 답
                            if(j==1){ qstDtlCn[j].value = "Factory 패턴"; }
                            // 세번째 답
                            if(j==2){ qstDtlCn[j].value = "Observer 패턴"; }
                            // 네번째 답
                            if(j==3){ qstDtlCn[j].value = "Strategy 패턴"; }
                            // 다섯번째 답
                            if(j==4){ qstDtlCn[j].value = "Decorator 패턴"; }
                        }
                        qstDtlNo[1].checked = true;
                    }
                    // 두번째 객관식
                    if(mNum == 2){
                        // 질문
                        card.querySelector(".qstCn").value = "고급자바에서 다이나믹 프록시를 생성하기 위해 사용되는 인터페이스는 무엇인가요?";
    
                        // 답변
                        var qstDtlNo = card.querySelectorAll('input[type="radio"]');
                        var qstDtlCn = card.querySelectorAll('.qstDtlCn');
                        for (let j = 0; j < qstDtlNo.length; j++) {
                            // 첫번째 답
                            if(j==0){ qstDtlCn[j].value = "Proxy";}
                            // 두번째 답
                            if(j==1){ qstDtlCn[j].value = "Invoker"; }
                            // 세번째 답
                            if(j==2){ qstDtlCn[j].value = "MethodInterceptor"; }
                            // 네번째 답
                            if(j==3){ qstDtlCn[j].value = "InvocationHandler"; }
                            // 다섯번째 답
                            if(j==4){ qstDtlCn[j].value = "HandlerProxy"; }
                        }
                        qstDtlNo[3].checked = true;
                    }
                    // 세번째 객관식
                    if(mNum == 3){
                        // 질문
                        card.querySelector(".qstCn").value = "고급자바에서 비동기 작업을 위해 새롭게 추가된 기능은 무엇인가요?";
    
                        // 답변
                        var qstDtlNo = card.querySelectorAll('input[type="radio"]');
                        var qstDtlCn = card.querySelectorAll('.qstDtlCn');
                        for (let j = 0; j < qstDtlNo.length; j++) {
                            // 첫번째 답
                            if(j==0){ qstDtlCn[j].value = "CompletableFuture";}
                            // 두번째 답
                            if(j==1){ qstDtlCn[j].value = "FutureTask"; }
                            // 세번째 답
                            if(j==2){ qstDtlCn[j].value = "AsyncJob"; }
                            // 네번째 답
                            if(j==3){ qstDtlCn[j].value = "Promise"; }
                            // 다섯번째 답
                            if(j==4){ qstDtlCn[j].value = "TaskExecutor"; }
                        }
                        qstDtlNo[0].checked = true;
                    }
                    mNum++;
                    console.log("mNum : " + mNum + " sNum : " + sNum);
                } else {
                    // 첫번째 주관식
                    if(sNum == 1 && qstCode == "S"){
                        // 질문
                        card.querySelector(".qstCn").value = "고급자바에서 사용되는 JVM 기반 언어는 무엇인가요?";
                        // 답변
                        card.querySelector(".qstnAns").value = "Kotlin";
                    }
                    // 두번째 주관식
                    if(sNum == 2 && qstCode == "S"){
                        // 질문
                        card.querySelector(".qstCn").value = "고급자바에서 제공하는 스레드 동기화 기법 중 하나로, 객체의 잠금을 위해 사용되는 키워드는 무엇인가요?";
                        // 답변
                        card.querySelector(".qstnAns").value = "synchronized";
                    }
                    sNum++;
                    console.log("mNum : " + mNum + " sNum : " + sNum);

                }

            }
        }
	})
</script>