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

<section class="projects-section bg-dark text-lightpt-5 pb-5" id="projects">
    <div class="container px-4 px-lg-5">
        <div class="row align-items-start">
            <!-- 왼쪽: 영화 이미지 -->
            <div class="col-md-6">
                <div class="image-container text-center">
                    <c:if test="${not empty movie.imgList}">
                        <c:forEach var="image" items="${movie.imgList}">
                            <img
                                src="${pageContext.request.contextPath}/movie/upload/${image.imgPath.replace('\\', '/')}/${image.fileName}"
                                alt="Movie Image"
                                class="img-fluid rounded shadow mb-4"
                                style="max-width: 100%; max-height: 450px; object-fit: cover;">
                        </c:forEach>
                    </c:if>
                </div>
            </div>

            <!-- 오른쪽: 영화 정보 -->
            <div class="col-md-6">
                <div class="card shadow-sm border-0">
                    <div class="card-body">
                        <h5 class="card-title mb-4 text-center">🎬 영화 정보</h5>

                        <!-- 영화 정보 -->
                        <div class="mb-3">
                            <strong>영화명:</strong> <span>${movie.name}</span>
                        </div>
                        <div class="mb-3">
                            <strong>영화 ID:</strong> <span>${movie.movieId}</span>
                        </div>
                        <div class="mb-3">
                            <strong>설명:</strong>
                            <p class="text-muted">${movie.description}</p>
                        </div>
                        <div class="mb-3">
                            <strong>개봉일:</strong>
                            <span><fmt:formatDate value='${movie.movieDate}' pattern='yyyy-MM-dd' /></span>
                        </div>
                        <div class="mb-3">
                            <strong>등록일:</strong>
                            <span><fmt:formatDate value='${movie.regDate}' pattern='yyyy-MM-dd HH:mm:ss' /></span>
                        </div>
                        <div class="mb-3">
                            <strong>장르:</strong> <span>${movie.genre}</span>
                        </div>
                        <div class="mb-3">
                            <strong>상영시간:</strong> <span>${movie.runningTime}분</span>
                        </div>
                        <div class="mb-3">
                            <strong>평점:</strong> <span>${movie.rating} / 10</span>
                        </div>
                        <div class="mb-3">
                            <strong>연령등급:</strong> <span>${movie.ageRating}</span>
                        </div>
                        <div class="mb-3">
                            <strong>감독:</strong> <span>${movie.director}</span>
                        </div>
                        <div class="mb-3">
                            <strong>출연 배우:</strong>
                            <p class="text-muted">${movie.cast}</p>
                        </div>

                        <!-- 버튼 섹션 -->
                        <div class="d-flex justify-content-between mt-3">
                            <c:if test="${not empty loginUser and loginUser.roleId == 'admin'}">
                                <button id="updateButton" type="button" class="btn btn-primary btn-sm me-2">수정</button>
                                <form id="deleteForm" action="<c:url value='/movie/delete' />" method="post" class="d-inline">
                                    <input type="hidden" name="movieId" value="${movie.movieId}">
                                    <button id="deleteButton" type="submit" class="btn btn-danger btn-sm me-2">삭제</button>
                                </form>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>




<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
	// 수정 버튼 클릭 이벤트
	document.getElementById("updateButton").addEventListener("click", function() {
		location.href = "<c:url value='/movie/update?movieId=${movie.movieId}' />";
	});

	// 삭제 버튼 클릭 이벤트
	document.getElementById("deleteButton").addEventListener("click", function(event) {
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