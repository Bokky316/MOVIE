<%@ include file="include/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="container mt-5">
	<!-- 페이지 헤더 -->
	<div class="d-flex justify-content-between align-items-center mb-3">

		
		<a href="<c:url value='/movie/list' /> ">영화 목록</a> <br> <a
			href="<c:url value='/board/list' /> ">리뷰 목록</a> <br> <a
			href="<c:url value='/member/list' /> ">회원 목록</a>

	</div>
	<!-- Bootstrap JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<%@ include file="include/footer.jsp"%>