<%@ include file="../include/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 스타일 -->
<style>
    h1 {
        text-align: center; /* 수평 중앙 정렬 */
        margin-bottom: 20px;
    }
    .gallery {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
    }
    .gallery-item {
        margin: 15px;
        text-align: center;
        max-width: 200px; /* 포스터 크기 조정 */
    }
    .gallery-item img {
        width: 100%; /* 포스터 이미지가 갤러리 아이템의 너비에 맞도록 설정 */
        border-radius: 8px; /* 모서리 둥글게 */
    }
    .movie-title {
        font-size: 1.1em; /* 영화 제목 크기 */
        font-weight: bold;
        margin-top: 5px;
    }
    .movie-info {
        font-size: 0.9em; /* 기본 정보 크기 */
        color: #555; /* 기본 정보 색상 */
    }
    
    /* 버튼 스타일 공통 설정 */
	.btn {
	    display: inline-flex; /* 플렉스 박스 적용 */
	    align-items: center; /* 수직 중앙 정렬 */
	    justify-content: center; /* 가로 중앙 정렬 */
	    padding: 10px 15px; /* 버튼의 크기 조정 */
	    font-size: 14px; /* 글씨 크기 */
	    line-height: 1.2; /* 텍스트 간격 조정 */
	    border-radius: 5px; /* 버튼 모서리 둥글게 */
	    cursor: pointer;
	    transition: background-color 0.3s ease; /* 호버 효과 */
	}
</style>

<!-- 본문-->
<section class="about-section text-center" id="about">
   <div class="container px-4 px-lg-5">
      <div class="row gx-4 gx-lg-5 justify-content-center">
         <div class="col-lg-8">
            <h2 class="text-white mb-5">영화 목록</h2>        
         </div>
      </div>
   </div>
</section>

<!-- 내용-->  
<section class="projects-section bg-light" id="projects">
      <div class="container px-4 px-lg-5">

        <!-- 검색 입력란 및 버튼 -->
        <div class="search-container mb-4">
            <form id="searchForm" action="<c:url value='/movie/list' />" method="get" class="d-flex justify-content-center">
			    <input type="text" class="form-control me-2" name="searchText" id="searchText" placeholder="영화 제목을 검색하세요" value="${pageMaker.cri.searchText}">
			    <button type="submit" class="btn me-2" style="background-color: #212529; border-color: #212529; color: white;">검색</button>
			    <button type="button" class="btn btn-warning me-2" style="background-color: #64a19d ; border-color: #64a19d ; color: white;" onclick="location.href='<c:url value='/movie/list' />'">전체보기</button>


			    <c:if test="${not empty loginUser and loginUser.roleId == 'admin'}">
			        <button type="button" class="btn" style="background-color: #5a9bd5; border-color: #5a9bd5; color: white;" onclick="location.href='<c:url value='/movie/create' />'">영화 등록</button>
			    </c:if>
			</form>
        </div>

      
        <!-- 영화 갤러리 -->
		<div class="gallery">
		    <c:forEach var="movie" items="${movieList}">
		        <div class="gallery-item">
		            <a href="<c:url value='/movie/detail/${movie.movieId}'/>">
		                <img src="${pageContext.request.contextPath}/movie/upload/${movie.imgList[0].imgPath}/${movie.imgList[0].fileName}" 
		                     alt="${movie.name}" 
		                     onerror="this.onerror=null; this.src='https://dummyimage.com/450x300/dee2e6/6c757d.jpg';">
		                <div class="movie-title">${movie.name}</div>
		                <div class="movie-info">
		                    개봉일: <fmt:formatDate value="${movie.movieDate}" pattern="yyyy-MM-dd"/>
		                </div>
		            </a>
		        </div>
		    </c:forEach>
		
		    <!-- 영화가 없을 경우 메시지 -->
		    <c:if test="${empty movieList}">
		        <div class="col mb-5 text-center">
		            <h5>등록된 영화가 없습니다.</h5>
		        </div>
		    </c:if>
		</div>

<!-- 페이징 -->
        <div class="pagination-container  mt-4 position-absolute top-100 start-50 translate-middle">
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

<!-- 로그인/로그아웃 버튼 이벤트 처리 -->
<script>
    const loginButton = document.getElementById('loginButton');
    const logoutButton = document.getElementById('logoutButton');

    if (loginButton) {
        loginButton.addEventListener('click', function () {
            window.location.href = "<c:url value='/login' />";
        });
    }

    if (logoutButton) {
        logoutButton.addEventListener('click', function () {
            window.location.href = "<c:url value='/logout' />";
        });
    }
</script>

<%@ include file="../include/footer.jsp" %>