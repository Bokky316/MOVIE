<%@ include file="../include/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	                    <option value="1.0">1.0</option>
	                    <option value="1.5">1.5</option>
	                    <option value="2.0">2.0</option>
	                    <option value="2.5">2.5</option>
	                    <option value="3.0">3.0</option>
	                    <option value="3.5">3.5</option>
	                    <option value="4.0">4.0</option>
	                    <option value="4.5">4.5</option>
	                    <option value="5.0">5.0</option>
	                </select>
	            </div>
                <!-- 작성자 ID -->
                <div class="mb-3">
                    <label class="form-label"><strong>작성자 ID</strong></label>
                    <input type="text" class="form-control" value="${board.memberId}" readonly>
                </div>
                <!-- 버튼 섹션 -->
                <div class="d-flex justify-content-end gap-2">
                    <button id="submitButton" type="submit" class="btn btn-save">저장</button>
                    <button id="cancelButton" type="button" class="btn btn-cancel">취소</button>
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
        if (confirm("수정을 취소하시겠습니까?")) {
            location.href = "<c:url value='/board/view' />?boardNo=${board.boardNo}";
        }
    });
</script>

<%@ include file="../include/footer.jsp" %>
