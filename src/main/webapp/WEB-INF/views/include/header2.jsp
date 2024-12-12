<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- 문서의 문자 인코딩을 UTF-8로 설정 -->
<meta charset="utf-8">
<!-- IE 브라우저의 호환성 모드 설정 -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- 반응형 웹 디자인을 위한 뷰포트 설정 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<title>SB Admin 2 - Bootstrap Admin Theme</title>

<!-- Bootstrap Core CSS 파일 링크 -->
<!-- 부트스트랩의 기본 스타일시트. 반응형 그리드 시스템, 타이포그래피, 폼 스타일 등을 제공 -->
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- MetisMenu CSS: 다단계 드롭다운 메뉴를 쉽게 만들 수 있는 jQuery 플러그인의 스타일시트 -->
<link href="/resources/vendor/metisMenu/metisMenu.min.css"
	rel="stylesheet">

<!-- DataTables CSS: 데이터를 테이블 형식으로 표시하고 정렬, 검색 등의 기능을 제공하는 jQuery 플러그인의 스타일시트 -->
<link
	href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css"
	rel="stylesheet">

<!-- DataTables Responsive CSS: 반응형 데이터 테이블을 위한 추가 스타일시트 -->
<link
	href="/resources/vendor/datatables-responsive/dataTables.responsive.css"
	rel="stylesheet">

<!-- Custom CSS: 프로젝트에 특화된 사용자 정의 스타일 -->
<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts: Font Awesome 아이콘 폰트를 사용하기 위한 스타일시트 -->
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- jQuery 라이브러리 로드: JavaScript 작업을 간소화하는 라이브러리 -->
<script type="text/javascript"
	src='<c:url value="/resources/vendor/jquery/jquery.min.js" />'></script>

<!-- CKEditor 스크립트: 웹 기반의 리치 텍스트 에디터를 제공하는 라이브러리 -->
<script type="text/javascript"
	src='<c:url value="/resources/ckeditor/ckeditor.js" />'></script>
</head>


<body>
	<div class="container-fluid">
		<!-- 전체 페이지를 감싸는 wrapper div -->
		<div id="wrapper">

			<!-- 네비게이션 바 시작 -->
			<nav class="navbar navbar-default navbar-static-top"
				role="navigation" style="margin-bottom: 0">
				<!-- 네비게이션 헤더: 로고 및 모바일 메뉴 토글 버튼 -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target=".navbar-collapse">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<!-- 사이트 로고/브랜드명 -->
					<a class="navbar-brand" href="/board">MOVIE </a>
				</div>

				<!-- 상단 우측 네비게이션 메뉴 -->
				<ul class="nav navbar-top-links navbar-right">
					<!-- 메시지 드롭다운 메뉴 -->
					<li class="dropdown">
						<!-- 메시지 아이콘 및 드롭다운 토글 --> <a class="dropdown-toggle"
						data-toggle="dropdown" href="#"> <i
							class="fa fa-envelope fa-fw"></i> <i class="fa fa-caret-down"></i>
					</a> <!-- 메시지 목록 -->
						<ul class="dropdown-menu dropdown-messages">
							<!-- 메시지 항목들 -->
							<li><a href="#">
									<div>
										<strong>John Smith</strong> <span
											class="pull-right text-muted"> <em>Yesterday</em>
										</span>
									</div>
									<div>Lorem ipsum dolor sit amet, consectetur adipiscing
										elit. Pellentesque eleifend...</div>
							</a></li>
							<li class="divider"></li>
							<li><a href="#">
									<div>
										<strong>John Smith</strong> <span
											class="pull-right text-muted"> <em>Yesterday</em>
										</span>
									</div>
									<div>Lorem ipsum dolor sit amet, consectetur adipiscing
										elit. Pellentesque eleifend...</div>
							</a></li>
							<li class="divider"></li>
							<li><a href="#">
									<div>
										<strong>John Smith</strong> <span
											class="pull-right text-muted"> <em>Yesterday</em>
										</span>
									</div>
									<div>Lorem ipsum dolor sit amet, consectetur adipiscing
										elit. Pellentesque eleifend...</div>
							</a></li>
							<li class="divider"></li>
							<li><a class="text-center" href="#"> <strong>Read
										All Messages</strong> <i class="fa fa-angle-right"></i>
							</a></li>
						</ul> <!-- /.dropdown-messages -->
					</li>
					<!-- 작업 드롭다운 메뉴 -->
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#"> <i class="fa fa-tasks fa-fw"></i>
							<i class="fa fa-caret-down"></i>
					</a>
						<ul class="dropdown-menu dropdown-tasks">
							<li><a href="#">
									<div>
										<p>
											<strong>Task 1</strong> <span class="pull-right text-muted">40%
												Complete</span>
										</p>
										<div class="progress progress-striped active">
											<div class="progress-bar progress-bar-success"
												role="progressbar" aria-valuenow="40" aria-valuemin="0"
												aria-valuemax="100" style="width: 40%">
												<span class="sr-only">40% Complete (success)</span>
											</div>
										</div>
									</div>
							</a></li>
							<li class="divider"></li>
							<li><a href="#">
									<div>
										<p>
											<strong>Task 2</strong> <span class="pull-right text-muted">20%
												Complete</span>
										</p>
										<div class="progress progress-striped active">
											<div class="progress-bar progress-bar-info"
												role="progressbar" aria-valuenow="20" aria-valuemin="0"
												aria-valuemax="100" style="width: 20%">
												<span class="sr-only">20% Complete</span>
											</div>
										</div>
									</div>
							</a></li>
							<li class="divider"></li>
							<li><a href="#">
									<div>
										<p>
											<strong>Task 3</strong> <span class="pull-right text-muted">60%
												Complete</span>
										</p>
										<div class="progress progress-striped active">
											<div class="progress-bar progress-bar-warning"
												role="progressbar" aria-valuenow="60" aria-valuemin="0"
												aria-valuemax="100" style="width: 60%">
												<span class="sr-only">60% Complete (warning)</span>
											</div>
										</div>
									</div>
							</a></li>
							<li class="divider"></li>
							<li><a href="#">
									<div>
										<p>
											<strong>Task 4</strong> <span class="pull-right text-muted">80%
												Complete</span>
										</p>
										<div class="progress progress-striped active">
											<div class="progress-bar progress-bar-danger"
												role="progressbar" aria-valuenow="80" aria-valuemin="0"
												aria-valuemax="100" style="width: 80%">
												<span class="sr-only">80% Complete (danger)</span>
											</div>
										</div>
									</div>
							</a></li>
							<li class="divider"></li>
							<li><a class="text-center" href="#"> <strong>See
										All Tasks</strong> <i class="fa fa-angle-right"></i>
							</a></li>
						</ul> <!-- /.dropdown-tasks --></li>
					<!-- 알림 드롭다운 메뉴 -->
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#"> <i class="fa fa-bell fa-fw"></i>
							<i class="fa fa-caret-down"></i>
					</a>
						<ul class="dropdown-menu dropdown-alerts">
							<li><a href="#">
									<div>
										<i class="fa fa-comment fa-fw"></i> New Comment <span
											class="pull-right text-muted small">4 minutes ago</span>
									</div>
							</a></li>
							<li class="divider"></li>
							<li><a href="#">
									<div>
										<i class="fa fa-twitter fa-fw"></i> 3 New Followers <span
											class="pull-right text-muted small">12 minutes ago</span>
									</div>
							</a></li>
							<li class="divider"></li>
							<li><a href="#">
									<div>
										<i class="fa fa-envelope fa-fw"></i> Message Sent <span
											class="pull-right text-muted small">4 minutes ago</span>
									</div>
							</a></li>
							<li class="divider"></li>
							<li><a href="#">
									<div>
										<i class="fa fa-tasks fa-fw"></i> New Task <span
											class="pull-right text-muted small">4 minutes ago</span>
									</div>
							</a></li>
							<li class="divider"></li>
							<li><a href="#">
									<div>
										<i class="fa fa-upload fa-fw"></i> Server Rebooted <span
											class="pull-right text-muted small">4 minutes ago</span>
									</div>
							</a></li>
							<li class="divider"></li>
							<li><a class="text-center" href="#"> <strong>See
										All Alerts</strong> <i class="fa fa-angle-right"></i>
							</a></li>
						</ul> <!-- /.dropdown-alerts --></li>
					<!-- 사용자 드롭다운 메뉴 -->
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#"> <i class="fa fa-user fa-fw"></i>
							<i class="fa fa-caret-down"></i>
					</a>
						<ul class="dropdown-menu dropdown-user">
							<li><a href="#"><i class="fa fa-user fa-fw"></i> User
									Profile</a></li>
							<li><a href="#"><i class="fa fa-gear fa-fw"></i>
									Settings</a></li>
							<li class="divider"></li>

							<c:if test="${not empty loginUser.memberId}">
								<a href="${pageContext.request.contextPath}/logout"> <i
									class="fa fa-sign-out fa-fw"></i>Logout
								</a>
							</c:if>
							<c:if test="${empty loginUser.memberId}">
								<a href="${pageContext.request.contextPath}/login"> <i
									class="fa fa-sign-out fa-fw"></i>Login
								</a>
								<br>
								<a href="${pageContext.request.contextPath}/member/insert">
									<i class="fa fa-sign-out fa-fw"></i>Join
								</a>
							</c:if>


						</ul> <!-- /.dropdown-user --></li>
					<!-- /.dropdown -->
				</ul>
				<!-- /.navbar-top-links -->

				<!-- 좌측 사이드바 네비게이션 -->
				<div class="navbar-default sidebar" role="navigation">
					<div class="sidebar-nav navbar-collapse">
						<!-- 사이드바 메뉴 항목들 -->
						<ul class="nav" id="side-menu">
							<!-- 검색 폼 -->
							<li class="sidebar-search">
								<div class="input-group custom-search-form">
									<input type="text" class="form-control" placeholder="Search...">
									<span class="input-group-btn">
										<button class="btn btn-default" type="button">
											<i class="fa fa-search"></i>
										</button>
									</span>
								</div> <!-- /input-group -->
							</li>
							<!-- 메뉴 항목들 -->
							<li><a href='<c:url value="/board/list" />'><i
									class="fa fa-dashboard fa-fw"></i>영화 리뷰</a></li>
							<li><a href='#'><i class="fa fa-bar-chart-o fa-fw"></i>영화(Employee)<span
									class="fa arrow"></span></a>
								<ul class="nav nav-second-level">
									<li><a href='<c:url value="/movie/list" />'>영화 목록</a></li>
									<li><a href='<c:url value="/board/list" />'>영화 리뷰</a></li>
								</ul> <!-- /.nav-second-level --></li>
							<li><a href="tables.html"><i class="fa fa-table fa-fw"></i>
									Tables</a></li>
							<li><a href="forms.html"><i class="fa fa-edit fa-fw"></i>
									Forms</a></li>
							<li><a href="#"><i class="fa fa-wrench fa-fw"></i> UI
									Elements<span class="fa arrow"></span></a>
								<ul class="nav nav-second-level">
									<li><a href="panels-wells.html">Panels and Wells</a></li>
									<li><a href="buttons.html">Buttons</a></li>
									<li><a href="notifications.html">Notifications</a></li>
									<li><a href="typography.html">Typography</a></li>
									<li><a href="icons.html"> Icons</a></li>
									<li><a href="grid.html">Grid</a></li>
								</ul> <!-- /.nav-second-level --></li>
							<li><a href="#"><i class="fa fa-sitemap fa-fw"></i>
									Multi-Level Dropdown<span class="fa arrow"></span></a>
								<ul class="nav nav-second-level">
									<li><a href="#">Second Level Item</a></li>
									<li><a href="#">Second Level Item</a></li>
									<li><a href="#">Third Level <span class="fa arrow"></span></a>
										<ul class="nav nav-third-level">
											<li><a href="#">Third Level Item</a></li>
											<li><a href="#">Third Level Item</a></li>
											<li><a href="#">Third Level Item</a></li>
											<li><a href="#">Third Level Item</a></li>
										</ul> <!-- /.nav-third-level --></li>
								</ul> <!-- /.nav-second-level --></li>
							<li><a href="#"><i class="fa fa-files-o fa-fw"></i>
									Sample Pages<span class="fa arrow"></span></a>
								<ul class="nav nav-second-level">
									<li><a href="<c:url value='/board/list' />">게시물 목록</a></li>
									<li><a href="<c:url value='/login' />">로그인</a></li>
								</ul> <!-- /.nav-second-level --></li>
						</ul>
					</div>
					<!-- /.sidebar-collapse -->
				</div>
				<!-- /.navbar-static-side -->
			</nav>

			<!-- 메인 콘텐츠 영역 -->
			<div id="page-wrapper">
				<!-- 여기에 페이지별 콘텐츠가 들어갑니다 -->