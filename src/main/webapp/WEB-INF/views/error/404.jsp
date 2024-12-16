<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<title>404</title>

<!-- Google font -->
<link href="https://fonts.googleapis.com/css?family=Cabin:400,700"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Montserrat:900"
	rel="stylesheet">

<!-- Custom stlylesheet -->
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/error/css/style.css" />
</head>

<body>

	<div id="notfound">
		<div class="notfound">
			<div class="notfound-404">
				<h3>Oops! Page not found</h3>
				<h1>
					<span>4</span><span>0</span><span>4</span>
				</h1>
			</div>
			<h2>죄송합니다. 요청하신 페이지를 찾을 수 없습니다.</h2>
			<h2>입력한 URL이 올바른지 확인하시고, 다시 시도해 주세요.</h2>
			<a href="${pageContext.request.contextPath}/" class="btn btn-dark">홈으로 돌아가기</a>
		</div>
	</div>

</body>

</html>

<%@ include file="../include/footer.jsp"%>
