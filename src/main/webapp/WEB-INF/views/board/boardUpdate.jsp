<%@ include file="../include/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<head>
    <!-- CKEditor 5 CDN -->
    <script src="https://cdn.ckeditor.com/ckeditor5/39.0.2/classic/ckeditor.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<!-- 본문-->
<section class="about-section text-center" id="about">
   <div class="container px-4 px-lg-5">
      <div class="row gx-4 gx-lg-5 justify-content-center">
         <div class="col-lg-8">
            <h2 class="text-white mb-5">리뷰 수정</h2>
         </div>
      </div>
   </div>
</section>

<!-- 내용 -->
<section class="projects-section bg-light" id="projects">
    <div class="container px-4 px-lg-5">
        <div class="card-body">
            <form id="updateForm" action="<c:url value='/board/update' />" method="post">
                <input id="boardNoInput" type="hidden" name="boardNo" value="${board.boardNo}">
                <!-- 제목 -->
                <div class="mb-3">
                    <label for="titleInput" class="form-label"><strong>제목</strong></label>
                    <input id="titleInput" type="text" class="form-control" name="title" 
                           value="${board.title}" required>
                </div>
                <!-- 내용 -->
                <div class="mb-3">
                    <label for="contentInput" class="form-label"><strong>내용</strong></label>
                    <textarea id="contentInput" class="form-control" name="content" rows="5" required>${board.content}</textarea>
                </div>

                <!-- 별점 RATING --> 
                <div class="mb-3">
                    <label for="rating">별점 :</label>
                    <select id="rating" name="rating" required>
                        <option value="" disabled selected>별점을 선택하세요</option>
                        <option value="1.0" ${board.rating == 1.0 ? 'selected' : ''}>⭐</option> 
                        <option value="2.0" ${board.rating == 2.0 ? 'selected' : ''}>⭐⭐</option>
                        <option value="3.0" ${board.rating == 3.0 ? 'selected' : ''}>⭐⭐⭐</option>
                        <option value="4.0" ${board.rating == 4.0 ? 'selected' : ''}>⭐⭐⭐⭐</option>
                        <option value="5.0" ${board.rating == 5.0 ? 'selected' : ''}>⭐⭐⭐⭐⭐</option>
                    </select>
                </div>

                <!-- 작성자 ID -->
                <div class="mb-3">
                    <label class="form-label"><strong>작성자 ID</strong></label>
                    <input type="text" class="form-control" value="${board.memberId}" readonly>
                </div>

                <!-- 영화 선택 -->
                <div class="mb-3">
				    <label for="movieSelect" class="form-label">영화 선택</label>
				    <select id="movieSelect" name="movieId" required>
					    <option value="" disabled selected>영화를 선택하세요</option>
					    <c:forEach var="movie" items="${movieList}">
					        <option value="${movie.movieId}" ${movie.movieId == board.movieId ? 'selected' : ''}>${movie.name}</option>
					    </c:forEach>
					</select>
					</div>



                <!-- 스포일러 포함 여부 -->
                <div class="mb-3">
                    <label for="spoilerCheck" class="form-label">스포일러 포함 여부</label>
                    <input type="checkbox" id="spoilerCheck" name="spoiler" value="Y">
                    <div class="form-text" style="font-size:12px;">스포일러가 포함된 경우 체크해주세요.</div>
                </div>

                <!-- 버튼 섹션 -->
                <div class="d-flex justify-content-between">
                    <button type="submit" id="submitButton" class="btn btn-primary">등록</button>
                    <button type="button" id="cancelButton" class="btn btn-secondary">취소</button>
                </div>
            </form>
        </div> <!-- card-body 닫기 -->
    </div> <!-- container 닫기 -->
</section>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
// 폼 제출 시 이벤트 처리
document.getElementById("updateForm").addEventListener("submit", function(event) {
    const title = document.getElementById("titleInput").value.trim();
    const content = document.getElementById("contentInput").value.trim();
    
    // 스포일러 체크박스 상태 확인
    const spoilerChecked = document.getElementById("spoilerCheck").checked;
    
    // 스포일러가 체크되지 않았다면 N으로 설정
    if (!spoilerChecked) {
        const spoilerInput = document.createElement("input");
        spoilerInput.type = "hidden";
        spoilerInput.name = "spoiler";
        spoilerInput.value = "N"; // 기본값으로 'N' 설정
        this.appendChild(spoilerInput);
    }

    // 유효성 검사
    if (title === "") {
        alert("제목을 입력하세요.");
        event.preventDefault();
        return; // 여기서 함수 종료
    }

    if (content === "") {
        alert("내용을 입력하세요.");
        event.preventDefault();
        return; // 여기서 함수 종료
    }

    if (title.length > 100) {
        alert("제목은 100자를 초과할 수 없습니다.");
        event.preventDefault();
        return; // 여기서 함수 종료
    }

    if (content.length > 500) {
        alert("내용은 500자를 초과할 수 없습니다.");
        event.preventDefault();
        return; // 여기서 함수 종료
    }
});


// 취소 버튼 클릭 시 이벤트 처리
document.getElementById("cancelButton").addEventListener("click", function() {
    if (confirm("작성 중인 내용을 취소하시겠습니까?")) {
        location.href = "<c:url value='/board/list' />";
    }
});
</script>

<%@ include file="../include/footer.jsp"%> 
