<%@ include file="../include/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
	<!-- CKEditor 5 CDN -->
    <script src="https://cdn.ckeditor.com/ckeditor5/39.0.2/classic/ckeditor.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>


<!-- 본문-->
<section class="about-section text-center" id="about">
   <div class="container px-4 px-lg-5">
      <div class="row gx-4 gx-lg-5 justify-content-center">
         <div class="col-lg-8">
            <h2 class="text-white mb-5">영화 수정</h2>
         </div>
      </div>
   </div>
</section>

<!-- 내용-->  
<section class="projects-section bg-light" id="projects">
   <div class="container px-4 px-lg-5">

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
	         
	         <!-- 장르 -->
             <div class="mb-3">
                 <label for="genreInput" class="form-label">장르</label>
                 <input type="text" class="form-control" id="genreInput" name="genre" required />
                 <div class="form-text">장르는 필수 입력 항목입니다.</div>
             </div>

             <!-- 상영 시간 -->
             <div class="mb-3">
                 <label for="runningTimeInput" class="form-label">상영 시간</label>
                 <input type="text" class="form-control" id="runningTimeInput" name="runningTime" required />
                 <div class="form-text">상영 시간은 필수 입력 항목입니다.</div>
             </div>

             <!-- 별점 -->
             <div class="mb-3">
                 <label for="ratingInput" class="form-label">별점</label>
                 <input type="text" class="form-control" id="ratingInput" name="rating" required />
                 <div class="form-text">별점은 필수 입력 항목입니다.</div>
             </div>

             <!-- 연령 등급 -->
             <div class="mb-3">
                 <label for="ageRatingInput" class="form-label">연령 등급</label>
                 <input type="text" class="form-control" id="ageRatingInput" name="ageRating" required />
                 <div class="form-text">연령 등급은 필수 입력 항목입니다.</div>
             </div>

             <!-- 감독 -->
             <div class="mb-3">
                 <label for="directorInput" class="form-label">감독</label>
                 <input type="text" class="form-control" id="directorInput" name="director" required />
                 <div class="form-text">감독은 필수 입력 항목입니다.</div>
             </div>

             <!-- 출연 배우 -->
             <div class="mb-3">
                 <label for="castInput" class="form-label">출연 배우</label>
                 <input type="text" class="form-control" id="castInput" name="cast" required />
                 <div class="form-text">출연 배우는 필수 입력 항목입니다.</div>
             </div>
	
	        <!-- 기존 이미지 목록 -->
			<h5>현재 이미지 목록</h5>
			<c:if test="${not empty movie.imgList}">
				<div class='image-container mb-3'>
				    <c:forEach var='image' items='${movie.imgList}'>
						<div class='image-item mb-2 position-relative'>
						    <img src="${pageContext.request.contextPath}/movie/upload/${image.imgPath.replace('\\', '/')}/${image.fileName}" 
						         alt="${image.fileName}" style='max-width: 100%; height: auto;'>
						    <!-- 삭제 체크박스 추가 -->
						    <input type='checkbox' name='existingImageIds' value='${image.imgId}' style='display:none;' />
						    <!-- 회색의 X 표시 추가 -->
						    <span class="remove-button" style="position:absolute; top:0; right:0; cursor:pointer; color:gray; background-color:white; padding:2px; border-radius:50%;">✖</span>
						</div>
					</c:forEach>
				</div>
			</c:if>

		    <!-- 새 이미지 업로드 -->
	        <h5>파일 업로드</h5>
	        <div id='fileInputs' class='mb-3'>
	            <input type='file' class='form-control file-input' name='files' />
	        </div>
	        <button type='button' id='addFileButton' class='btn btn-outline-secondary'>파일 추가</button>
	        
			<!-- 버튼 -->
	         <div class='d-flex justify-content-between mt-3'>
	             <button type='submit' id='submitButton' class='btn btn-primary'>수정</button>
	             <button type='button' id='cancelButton' class='btn btn-secondary'>취소</button>
	         </div>
	        
	     </form>
	 </div>
   </div>
</section>

    <!-- Bootstrap JS -->
    <script src='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js'></script>
    
    <script>
        let editorInstance;

        $(document).ready(function () {
            // CKEditor 초기화
            ClassicEditor
                .create(document.querySelector('#descriptionInput'))
                .then(editor => {
                    editorInstance = editor;
                    const editorContainer = editor.ui.view.editable.element;
                    editorContainer.style.height = "200px"; // 에디터 높이 설정
                })
                .catch(error => {
                    console.error(error);
                });
         // 이미지 제거 함수 
            function removeImage(element) {
                const imageItem = element.closest('.image-item');
                const hiddenCheckbox = imageItem.querySelector('input[type="checkbox"]');

                if (hiddenCheckbox) {
                    // 체크 상태에 따라 이미지의 투명도 조정
                    if (hiddenCheckbox.checked) {
                        hiddenCheckbox.checked = false; // 체크 해제
                        imageItem.style.opacity = '1'; // 원래 상태로 복원
                    } else {
                        hiddenCheckbox.checked = true; // 체크
                        imageItem.style.opacity = '0.5'; // 연하게 보이게
                    }
                } else {
                    // 새 이미지 삭제 (이 부분은 필요에 따라 수정)
                    imageItem.remove();
                }
            }

            // X 버튼에 이벤트 리스너 추가
            document.querySelectorAll('.image-item span').forEach(span => {
                span.addEventListener('click', (e) => removeImage(e.target));
            });

            // 동적 파일 추가
            $('#addFileButton').on('click', function () {
                const fileCount = $('.file-input').length;
                if (fileCount < 5) {
                    $('#fileInputs').append(`
                        <div class="mb-3">
                            <input type="file" class="form-control file-input" name="files" />
                        </div>
                    `);
                } else {
                    alert("파일은 최대 5개까지 업로드할 수 있습니다.");
                }
            });

            // 유효성 검사 및 CKEditor 데이터 동기화
            $('#movieForm').on('submit', function (event) {
                const name = $('#nameInput').val().trim();
                const movieDate = $('#movieDateInput').val().trim();
                const genre = $('#genreInput').val().trim();
                const runningTime = $('#runningTimeInput').val().trim();
                const rating = $('#ratingInput').val().trim();
                const ageRating = $('#ageRatingInput').val().trim();
                const director = $('#directorInput').val().trim();
                const cast = $('#castInput').val().trim();

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
                
            	// 새로운 필드들에 대한 유효성 검사 추가
                if (genre === "") {
                    alert("영화 장르를 입력하세요.");
                    $('#genreInput').focus();
                    event.preventDefault();
                    return;
                }

                if (runningTime === "") {
                    alert("상영 시간을 입력하세요.");
                    $('#runningTimeInput').focus();
                    event.preventDefault();
                    return;
                }

                if (rating === "") {
                    alert("별점을 입력하세요.");
                    $('#ratingInput').focus();
                    event.preventDefault();
                    return;
                }

                if (ageRating === "") {
                    alert("연령 등급을 입력하세요.");
                    $('#ageRatingInput').focus();
                    event.preventDefault();
                    return;
                }

                if (director === "") {
                    alert("감독 이름을 입력하세요.");
                    $('#directorInput').focus();
                    event.preventDefault();
                    return;
                }

                if (cast === "") {
                    alert("출연 배우를 입력하세요.");
                    $('#castInput').focus();
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

<%@ include file="../include/footer.jsp" %>