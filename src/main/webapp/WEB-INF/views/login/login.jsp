<%@ include file="../include/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<head>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Varela+Round"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet" />
</head>
<!-- 본문-->
<section class="about-section text-center" id="about">
	<body class="bg-gradient-primary">

		<div class="container">

			<!-- Outer Row -->
			<div class="row justify-content-center">

				<div class="col-xl-10 col-lg-12 col-md-9">

					<div class="card o-hidden border-0 shadow-lg my-5">
						<div class="card-body p-0">
							<!-- Nested Row within Card Body -->
							<div class="row">
								<div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
								<div class="col-lg-6">
									<div class="p-5">
										<div class="text-center">
											<h1 class="h4 text-gray-900 mb-4">로그인</h1>
										</div>
										<!-- 로그인 폼 -->							
										<form class="user" id="loginForm"
											action="<c:url value='/login' />" method="post">
											<div class="form-group">
												<label for="memberIdInput" class="form-label">아이디</label> <input
													type="text" class="form-control" id="memberIdInput"
													name="memberId" required placeholder="아이디를 입력하세요.">
											</div>
											<div class="form-group">
												<label for="passwordInput" class="form-label">비밀번호</label> <input
													type="password" class="form-control" id="passwordInput"
													name="password" required placeholder="비밀번호를 입력하세요.">
											</div>
											<div class="form-group">
												<div class="custom-control custom-checkbox small">
													<input type="checkbox" class="custom-control-input"
														id="customCheck"> <label
														class="custom-control-label" for="customCheck">Remember
														Me</label>
												</div>
											</div>
											<!-- 버튼 -->
											<div class="d-flex justify-content-between">
												<button id="loginButton" type="submit"
													class="btn btn-primary">로그인</button>
												<button id="cancelButton" type="button"
													class="btn btn-secondary">취소</button>
											</div>
											<hr>
											<a href="index.html"
												class="btn btn-google btn-user btn-block"> <i
												class="fab fa-google fa-fw"></i> Google로 로그인하기
											</a> <a href="index.html"
												class="btn btn-facebook btn-user btn-block"> <i
												class="fab fa-facebook-f fa-fw"></i> Facebook으로 로그인하기
											</a>
										</form>
										<hr>
										<div class="text-center">
											<a class="small" href="forgot-password.html">비밀번호 찾기</a>
										</div>
										<div class="text-center">
											<a class="small" href="${pageContext.request.contextPath}/member/insert">회원가입</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

				</div>

			</div>

		</div>
	</body>
</section>
<!-- Bootstrap JS -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
	// 로그인 폼 제출 시 유효성 검사
	document.getElementById("loginForm").addEventListener(
			"submit",
			function(event) {
				const memberId = document.getElementById("memberIdInput").value
						.trim();
				const password = document.getElementById("passwordInput").value
						.trim();

				if (memberId === "") {
					alert("아이디를 입력하세요.");
					event.preventDefault();
					return;
				}

				if (password === "") {
					alert("비밀번호를 입력하세요.");
					event.preventDefault();
					return;
				}
			});

	// 취소 버튼 클릭 시 이벤트 처리
	document.getElementById("cancelButton").addEventListener("click",
			function() {
				location.href = '<c:url value="/" />'; // 메인 페이지로 이동
			});
</script>
<%@ include file="../include/footer.jsp"%>
