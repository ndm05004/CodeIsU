<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>TTTT</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="description" content="" />
<meta name="author" content="" />
<!-- Favicon icon -->
<link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath }/assets/images/favicon.png" />
<!-- This page css -->
<!-- Custom CSS -->
<link href="${pageContext.request.contextPath }/dist/css/style.min.css" rel="stylesheet" />
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
			<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
<script src="${pageContext.request.contextPath }/assets/libs/jquery/dist/jquery.min.js"></script>
  <!-- SweetAlert2 -->
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.12/dist/sweetalert2.all.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.12/dist/sweetalert2.min.css" rel="stylesheet">
  <!-- Custom $t Js -->
<script>
var $t = {
	header : "${_csrf.headerName}",
	token : "${_csrf.token}",
	csrfq : "${_csrf.parameterName}=${_csrf.token}"
};
</script>
</head>

<body>
<tiles:insertAttribute name="top"/>
	<!-- 컨텐츠가 들어갑니다 시작!-->
<tiles:insertAttribute name="content"/>
	<!-- 컨텐츠가 들어갑니다 끝!-->
<tiles:insertAttribute name="bottom"/>
</body>
</html>
