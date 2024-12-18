<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Grayscale - Start Bootstrap Theme</title>
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Varela+Round"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link
	href="${pageContext.request.contextPath}/resources/grash/css/styles.css"
	rel="stylesheet" />


<!-- Core theme JS-->
<script
	src="${pageContext.request.contextPath}/resources/grash/js/scripts.js"></script>
<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
<!-- * *                               SB Forms JS                               * *-->
<!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</head>
<body id="page-top">

	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light fixed-top"
		id="mainNav">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand" href="<c:url value='/' /> ">무비무빗</a>
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				Menu <i class="fas fa-bars"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
    <ul class="navbar-nav ms-auto">
        <li class="nav-item">
            <a class="nav-link" href="<c:url value='/movie/list' />">영화 목록</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="<c:url value='/board/list' />">리뷰 목록</a>
        </li>
        <c:if test="${not empty loginUser and loginUser.roleId == 'admin'}">
            <li class="nav-item">
                <a class="nav-link" href="<c:url value='/member/list' />">회원 목록</a>
            </li>
        </c:if>
		  <c:if test="${not empty loginUser.memberId}">
		    <li class="nav-item">
		        <a class="nav-link" href="<c:url value='/member/myPage' />">${loginUser.memberId}님</a>
		    </li>
		    <li class="nav-item">
		        <a class="nav-link" href="<c:url value='/logout' />">
		            <i class="fa fa-sign-out fa-fw"></i>Logout
		        </a>
		    </li>
		</c:if>

        <c:if test="${empty loginUser.memberId}">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/login">
                    <i class="fa fa-sign-out fa-fw"></i>Login
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/member/insert">
                    <i class="fa fa-sign-out fa-fw"></i>Join
                </a>
            </li>
        </c:if>
    </ul>
</div>

		</div>
	</nav>