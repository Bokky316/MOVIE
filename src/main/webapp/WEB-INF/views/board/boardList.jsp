<%@ include file="../include/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
<!-- 내용-->
<section class="projects-section bg-light" id="projects">
	<div class="container px-4 px-lg-5">

        <!-- 검색 입력란 및 버튼 -->
        <div class="search-container">
          <form id="searchForm" action="<c:url value='/board/list' />" method="get" class="d-flex">
              <input type="text" class="form-control me-2" name="searchText" id="searchText" placeholder="검색어를 입력하세요" value="${pageMaker.cri.searchText}">
              <button type="submit" class="btn btn-info me-2">검색</button>
              <button type="button" class="btn btn-warning me-2" onclick="location.href='<c:url value='/board/list' />'">전체보기</button>
              <button type="button" class="btn btn-success" onclick="location.href='<c:url value='/board/insert' />'">게시물 등록</button>
          </form>
      </div>


        <!-- 게시물 테이블 -->
        <div>
            <table class="table table-bordered table-striped table-hover">
                <thead class="table-light">
                    <tr>
                        <th>게시글 번호</th>
                        <th>제목</th>
                        <th>작성자 ID</th>
                        <th>조회수</th>
                        <th>작성일</th>
                        <th>replyGroup</th>
                        <th>replyOrder</th>
                        <th>replyIndent</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="board" items="${boardList}">
                        <tr>
                            <td>${board.boardNo}</td>
                            <td style="text-align: left;">
                            	<div style="margin-left: ${board.replyIndent * 20}px;">
                                	<a href="<c:url value='/board/view?boardNo=${board.boardNo }' />">${board.title}</a>
                                </div>
                            </td>
                            <td>${board.memberId}</td>
                            <td>${board.hitNo}</td>
                            <td>
                                <fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </td>
                            <td>${board.replyGroup }</td>
                            <td>${board.replyOrder }</td>
                            <td>${board.replyIndent }</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- 페이징 -->
        <div class="pagination-container">
            <ul class="pagination">
                <!-- 이전 페이지 버튼 -->
                <c:if test="${pageMaker.prev}">
                    <li class="page-item">
                        <a class="page-link" href="?pageNum=${pageMaker.startPage - 1}&amount=${pageMaker.cri.amount}&searchText=${pageMaker.cri.searchText}">
                            Previous
                        </a>
                    </li>
                </c:if>

                <!-- 페이지 번호 -->
                <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
                    <li class="page-item ${pageMaker.cri.pageNum == pageNum ? 'active' : ''}">
                        <a class="page-link" href="?pageNum=${pageNum}&amount=${pageMaker.cri.amount}&searchText=${pageMaker.cri.searchText}">
                            ${pageNum}
                        </a>
                    </li>
                </c:forEach>

                <!-- 다음 페이지 버튼 -->
                <c:if test="${pageMaker.next}">
                    <li class="page-item">
                        <a class="page-link" href="?pageNum=${pageMaker.endPage + 1}&amount=${pageMaker.cri.amount}&searchText=${pageMaker.cri.searchText}">
                            Next
                        </a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</section>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

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
