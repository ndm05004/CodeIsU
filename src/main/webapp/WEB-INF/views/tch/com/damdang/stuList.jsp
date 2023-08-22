<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="card">
    <div class="card-body">

        <table class="table">
            <thead>
                <tr>
                    <th scope="col" class="text-dark">이름</th>
                    <th scope="col" class="text-dark">생년월일</th>
                    <th scope="col" class="text-dark">성별</th>
                    <th scope="col" class="text-dark">전화번호</th>
                    <th scope="col" class="text-dark">이메일</th>
                    <th scope="col" class="text-dark">주소</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="stu" items="${stuList}">
                    <tr>
                        <td>${stu.userNm}</td>
                        <td>${stu.userBrdt}</td>
                        <td>${stu.userGender}</td>
                        <td>${stu.userPhoneno}</td>
                        <td>${stu.userEmlAddr}</td>
                        <td>${stu.userAddr}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>