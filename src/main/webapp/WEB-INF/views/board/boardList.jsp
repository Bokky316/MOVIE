<%@ include file="../include/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
/* 모든 td를 가운데 정렬 */
table td {
	text-align: center;
}

/* 두 번째 td만 왼쪽 정렬 */
table td:nth-child(2) {
	text-align: left;
}

.search-container {
	margin-top: 10px; /* 위쪽 여백 */
	margin-bottom: 30px; /* 아래쪽 여백 */
}

#searchForm {
	display: flex;
	align-items: center; /* 수직 중앙 정렬 */
}

#searchText {
	height: 50px; /* 입력란 높이 조정 */
	flex: 1; /* 입력창이 가능한 공간을 모두 차지하도록 설정 */
	min-width: 150px; /* 최소 너비 설정 (필요에 따라 조정) */
	margin-right: 5px; /* 오른쪽 여백 */
}

.btn {
	height: 50px; /* 버튼 높이 조정 */
	flex-shrink: 0; /* 버튼의 너비가 줄어들지 않도록 설정 */
}


</style>





<!-- 본문-->
<section class="about-section text-center" id="about">
	<div class="container px-4 px-lg-5">
		<div class="row gx-4 gx-lg-5 justify-content-center">
			<div class="col-lg-8">
				<h2 class="text-white mb-5">리뷰 목록</h2>
			</div>
		</div>
	</div>
</section>

<section class="projects-section bg-dark" id="projects">
	<div class="container px-4 px-lg-5">
		<!-- 검색 입력란 및 버튼 -->
		<div class="search-container">
			<form id="searchForm" action="<c:url value='/board/list' />"
				method="get" class="d-flex">
				<input type="text" class="form-control me-2" name="searchText"
					id="searchText" placeholder="검색어를 입력하세요"
					value="${pageMaker.cri.searchText}">
				<button type="submit" class="btn btn-info me-2">검색</button>
				<button type="button" class="btn btn-dark me-2"
					onclick="location.href='<c:url value='/board/list' />'">전체</button>
			</form>
		</div>

		<!-- 게시물 테이블 -->
		<div>
			<table class="table table-bordered table-striped table-hover"
				style="background-color: #333; color: white;">
				<thead class="table-light"
					style="background-color: #555; color: black; text-align: center;">
					<tr>
						<th style="color: #444;">NO.</th>
						<th style="color: #444;">영화 제목</th>
						<th style="color: #444;">리뷰 제목</th>
						<th style="color: #444;">작성자 ID</th>
						<th style="color: #444;">조회수</th>
						<th style="color: #444;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="board" items="${boardList}">
						<tr style="background-color: #444;">
							<td style="color: white; width: 100px;">${board.boardNo}</td>
							<!-- 영화 제목 표시 -->
							<td style="color: white; width: 200px;"><a
								href="<c:url value='/movie/detail/${board.movieId}' />"
								class="text-decoration-none" style="color: lightblue;">
									${board.movieWithImage.name} </a></td>

							<!-- 제목 링크 -->
							<td style="text-align: left;">
								<div style="margin-left: ${board.replyIndent * 20}px; position: relative;">
									<a
										href="<c:url value='/board/view?boardNo=${board.boardNo }' />"
										class="text-decoration-none"
										style="color: lightblue; ${board.spoiler == 'Y' ? 'filter: blur(5px); text-decoration: underline;' : ''}">
										${board.title} </a>
									<!-- 스포일러 경고 -->
									<c:if test="${board.spoiler == 'Y'}">
										<span
											style="color: #A9A9A9; position: absolute; top: 0; left: 0; z-index: 10; width: 100%; pointer-events: none; cursor: none;">
											※ 스포일러 주의 </span>
									</c:if>
								</div>
							</td>
							<td style="color: white; width: 200px;">
							    <a href="<c:url value='/board/member/boards?memberId=${board.memberId}' />">
    ${board.memberId}
</a>

							</td> <!-- 작성자 ID 클릭 시 해당 작성자의 글 목록으로 이동 -->


							<td style="color: white; width: 200px;">${board.hitNo}</td>
							<td style="color: white; width: 200px;">
							    <fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd HH:mm:ss" />
							</td>




						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>


		<!-- 로그인 유저가 아닐 경우 버튼 숨김 -->
		<c:if test="${not empty loginUser }">
			<div class="text-end mb-3">
				<!-- 오른쪽 정렬을 위한 div -->
				<button type="button" class="btn btn-outline-light"
					onclick="location.href='<c:url value='/movie/create' />'">리뷰
					등록</button>
			</div>
		</c:if>

		<!-- 페이징 -->
		<div class="pagination-container mt-4 position-relative">
			<ul class="pagination justify-content-center">
				<!-- 중앙 정렬 -->
				<!-- 이전 페이지 버튼 -->
				<c:if test="${pageMaker.prev}">
					<li class="page-item"><a class="page-link"
						href="?pageNum=${pageMaker.startPage - 1}&amount=${pageMaker.cri.amount}&searchText=${pageMaker.cri.searchText}">
							Previous </a></li>
				</c:if>

				<!-- 페이지 번호 -->
				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
					var="pageNum">
					<li
						class="page-item ${pageMaker.cri.pageNum == pageNum ? 'active' : ''}">
						<a class="page-link"
						href="?pageNum=${pageNum}&amount=${pageMaker.cri.amount}&searchText=${pageMaker.cri.searchText}">
							${pageNum} </a>
					</li>
				</c:forEach>

				<!-- 다음 페이지 버튼 -->
				<c:if test="${pageMaker.next}">
					<li class="page-item"><a class="page-link"
						href="?pageNum=${pageMaker.endPage + 1}&amount=${pageMaker.cri.amount}&searchText=${pageMaker.cri.searchText}">
							Next </a></li>
				</c:if>
			</ul>
		</div>
	</div>
</section>

<!-- Bootstrap JS -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 로그인/로그아웃 버튼 이벤트 처리
    const loginButton = document.getElementById('loginButton');
    const logoutButton = document.getElementById('logoutButton');

    if (loginButton) {
        loginButton.addEventListener('click', function() {
            window.location.href = "<c:url value='/login' />";
        });
    }

    if (logoutButton) {
        logoutButton.addEventListener('click', function() {
            window.location.href = "<c:url value='/logout' />";
        });
    }
</script>

<%@ include file="../include/footer.jsp"%>
