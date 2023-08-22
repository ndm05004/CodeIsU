<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- Alert 경고창(메세지포함)과 리다이렉트 해버리는 페이지 -->
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
alert("${msg}");
	location.href='${url}';
</script>
</head>
<body>


</body>
</html>