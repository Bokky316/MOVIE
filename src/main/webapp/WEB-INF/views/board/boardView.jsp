<%@ include file="../include/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

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

<!-- 내용-->
<section class="projects-section bg-light" id="projects">
	<div class="container px-4 px-lg-5">
		<div class="card-body">
        <!-- 오류 메시지 표시 -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger" role="alert">
                ${errorMessage}
            </div>
        </c:if>
            <!-- 제목 -->
            <div class="mb-3">
                <label class="form-label"><strong>제목</strong></label>
                <input type="text" class="form-control" value="${board.title}" readonly>
            </div>
            <!-- 내용 -->
            <div class="mb-3">
                <label class="form-label"><strong>내용</strong></label>
                <textarea class="form-control" rows="5" readonly>${board.content}</textarea>
            </div>
            <!-- 작성자 ID -->
            <div class="mb-3">
                <label class="form-label"><strong>작성자 ID</strong></label>
                <input type="text" class="form-control" value="${board.memberId}" readonly>
            </div>
            <!-- 조회수 -->
            <div class="mb-3">
                <label class="form-label"><strong>조회수</strong></label>
                <input type="text" class="form-control" value="${board.hitNo}" readonly>
            </div>
            <!-- 작성일 -->
            <div class="mb-3">
                <label class="form-label"><strong>작성일</strong></label>
                <input type="text" class="form-control"
                       value="<fmt:formatDate value='${board.regDate}' pattern='yyyy-MM-dd HH:mm:ss' />" readonly>
            </div>
            <div class="d-flex justify-content-end gap-2">
                <button id="updateButton" type="button" class="btn btn-update">수정</button>
                <form id="deleteForm" action="<c:url value='/board/delete' />" method="post" class="d-inline">
                    <input type="hidden" name="boardNo" value="${board.boardNo}">
                    <button id="deleteButton" type="submit" class="btn btn-delete">삭제</button>
                </form>
                <!-- 답글쓰기 버튼 -->
                <button id="replyButton" type="button" class="btn btn-warning">답글쓰기</button>
                <button id="listButton" type="button" class="btn btn-list">목록으로</button>
            </div>
        </div> <!-- 카드 바디 닫는 태그 추가 -->
    </div> <!-- 컨테이너 닫기 -->
</section>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 수정 버튼 클릭 이벤트
    document.getElementById("updateButton").addEventListener("click", function() {
        location.href = "<c:url value='/board/update?boardNo=${board.boardNo}' />";
    });

    // 삭제 버튼 클릭 이벤트
    document.getElementById("deleteForm").addEventListener("submit", function(event) {
        if (!confirm("정말 삭제하시겠습니까?")) {
            event.preventDefault(); // 삭제 취소
        }
    });

    // 답글쓰기 버튼 클릭 이벤트
    document.getElementById("replyButton").addEventListener("click", function() {
        location.href = "<c:url value='/board/reply?parentBoardNo=${board.boardNo}' />";
    });

    // 목록 버튼 클릭 이벤트
    document.getElementById("listButton").addEventListener("click", function() {
        location.href = "<c:url value='/board/list' />";
    });
</script>

<%@ include file="../include/footer.jsp"%>