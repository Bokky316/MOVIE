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
            <h2 class="text-white mb-5">리뷰 등록</h2>
         </div>
      </div>
   </div>
</section>

<!-- 내용-->
<section class="projects-section bg-light" id="projects">
    <div class="container px-4 px-lg-5">
        <form id="insertForm" action="<c:url value='/board/insert' />" method="post" enctype="multipart/form-data">
            <!-- 작성자 ID -->
            <div class="mb-3">
                <label for="memberIdInput" class="form-label">작성자 ID</label>
                <input type="text" class="form-control" id="memberIdInput" name="memberId" 
                       value="${sessionScope.loginUser.memberId}" readonly required>
            </div>
            <!-- 제목 -->
            <div class="mb-3">
                <label for="titleInput" class="form-label">제목</label>
                <input type="text" class="form-control" id="titleInput" name="title" maxlength="100" 
                       required>
                <div class="form-text">제목은 100자 이내로 작성해주세요.</div>
            </div>
            <!-- 내용 -->
            <div class="mb-3">
                <label for="contentInput" class="form-label">내용</label>
                <textarea class="form-control" id="contentInput" name="content" rows="5" maxlength="500" required></textarea>
                <div class="form-text">내용은 500자 이내로 작성해주세요.</div>
            </div>

            <!-- 별점 RATING --> 
            <div class="mb-3">
                <label for="rating">별점 :</label>
                <select id="rating" name="rating" required>
                    <option value="" disabled selected>별점을 선택하세요</option>
                    <option value="1.0">⭐</option> 
                    <option value="2.0">⭐⭐</option>
                    <option value="3.0">⭐⭐⭐</option>
                    <option value="4.0">⭐⭐⭐⭐</option>
                    <option value="5.0">⭐⭐⭐⭐⭐</option>
                </select>
            </div>

            <!-- 영화 선택 -->
            <div class="mb-3">
                <label for="movieSelect" class="form-label">영화 선택</label>
                <select id="movieSelect" name="movieId" required>
                    <option value="" disabled selected>영화를 선택하세요</option>
                    <!-- 여기에 영화 목록을 동적으로 추가합니다 -->
                    <c:forEach var="movie" items="${movieList}">
                        <option value="${movie.movieId}">${movie.name}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- 스포일러 포함 여부 -->
            <div class="mb-3">
                <label for="spoilerCheck" class="form-label">스포일러 포함 여부</label>
                <input type="checkbox" id="spoilerCheck" name="spoiler" value="Y">
                <div class="form-text" style="font-size:12px;">스포일러가 포함된 경우 체크해주세요.</div>
            </div>

            <!-- 버튼 -->
            <div class="d-flex justify-content-between">
                <button type="submit" id="submitButton" class="btn btn-primary">등록</button>
                <button type="button" id="cancelButton" class="btn btn-secondary">취소</button>
            </div>
        </form>
    </div> <!-- container 닫기 -->
</section>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    $(document).ready(function () {
        // 폼 제출 시 유효성 검사
        $('#insertForm').on('submit', function (event) {
            const title = $('#titleInput').val().trim();
            const content = $('#contentInput').val().trim();

            if (title === "") {
                alert("제목을 입력하세요.");
                $('#titleInput').focus();
                event.preventDefault();
                return;
            }

            if (content === "") {
                alert("내용을 입력하세요.");
                $('#contentInput').focus();
                event.preventDefault();
                return;
            }

            if (title.length > 100) {
                alert("제목은 100자를 초과할 수 없습니다.");
                $('#titleInput').focus();
                event.preventDefault();
                return;
            }

            if (content.length > 500) {
                alert("내용은 500자를 초과할 수 없습니다.");
                $('#contentInput').focus();
                event.preventDefault();
                return;
            }
        });

        // 취소 버튼 클릭 시 페이지 이동
        $('#cancelButton').on('click', function () {
            if (confirm("작성 중인 내용을 취소하시겠습니까?")) {
                location.href = "<c:url value='/board/list' />";
            }
        });
    });
</script>

<%@ include file="../include/footer.jsp"%> 
