<%@ include file="../include/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 본문-->
<section class="about-section text-center" id="about">
	<div class="container px-4 px-lg-5">
		<div class="row gx-4 gx-lg-5 justify-content-center">
			<div class="col-lg-8">
				<h2 class="text-white mb-5">회원 목록</h2>
			</div>
		</div>
	</div>
</section>
<!-- 내용-->
<section class="projects-section bg-dark" id="projects">
	<div class="container px-4 px-lg-5">
		<!-- 회원 목록 테이블 -->
		<table class="table table-bordered table-striped table-hover"
			style="background-color: #333; color: white;">
			<thead class="table-light"
				style="background-color: #555; color: black;">
				<tr>
					<th style="color: #444;">아이디</th>
					<th style="color: #444;">이름</th>
					<th style="color: #444;">이메일</th>
					<th style="color: #444;">가입일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="member" items="${memberList}">
					<tr style="background-color: #444;">
						<td style="color: white;"><a
								href="<c:url value='/board/member/boards?memberId=${member.memberId}' />">
									${member.memberId} </a></td>
						<td><a
							href="<c:url value='/member/view?memberId=${member.memberId}' />"
							class="text-decoration-none" style="color: lightblue;">
								${member.name} </a></td>
						<td style="color: white;">${member.email}</td>
						<td style="color: white;"><fmt:formatDate
								value="${member.regDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

	</div>
</section>
<script>
	// 로그인 버튼 이벤트
	const loginButton = document.getElementById('loginButton');
	if (loginButton) {
		loginButton.addEventListener('click', function() {
			window.location.href = '<c:url value="/login" />';
		});
	}

	// 로그아웃 버튼 이벤트
	const logoutButton = document.getElementById('logoutButton');
	if (logoutButton) {
		logoutButton.addEventListener('click', function() {
			window.location.href = '<c:url value="/logout" />';
		});
	}

	// 회원가입 버튼 이벤트
	const addMemberButton = document.getElementById('addMemberButton');
	if (addMemberButton) {
		addMemberButton.addEventListener('click', function() {
			window.location.href = '<c:url value="/member/insert" />';
		});
	}
</script>

<%@ include file="../include/footer.jsp"%>

