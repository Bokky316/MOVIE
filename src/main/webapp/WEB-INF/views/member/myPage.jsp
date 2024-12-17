<%@ include file="../include/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 본문-->
<section class="about-section text-center" id="about">
	<div class="container px-4 px-lg-5">
		<div class="row gx-4 gx-lg-5 justify-content-center">
			<div class="col-lg-8">
				<h2 class="text-white mb-5">${loginUser.memberId}님의마이페이지</h2>
			</div>
		</div>
	</div>
</section>
<!-- 내용-->
<section class="projects-section bg-dark text-light" id="projects">
    <div class="container px-4 px-lg-5">
        <div class="card-body">
            <!-- 오류 메시지 표시 -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger" role="alert">
                    ${errorMessage}
                </div>
            </c:if>

            <!-- 회원 정보 -->
            <div class="mb-4">
                <h3 class="text-white mb-3">회원 정보</h3>
                <div class="d-flex flex-column">
                    <div class="mb-2">
                        <strong>아이디 |</strong> 
                        <span class="text-white">${member.memberId}</span>
                    </div>
                    <div class="mb-2">
                        <strong>이메일 |</strong> 
                        <span class="text-white">${member.email}</span>
                    </div>
                </div>
            </div>

            <!-- 링크 섹션 -->
            <div class="d-flex flex-column">
                <a href="<c:url value='/member/view?memberId=${member.memberId}' />" 
                   class="btn btn-outline-light mb-2">
                    나의 정보 상세보기
                </a>
                <a href="<c:url value='/board/member/boards?memberId=${member.memberId}' />" 
                   class="btn btn-outline-light">
                    나의 리뷰 보기
                </a>
            </div>
        </div>
    </div>
</section>

<%@ include file="../include/footer.jsp"%>

