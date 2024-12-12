<%@ include file="../include/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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

<!-- 내용-->
<section class="projects-section bg-light pt-5" id="projects">
    <div class="container px-4 px-lg-5">
        <div class="row">
            <!-- 왼쪽: 영화 이미지 -->
            <div class="col-md-6 mb-3">
                <div class="image-container">
                    <c:if test="${not empty movie.imgList}">
                        <!-- <h5 class="mt-4">이미지 목록</h5> -->
                        <div class="image-container">
                            <c:forEach var="image" items="${movie.imgList}">
                                <img
                                    src="${pageContext.request.contextPath}/movie/upload/${image.imgPath.replace('\\', '/')}/${image.fileName}"
                                    alt="Movie Image"
                                    class="img-fluid rounded shadow-sm mb-3"
   									 style="max-width: 80%; height: auto;">
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- 오른쪽: 영화 정보 -->
            <div class="col-md-6">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <!-- 영화명 -->
                        <div class="mb-3">
                            <label class="form-label"><strong>영화명</strong></label>
                            <input type="text" class="form-control" value="${movie.name}" readonly>
                        </div>

                        <!-- 영화 ID -->
                        <div class="mb-3">
                            <label class="form-label"><strong>영화 ID</strong></label>
                            <input type="text" class="form-control" value="${movie.movieId}" readonly>
                        </div>

                        <!-- 설명 -->
                        <div class="mb-3">
                            <label class="form-label"><strong>설명</strong></label>
                            <textarea class="form-control" rows="4" readonly>${movie.description}</textarea>
                        </div>

                        <!-- 개봉일 -->
                        <div class="mb-3">
                            <label class="form-label"><strong>개봉일</strong></label>
                            <input type="text" class="form-control" value="<fmt:formatDate value='${movie.movieDate}' pattern='yyyy-MM-dd' />" readonly>
                        </div>

                        <!-- 등록일 -->
                        <div class="mb-3">
                            <label class="form-label"><strong>등록일</strong></label>
                            <input type="text" class="form-control" value="<fmt:formatDate value='${movie.regDate}' pattern='yyyy-MM-dd HH:mm:ss' />" readonly>
                        </div>
                        
                        <!-- 장르 -->
                        <div class="mb-3">
                            <label class="form-label"><strong>장르</strong></label>
                            <input type="text" class="form-control" value="${movie.genre}" readonly>
                        </div>

                        <!-- 상영시간 -->
                        <div class="mb-3">
                            <label class="form-label"><strong>상영시간</strong></label>
                            <input type="text" class="form-control" value="${movie.runningTime}" readonly>
                        </div>

                        <!-- 평점 -->
                        <div class="mb-3">
                            <label class="form-label"><strong>평점</strong></label>
                            <input type="text" class="form-control" value="${movie.rating}" readonly>
                        </div>

                        <!-- 연령등급 -->
                        <div class="mb-3">
                            <label class="form-label"><strong>연령등급</strong></label>
                            <input type="text" class="form-control" value="${movie.ageRating}" readonly>
                        </div>

                        <!-- 감독 -->
                        <div class="mb-3">
                            <label class="form-label"><strong>감독</strong></label>
                            <input type="text" class="form-control" value="${movie.director}" readonly>
                        </div>

                        <!-- 출연 배우 -->
                        <div class="mb-3">
						    <label class="form-label"><strong>출연 배우</strong></label>
						    <textarea class="form-control" readonly>${movie.cast}</textarea>
						</div>

                        <!-- 관리자가 아닐 경우 버튼 숨김 -->
                        <c:if test="${not empty loginUser and loginUser.roleId == 'admin'}">
						    <div class="d-flex justify-content-end gap-2 mt-4">
						        <button id="updateButton" type="button" class="btn btn-primary">수정</button>
						        <form id="deleteForm" action="<c:url value='/movie/delete' />" method="post" class="d-inline">
						            <input type="hidden" name="movieId" value="${movie.movieId}">
						            <button id="deleteButton" type="submit" class="btn btn-danger">삭제</button>
						        </form>
						        <button id="listButton" type="button" class="btn btn-dark text-white">목록으로</button>
						    </div>
						</c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
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