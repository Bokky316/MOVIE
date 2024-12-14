<%@ include file="../include/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
/* 이미지 크기 조정 */
.image-container img {
	max-height: 450px; /* 적당한 높이로 제한 */
	border-radius: 10px;
}

/* 버튼 간격 */
.btn {
	min-width: 100px;
}

.btn-sm {
	padding: 6px 10px;
	font-size: 14px;
	margin-right: 5px; /* 버튼 사이의 간격 */
}

.d-flex .me-2 {
	margin-right: 10px; /* 버튼들 사이 간격 */
}
</style>

<!-- 본문-->
<section class="about-section text-center" id="about">
	<div class="container px-4 px-lg-5">
		<div class="row gx-4 gx-lg-5 justify-content-center">
			<div class="col-lg-8">
				<h2 class="text-white mb-5">영화 상세정보</h2>
			</div>
		</div>
	</div>
</section>

<section class="projects-section bg-dark text-light pt-5 pb-5"
	id="projects">
	<div class="container px-4 px-lg-5">
		<div class="row align-items-start">
			<!-- 왼쪽: 영화 이미지 -->
			<div class="col-md-6">
				<div class="image-container text-center">
					<c:if test="${not empty movie.imgList}">
						<c:forEach var="image" items="${movie.imgList}">
							<img
								src="${pageContext.request.contextPath}/movie/upload/${image.imgPath.replace('\\', '/')}/${image.fileName}"
								alt="Movie Image" class="img-fluid rounded shadow mb-4"
								style="max-width: 100%; max-height: 600px; object-fit: cover;">
							<!-- 포스터 크기 증가 -->
						</c:forEach>
					</c:if>
				</div>
			</div>

			<!-- 오른쪽: 영화 정보 -->
			<div class="col-md-6">
				<div class="card shadow-sm border-0"
					style="background-color: rgba(64, 64, 64, 0.75);">
					<div class="card-body text-white">
						<!-- 글씨 색상을 흰색으로 변경 -->

						<!-- 영화 정보 -->
						<div class="mb-1">
							<span style="font-size: 1.5em;"><strong>${movie.name}</strong></span>
						</div>
						<!-- 영화 ID 숨김 -->
						<div class="mb-1" style="display: none;">
							<strong>영화 ID|</strong> <span>${movie.movieId}</span>
						</div>

						<!-- 제목 아래에 연령등급, 평점, 개봉년도, 상영시간, 장르 표시 -->
						<div class="mb-5">
							<span style="font-size: 0.9em; color: #fff;">
								${movie.ageRating} · <strong>평균 ${movie.rating}</strong> · <fmt:formatDate
									value='${movie.movieDate}' pattern='yyyy' /> ·
								${movie.runningTime} · ${movie.genre}
							</span>
						</div>

						<!-- 설명을 영화 정보 아래에 위치시키기 -->
						<div class="mb-5">
							<p class="text-white">${movie.description}</p>
							<!-- 설명을 흰색으로 변경 -->
						</div>

						<!-- 감독과 출연 배우 -->
						<div class="mb-3">
							<strong>감독 |</strong> <span>${movie.director}</span>
						</div>
						<div class="mb-3">
							<strong>출연 |</strong><span>${movie.cast}</span>
						</div>

						<!-- 영화 리뷰 보기 버튼  -->
						<div class="search-container mt-3">
							<form id="searchForm" action="<c:url value='/board/list' />"
								method="get" class="d-flex justify-content-center">
								<input type="hidden" name="movieId" value="${movie.movieId}">
								<!-- 영화 ID를 hidden 필드로 추가 -->
								<button type="submit" class="btn btn-dark me-2">이 영화의
									리뷰 보기</button>
							</form>
						</div>
					</div>
					<!-- card-body -->
				</div>
				<!-- card -->				
			</div>
			<!-- col-md-6 -->
			<!-- 버튼 섹션 -->
			<div class="d-flex justify-content-end mt-3">
				<!-- justify-content-end로 오른쪽 정렬 -->
				<c:if test="${not empty loginUser and loginUser.roleId == 'admin'}">
					<button id="updateButton" type="button"
						class="btn btn-primary btn-sm me-2">수정</button>
					<form id="deleteForm" action="<c:url value='/movie/delete' />"
						method="post" class="d-inline">
						<input type="hidden" name="movieId" value="${movie.movieId}">
						<button id="deleteButton" type="submit"
							class="btn btn-danger btn-sm">삭제</button>
					</form>
				</c:if>
			</div>


		</div>
		<!-- row -->
	</div>
	<!-- container -->
</section>

<!-- Bootstrap JS -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
	// 수정 버튼 클릭 이벤트
	document
			.getElementById("updateButton")
			.addEventListener(
					"click",
					function() {
						location.href = "<c:url value='/movie/update?movieId=${movie.movieId}' />";
					});

	// 삭제 버튼 클릭 이벤트
	document.getElementById("deleteButton").addEventListener("click",
			function(event) {
				if (!confirm("정말 삭제하시겠습니까?")) {
					event.preventDefault(); // 삭제 취소
				}
			});

	// 목록 버튼 클릭 이벤트
	document.getElementById("listButton").addEventListener("click", function() {
		location.href = "<c:url value='/movie/list' />";
	});
</script>

<%@ include file="../include/footer.jsp"%>