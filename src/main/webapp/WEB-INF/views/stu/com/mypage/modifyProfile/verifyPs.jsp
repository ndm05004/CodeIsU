<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

    <!-- VS코드 작업용입니다. 사용하고지워주세요 -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://demos.adminmart.com/free/bootstrap/freedash-lite/src/dist/css/style.min.css" /> -->
<!-- /VS코드 작업용입니다. 사용하고지워주세요 -->
<style>

.tit_square01, .content .tit_square01 {
margin: 3px 0 15px;
padding: 0 0 0 13px;
background: url(/resources/img/h4.png) no-repeat 0 4px;
font-size: 22px;
font-weight: 700;
color: #000;
}
.frm_agree {
    margin: 150px auto 150px !important;
    width: 620px;

}
.boxType04 .tit {
    background: #f7f8fa;
    border-top-color: #a7a7a7;
    padding: 17px 24px;
    font-size: 22px;
    color: #000;
    font-weight: 700;
}
.boxType04 > div {
    border: #dcdee0 solid 1px;
}
.boxType04 > div + div {
    border-top: none;
}
.boxType04 > div {
    border: #dcdee0 solid 1px;
}
.boxType04 > div {
    padding: 23px 24px;
}
.scrollBox {
    overflow-y: auto;
    max-height: 300px;
}
table:not(.kc-cert-table) {
    width: 100%;
    border-collapse: collapse;
    border-spacing: 0;
    table-layout: fixed;
}
.tbl_write, .tbl_default {
    margin-top: 15px;
    border-top: 1px solid #212121;
}
.tbl_write *, .tbl_default * {
    word-break: break-all;
}
caption {
    text-indent: 100%;
    overflow: hidden;
    height: 0;
}
colgroup {
    display: table-column-group;
}
.tbl_write th:first-child, .tbl_write td:first-child, .tbl_default th:first-child, .tbl_default td:first-child {
    border-left: none;
}
.tbl_write td, .tbl_default td {
    background-color: #fff;
}
.tbl_write th, .tbl_write td, .tbl_default th, .tbl_default td {
    text-align: center;
    border-bottom: 1px solid #d4d4d6;
    border-left: 1px solid #d4d4d6;
    padding: 12px 7px;
}
/* 비밀번호 */
.for-a11y {
    position: absolute;
    width: 1px;
    height: 1px;
    margin: -1px;
    padding: 0;
    border: 0;
    clip: rect(0 0 0 0);
    overflow: hidden;
    text-indent: -5000em;
}
.form__input-text {
    position: relative;
    width: 100%;
    height: 67px;
    margin-right: 0;
    padding: 23px;
    background: #fff;
    border: 1px solid #d9d9d9;
    border-radius: 2px;
    color: #222;
    font-size: 21px;
    line-height: 16px;
    font-weight: 400;
    outline: 0;
    box-sizing: border-box;
}
.button__submit {
    position: relative;
    display: block;
    margin-top: 16px;
    width: 100%;
    height: 65px;
    background-color: #067dfd;
    border-radius: 2px;
    color: #fff;
    font-size: 22px;
    font-weight: 700;
}

</style>
<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-body">
    <h4 class="tit_square01">회원정보 변경</h4>
    <div class="frm_agree mt-8 ml00 ">
        <div class="boxType04">
            <div class="tit text-center">비밀번호 확인</div>
            <div class="scrollBox text-center">
                <h3 class="my-4">회원님의 정보를 보호하기 위해 비밀번호를 다시 확인합니다.</h3>
                <form action="/stu/mypage/modify" method="post">
                <label for="input-password" class="for-a11y">비밀번호 입력</label>
                <input type="password" id="pwd_check_field" name="userPs" placeholder="비밀번호" class="form__input-text" value="" maxlength="15">
                <button type="submit" class="button__submit" id="gochecking4personal">확인</button>
                <sec:csrfInput/>
                </form>

            </div>
        </div>
    </div>
</div></div></div></div>