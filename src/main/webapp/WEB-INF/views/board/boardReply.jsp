<%@ include file="../include/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<head>
<!-- CKEditor 5 CDN -->
<script
	src="https://cdn.ckeditor.com/ckeditor5/39.0.2/classic/ckeditor.js"></script>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<!-- 본문-->
<section class="about-section text-center" id="about">
	<div class="container px-4 px-lg-5">
		<div class="row gx-4 gx-lg-5 justify-content-center">
			<div class="col-lg-8">
				<h2 class="text-white mb-5">답글작성</h2>
			</div>
		</div>
	</div>
</section>

<!-- 내용-->
<section class="projects-section bg-dark" id="projects">
	<div class="container px-4 px-lg-5">
		<div class="container mt-5">
			<div class="row justify-content-center">
				<div class="col-md-8">
					<!-- 부모 게시물 정보 -->
					<div class="mb-3">
						<h5>
							<!-- 영화 제목에 링크 추가 -->
							<a
								href="<c:url value='/movie/detail/${parentBoard.movieWithImage.movieId}' />"
								class="text-decoration-none"> <strong>${parentBoard.movieWithImage.name}</strong>
							</a> <span style="font-size: 0.9em; color: gray;"> <!-- 작은 글씨로 개봉일 표시 -->
								<fmt:formatDate value='${parentBoard.movieWithImage.movieDate}'
									pattern='yyyy-MM-dd' /> 개봉
							</span>
						</h5>
					</div>

					<div class="card">
						<div class="card-header text-center"></div>
						<div class="card-body">
							<div class="mb-3">
								<label for="parentInfo" class="form-label"> <a
									href="<c:url value='/board/view?boardNo=${parentBoard.boardNo}' />">
										<strong>${parentBoard.title}</strong></a> <span
									style="font-size: 0.9em; color: gray;">
										${parentBoard.memberId} </span>
								</label>
								<!-- 자식 게시물 정보 -->
								<br><br>								
								<form id="replyForm" action="<c:url value='/board/reply' />"
									method="post">
									<!-- 작성자 ID -->
									<div class="mb-3">
										<label for="memberIdInput" class="form-label">작성자 ID</label> <input
											type="text" class="form-control" id="memberIdInput"
											name="memberId" value="${sessionScope.loginUser.memberId}"
											readonly required>
									</div>

									<!-- 제목 -->
									<div class="mb-3">
										<label for="titleInput" class="form-label">제목</label> <input
											type="text" class="form-control" id="titleInput" name="title"
											maxlength="100" required>
										<div class="form-text">제목은 100자 이내로 작성해주세요.</div>
									</div>

									<!-- 내용 -->
									<div class="mb-3">
										<label for="contentInput" class="form-label">내용</label>
										<textarea class="form-control" id="contentInput"
											name="content" rows="5" maxlength="500" required></textarea>
										<div class="form-text">내용은 500자 이내로 작성해주세요.</div>
									</div>

									<!-- 스포일러 포함 여부 -->
									<div class="mb-3">
										<label for="spoilerCheck" class="form-label">스포일러 포함
											여부</label> <input type="checkbox" id="spoilerCheck" name="spoiler"
											value="Y">
										<div class="form-text" style="font-size: 12px;">스포일러가
											포함된 경우 체크해주세요.</div>
									</div>

									<!-- 숨겨진 필드 (계층 구조 정보) -->
									<input type="hidden" name="replyGroup"
										value="${parentBoard.replyGroup}"> <input
										type="hidden" name="replyOrder"
										value="${parentBoard.replyOrder}"> <input
										type="hidden" name="replyIndent"
										value="${parentBoard.replyIndent}">

									<!-- 버튼 -->
									<div class="d-flex justify-content-between">
										<button type="submit" id="submitButton"
											class="btn btn-primary">등록</button>
										<button type="button" id="cancelButton"
											class="btn btn-secondary">취소</button>
									</div>
								</form>
							</div>
						</div>
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
	$(document).ready(function() {
		// 폼 제출 시 유효성 검사
		$('#replyForm').on('submit', function(event) {
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
		$('#cancelButton').on('click', function() {
			if (confirm("작성 중인 내용을 취소하시겠습니까?")) {
				location.href = "<c:url value='/board/list' />";
			}
		});
	});
</script>

<%@ include file="../include/footer.jsp"%>
