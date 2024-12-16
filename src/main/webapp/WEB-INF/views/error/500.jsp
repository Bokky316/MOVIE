<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<title>500</title>

<!-- Google font -->
<link href="https://fonts.googleapis.com/css?family=Cabin:400,700"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Montserrat:900"
	rel="stylesheet">

<!-- Custom stlylesheet -->
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/error/css/style.css"/>

</head>

<body>

	<div id="notfound">
		<div class="notfound">
			<div class="notfound-404">
				<h3>Oops! Page Error</h3>
				<h1>
					<span>5</span><span>0</span><span>0</span>
				</h1>
			</div>
			<h2>죄송합니다. 서버에서 문제가 발생했습니다</h2>
			<h2>잠시 후 다시 시도하시거나, 문제가 지속되면 관리자에게 문의해 주세요.</h2>
		</div>
	</div>

</body>

</html>
<%@ include file="../include/footer.jsp"%>
