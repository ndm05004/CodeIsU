/**
 *  공통코드 js파일
 */

// 공통코드를 option 형태로 추출할때 아래 함수를 사용

// 공통코드 추출 함수, <option> -> 선택 or 등록시 사용
//                      공통코드    셀렉트태그의 아이디 # 빼고
function getCodeOption(cdTypeId, insertLocation) {
  $.ajax({
    url: "/cmCd/selectCode",
    data: {
      cdTypeId: cdTypeId,
    },
    type: "get",
    dataType: "json",
    success: function (res) {
      console.log("넘어온 공통 코드: ", res);
      let commonCode = "";


      for (let i = 0; i < res.length; i++) {
        commonCode += `<option value=${res[i].cdTypeId}-${res[i].cdVl}>${res[i].cdNm}</option>`;
      }


      console.log("공통코드 options : " + commonCode);
      $("#" + insertLocation).html(commonCode);
    },
    error: function (xhr) {
      console.log("getTeamMemList 상태: " + xhr.status);
    },
  });
}

// 공통코드를 수정할때 넘어오는 공통코드가 하나일 경우 아래 함수를 사용

// 공통코드 추출 함수, <option selected> -> 하나인경우
function getCodeOptionOneSelected(cdTypeId, insertLocation, selection) {
  $.ajax({
    url: "/cmCd/selectCode",
    data: {
      cdTypeId: cdTypeId,
    },
    type: "get",
    dataType: "json",
    success: function (res) {
      console.log("넘어온 공통 코드 : ", res);
      console.log("넘어온 매개변수 : ", selection);

      selection = $.trim(selection)
      let commonCode = "";
      for (let i = 0; i < res.length; i++) {
        let isSelected = "";
        if (res[i].cdNm == selection) {
          isSelected = "selected";
        }

        commonCode += `<option value="${res[i].cdTypeId}-${res[i].cdVl}" ${isSelected}>${res[i].cdNm}</option>`;
      }

      console.log("공통코드 Selected 사용(매개변수 하나) : " + commonCode);
      $("#" + insertLocation).html(commonCode);
    },
    error: function (xhr) {
      console.log("getTeamMemList 상태: " + xhr.status);
    },
  });
}

// 공통코드를 수정할때 넘어오는 공통코드가 배열일 경우 아래 함수를 사용

// 공통코드 선택되게 selection -> list인 경우 이중 for문 구조로 함수 따로 선언
function getListSelected(selection, res, i) {
  for (let j = 0; j < selection.length; j++) {
    if (selection[j] === res[i].cdNm) {
      return "selected";
    }
  }
}

// 공통코드 추출 함수, <option selected> -> List인 경우
function getCodeOptionMultiSelected(cdTypeId, insertLocation, selection) {
  $.ajax({
    url: "/cmCd/selectCode",
    data: {
      cdTypeId: cdTypeId,
    },
    type: "get",
    dataType: "json",
    success: function (res) {
      console.log("넘어온 공통 코드 : ", res);
      let commonCode = "";
      for (let i = 0; i < res.length; i++) {
        let isSelected = getListSelected(selection, res, i);

        commonCode += `<option value="${res[i].cdTypeId}-${res[i].cdVl}" ${isSelected}>${res[i].cdNm}</option>`;
      }

      console.log("공통코드 Selected 사용(매개변수 list) : " + commonCode);
      $("#" + insertLocation).html(commonCode);
    },
    error: function (xhr) {
      console.log("getTeamMemList 상태: " + xhr.status);
    },
  });
}
