<%@ include file="../include/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 본문-->
<section class="about-section text-center" id="about">
	<div class="container px-4 px-lg-5">
		<div class="row gx-4 gx-lg-5 justify-content-center">
			<div class="col-lg-8">
				<h2 class="text-white mb-5">로그인</h2>
			</div>
		</div>
	</div>
</section>
<!-- 내용-->
<section class="projects-section bg-light" id="projects">
	<div class="container px-4 px-lg-5">
		<!-- 회원 가입 폼 -->
		<div class="row justify-content-center">
			<!-- 가운데 정렬을 위한 클래스 추가 -->
			<div class="col-lg-7">
				<!-- 7칸 차지하는 컬럼 -->
				<form class="user" id="loginForm" action="<c:url value='/login' />"
					method="post">
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
								id="customCheck"> <label class="custom-control-label"
								for="customCheck">Remember Me</label>
						</div>
					</div>
					<!-- 버튼 -->
					<div class="d-flex justify-content-between">
						<button id="loginButton" type="submit" class="btn btn-primary">로그인</button>
						<button id="cancelButton" type="button" class="btn btn-secondary">취소</button>
					</div>
					<hr>
					<a href="index.html" class="btn btn-google btn-user btn-block">
						<i class="fab fa-google fa-fw"></i> Google로 로그인하기
					</a> <a href="index.html" class="btn btn-facebook btn-user btn-block">
						<i class="fab fa-facebook-f fa-fw"></i> Facebook으로 로그인하기
					</a>
				</form>
				<hr>
				<div class="text-center">
					<a class="small" href="forgot-password.html">비밀번호 찾기</a>
				</div>
				<div class="text-center">
					<a class="small"
						href="${pageContext.request.contextPath}/member/insert">회원가입</a>
				</div>
			</div>
		</div>
	</div>
</section>
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