<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시물 작성</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
    
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header text-center">
                        <h3>게시물 작성</h3>
                    </div>
                    <div class="card-body">
                        <form id="insertForm" action="<c:url value='/board/insert' />" method="post" enctype="multipart/form-data" >
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
                                       value="${board.title}" required>
                                <div class="form-text">제목은 100자 이내로 작성해주세요.</div>
                            </div>
                            <!-- 내용 -->
                            <div class="mb-3">
                                <label for="contentInput" class="form-label">내용</label>
                                <textarea class="form-control" id="contentInput" name="content" rows="5" maxlength="500" required>${board.content}</textarea>
                                <div class="form-text">내용은 500자 이내로 작성해주세요.</div>
                            </div>
                            <!-- 별점 RATING -->
							<div class="mb-3">
								<label for="rating">별점 : </label> <select id="rating"
									name="rating" required>
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
                            <!-- 사진첨부 -->
                            <div class="mb-3">
                            	<label for="image">사진 첨부:</label>
    							<input type="file" id="image" name="image" accept="image/*">
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
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
