<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>영화 수정</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.ckeditor.com/ckeditor5/39.0.2/classic/ckeditor.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
        let editorInstance;

        $(document).ready(function () {
            // CKEditor 초기화
            ClassicEditor
                .create(document.querySelector('#descriptionInput'))
                .then(editor => {
                    editorInstance = editor;

                    // 에디터 컨테이너의 스타일 변경 (높이 200px)
                    const editorContainer = editor.ui.view.editable.element;
                    editorContainer.style.height = "200px"; 
                })
                .catch(error => {
                    console.error(error);
                });

            // 유효성 검사 및 CKEditor 데이터 동기화
            $('#movieForm').on('submit', function (event) {
                const name = $('#nameInput').val().trim();
                const movieDate = $('#movieDateInput').val().trim();

                // CKEditor 데이터 가져오기 및 태그 제거
                const editorData = editorInstance.getData();
                const plainText = editorData.replace(/<[^>]*>?/gm, ''); // HTML 태그 제거
                $('#descriptionInput').val(plainText);

                if (name === "") {
                    alert("영화명을 입력하세요.");
                    $('#nameInput').focus();
                    event.preventDefault();
                    return;
                }

                if (plainText === "") {
                    alert("영화 설명을 입력하세요.");
                    $('#descriptionInput').focus();
                    event.preventDefault();
                    return;
                }

                if (movieDate === "") {
                    alert("개봉일을 입력하세요.");
                    $('#movieDateInput').focus();
                    event.preventDefault();
                    return;
                }
            });

            // 취소 버튼 클릭 시 확인
            $('#cancelButton').on('click', function () {
                if (confirm("작성 중인 내용을 취소하시겠습니까?")) {
                    location.href = "<c:url value='/movie/list' />";
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
                        <h3>영화 수정</h3>
                    </div>
                    <div class="card-body">
                        <form id="movieForm" action="<c:url value='/movie/update'/>" method="post" enctype="multipart/form-data">
                            <!-- 영화 ID (hidden) -->
                            <input type="hidden" name="movieId" value="${movie.movieId}" />
                            <!-- 영화명 -->
                            <div class="mb-3">
                                <label for="nameInput" class="form-label">영화명</label>
                                <input type="text" class="form-control" id="nameInput" name="name" maxlength="100" value="${movie.name}" required />
                                <div class="form-text">영화명은 필수 입력 항목입니다.</div>
                            </div>
                            <!-- 설명 -->
                            <div class="mb-3">
                                <label for="descriptionInput" class="form-label">설명</label>
                                <textarea id="descriptionInput" name="description" style="height: 300px;" required>${movie.description}</textarea>
                                <div class="form-text">영화 설명을 작성하세요.</div>
                            </div>
                            <!-- 개봉일 -->
                            <div class="mb-3">
                                <label for="movieDateInput" class="form-label">개봉일</label>
                                <input type="date" class="form-control" id="movieDateInput" name="movieDate" required />
                                <div class="form-text">영화 개봉일은 필수 입력 항목입니다.</div>
                            </div> 
                            <!-- 파일 업로드 -->
                            <div class="mb-3">
                                <label class="form-label">파일 업로드</label>
                                <div id="fileInputs">
                                    <!-- 기존 이미지 보여주기 -->
                                    <c:if test="${not empty movie.imgList}">
                                        <h5>현재 이미지 목록</h5>
                                        <c:forEach var="image" items="${movie.imgList}">
                                            <img src="${pageContext.request.contextPath}/movie/upload/${image.imgPath.replace('\\', '/')}/${image.fileName}" 
                                                 alt="${image.fileName}" style="max-width: 100px; margin-right: 10px;"/>
                                        </c:forEach>
                                    </c:if>

                                    <!-- 새 이미지 업로드 필드 -->
                                    <div class="mb-3">
                                        <input type="file" class="form-control file-input" name="files"/>
                                    </div>
                                </div>

                                <!-- 버튼 -->
                                <button type="button" id="addFileButton" class="btn btn-outline-secondary">파일 추가</button>
                                <div class="form-text">최대 5개의 파일을 업로드할 수 있습니다.</div>
                            </div>

                            <!-- 버튼 -->
                            <div class="d-flex justify-content-between">
                                <button type="submit" id="submitButton" class="btn btn-primary">수정</button>
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