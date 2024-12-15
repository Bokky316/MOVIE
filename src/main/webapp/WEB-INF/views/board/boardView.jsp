<%@ include file="../include/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<head>
    <!-- CKEditor 5 CDN -->
    <script src="https://cdn.ckeditor.com/ckeditor5/39.0.2/classic/ckeditor.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<!-- 본문 -->
<section class="about-section text-center" id="about">
   <div class="container px-4 px-lg-5">
      <div class="row gx-4 gx-lg-5 justify-content-center">
         <div class="col-lg-8">
            <h2 class="text-white mb-5">리뷰</h2>
         </div>
      </div>
   </div>
</section>

<!-- 내용 -->
<section class="projects-section bg-dark text-light" id="projects">
    <div class="container px-4 px-lg-5">
        <div class="card-body">
            <!-- 오류 메시지 표시 -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger" role="alert">
                    ${errorMessage}
                </div>
            </c:if>
            
       		<!-- 영화 정보 표시 -->
			<div class="mb-3">
			    <h5>
			        <!-- 영화 제목에 링크 추가 -->
			        <a href="<c:url value='/movie/detail/${board.movieWithImage.movieId}' />" class="text-decoration-none">
			            <strong>${board.movieWithImage.name}</strong>
			        </a>
			        <span style="font-size: 0.9em; color: gray;"> <!-- 작은 글씨로 개봉일 표시 -->
			            <fmt:formatDate value='${board.movieWithImage.movieDate}' pattern='yyyy-MM-dd' /> 개봉
			        </span>
			    </h5>
			     <!-- 별점 표시 -->
		            <div class="mb-3">
		                <p>
		                    <c:choose>
		                        <c:when test="${board.rating == 1.0}">⭐</c:when>
		                        <c:when test="${board.rating == 2.0}">⭐⭐</c:when>
		                        <c:when test="${board.rating == 3.0}">⭐⭐⭐</c:when>
		                        <c:when test="${board.rating == 4.0}">⭐⭐⭐⭐</c:when>
		                        <c:when test="${board.rating == 5.0}">⭐⭐⭐⭐⭐</c:when>
		                        <c:otherwise>평점 없음</c:otherwise>
		                    </c:choose>
		                </p>
		            </div>
			    <p>${board.movieWithImage.description}</p>
			</div>

            </div>
			  <!-- 제목 및 사용자 정보 -->
			<div class="d-flex justify-content-between mb-3 ">
			    <label class="form-label">
			        <strong>
			            <input type="text" class="form-control d-inline" value="${board.title}" readonly 
			                   style="width:auto; border: none; background: transparent; font-size: 1.5em; font-weight: bold; color:white;">
			        </strong>
			    </label>
			    <div class="text-end">
			        <span class="ms-2"><a
								href="<c:url value='/board/member/boards?memberId=${board.memberId}' />">
									${board.memberId}</a></span> |
			        <span class="ms-2">${board.hitNo}</span> |
			        <span class="ms-2"><fmt:formatDate value='${board.regDate}' pattern='yyyy-MM-dd HH:mm:ss' /></span>
			    </div>
			</div>
           <hr style="border: 1px solid #ccc; margin: 10px 0;">
            <!-- 내용 -->
			<div class="mb-3">
			    <textarea class="form-control" rows="5" readonly 
			              style="border: none; background: transparent; padding-left: 0; text-align: left; font-size: 1em; font-weight: normal; color:white;">      ${board.content}
			    </textarea>
			</div>


             <!-- 영화 선택 (숨김 처리) -->
            <div class="mb-3" style="display: none;">
                <label for="movieSelect" class="form-label">영화 선택</label>
                <select id="movieSelect" name="movieId" required disabled> 
                    <option value="" disabled selected>영화를 선택하세요</option>
                    <!-- 여기에 영화 목록을 동적으로 추가합니다 -->
                    <c:forEach var="movie" items="${movieList}">
                        <option value="${movie.movieId}" ${movie.movieId == board.movieId ? 'selected' : ''}>${movie.name}</option>
                    </c:forEach>
                </select>
            </div>

           <!-- 버튼 섹션 -->
			<div class="d-flex justify-content-end gap-2">
			    <c:if test="${not empty loginUser and loginUser.memberId == board.memberId}"> 
			        <button id="updateButton" type="button" class="btn btn-primary">수정</button>
			    </c:if>
			    <c:if test="${not empty loginUser and loginUser.memberId == board.memberId or loginUser.roleId == 'admin'}"> 
			        <form id="deleteForm" action="<c:url value='/board/delete' />" method="post" class="d-inline">
			            <input type="hidden" name="boardNo" value="${board.boardNo}">
			            <button id="deleteButton" type="submit" class="btn btn-danger">삭제</button>
			        </form>
			    </c:if>
			    <!-- 답글쓰기 버튼 -->
			    <button id="replyButton" type="button" class="btn btn-dark">답글쓰기</button>
			    <button id="listButton" type="button" class="btn btn-dark">목록으로</button>
			</div>

        </div> <!-- 카드 바디 닫기 -->
</section>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function () {
    // 특정 버튼에서 disabled 속성 제거
    const listButton = document.getElementById("listButton"); // listButton을 선택
    if (listButton) {
        listButton.removeAttribute("disabled"); // disabled 속성 제거
    }

    // 수정 버튼 클릭 이벤트
    const updateButton = document.getElementById("updateButton");
    if (updateButton) {
        updateButton.addEventListener("click", function() {
            location.href = "<c:url value='/board/update?boardNo=${board.boardNo}' />";
        });
    }

    // 삭제 버튼 클릭 이벤트
    const deleteForm = document.getElementById("deleteForm");
    if (deleteForm) {
        deleteForm.addEventListener("submit", function(event) {
            if (!confirm("정말 삭제하시겠습니까?")) {
                event.preventDefault(); // 삭제 취소
            }
        });
    }

    // 답글쓰기 버튼 클릭 이벤트
    const replyButton = document.getElementById("replyButton");
    if (replyButton) {
        replyButton.addEventListener("click", function() {
            location.href = "<c:url value='/board/reply?parentBoardNo=${board.boardNo}' />";
        });
    }

    // 목록 버튼 클릭 이벤트
    if (listButton) {
        listButton.addEventListener("click", function() {
            location.href = "<c:url value='/board/list' />";
        });
    }
});

</script>

<%@ include file="../include/footer.jsp"%> 
