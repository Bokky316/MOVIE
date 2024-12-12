<%@ include file="../include/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영화 목록</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
    </style>
</head>
<body>
    <div class="container mt-5">
        <!-- 페이지 헤더 -->
        <header class="d-flex justify-content-between align-items-center mb-3">
            <h1>영화 목록</h1>
            <!-- 로그인/로그아웃 버튼 -->
            <div>
                <c:choose>
                    <c:when test="${not empty loginUser}">
                        <span class="me-2 text-secondary">${sessionScope.loginUser.memberId}님</span>
                        <button id="logoutButton" class="btn btn-danger btn-sm">로그아웃</button>
                    </c:when>
                    <c:otherwise>
                        <button id="loginButton" class="btn btn-primary btn-sm">로그인</button>
                    </c:otherwise>
                </c:choose>
            </div>
        </header>

        <!-- 검색 입력란 및 버튼 -->
        <div class="search-container mb-4">
            <form id="searchForm" action="<c:url value='/movie/list' />" method="get" class="d-flex justify-content-center">
                <input type="text" class="form-control me-2" name="searchText" id="searchText" placeholder="영화 제목을 검색하세요" value="${pageMaker.cri.searchText}">
                <button type="submit" class="btn btn-info me-2">검색</button>
                <button type="button" class="btn btn-warning me-2" onclick="location.href='<c:url value='/movie/list' />'">전체보기</button>
                <button type="button" class="btn btn-success" onclick="location.href='<c:url value='/movie/create' />'">영화 등록</button>
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
        <div class="pagination-container mt-4">
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

</body>
</html>

