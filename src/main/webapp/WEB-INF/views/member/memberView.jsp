<%@ include file="../include/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 본문-->
<section class="about-section text-center" id="about">
	<div class="container px-4 px-lg-5">
		<div class="row gx-4 gx-lg-5 justify-content-center">
			<div class="col-lg-8">
				<h2 class="text-white mb-5">회원 상세</h2>
			</div>
		</div>
	</div>
</section>
<!-- 내용-->
<section class="projects-section bg-dark text-light" id="projects">
	<div class="container px-4 px-lg-5">
		    <div class="container mt-5">
		<div class="row justify-content-center">
			<!-- 가운데 정렬을 위한 클래스 추가 -->
			<div class="col-lg-9">
				<!-- 9칸 차지하는 컬럼 -->
                    <div class="card-body">
                        <!-- 아이디 -->
                        <div class="mb-3">
                            <label for="memberIdInput" class="form-label">아이디</label>
                            <a href="<c:url value='/board/member/boards?memberId=${member.memberId}' />"
                            class="text-decoration-none"  style="color: white;">
									${member.memberId} </a>
                        </div>
                        <!-- 비밀번호 -->
                        <div class="mb-3">
                            <label for="passwordInput" class="form-label">비밀번호</label>
                            <input type="password" class="form-control" id="passwordInput" name="password" 
                                   value="${member.password}" readonly>
                        </div>
                        <!-- 이름 -->
                        <div class="mb-3">
                            <label for="nameInput" class="form-label">이름</label>
                            <input type="text" class="form-control" id="nameInput" name="name" 
                                   value="${member.name}" readonly>
                        </div>
                        <!-- 휴대폰 번호 -->
                     <div class="mb-3">
                        <label for="phoneInput" class="form-label">휴대폰 번호</label> <input
                           type="text" class="form-control" id="phoneInput" name="phone"
                           value="${member.phone}" required>
                     </div>
                        <!-- 이메일 -->
                        <div class="mb-3">
                            <label for="emailInput" class="form-label">이메일</label>
                            <input type="email" class="form-control" id="emailInput" name="email" 
                                   value="${member.email}" readonly>
                        </div>
                        <!-- 버튼 섹션 -->
                          <div class="d-flex justify-content-between">
                          <c:if test="${not empty loginUser and loginUser.roleId == 'admin'}">
                            <button id="updateButton" type="button" class="btn btn-primary">수정</button>
                            <form id="deleteForm" action="<c:url value='/member/delete' />" method="post" >
                                <input type="hidden" name="memberId" value="${member.memberId}">
                                <button id="deleteButton" type="submit" class="btn btn-danger">삭제</button>
                            </form>
                            </c:if>
                              </div>
                              <div class="d-flex justify-content-center">
                            <c:if test="${not empty loginUser and loginUser.roleId == 'member'}">
                            <button id="updateButton" type="button" class="btn btn-dark">수정</button>
                            </c:if>
                      </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 수정 버튼 클릭 이벤트
        document.getElementById("updateButton").addEventListener("click", function() {
            location.href = "<c:url value='/member/update?memberId=${member.memberId}' />";
        });

        // 삭제 버튼 클릭 이벤트
        document.getElementById("deleteButton").addEventListener("click", function(event) {
            if (!confirm("정말 삭제하시겠습니까?")) {
                event.preventDefault(); // 삭제 취소
            }
        });

        // 목록 버튼 클릭 이벤트
        document.getElementById("listButton").addEventListener("click", function() {
            location.href = "<c:url value='/member/list' />";
        });
        
        // URL에서 errorMessage 파라미터 추출
        // new URLSearchParams(window.location.search)는 브라우저 환경에서 URL의 
        // 쿼리 문자열(Query String)을 다루기 위해 사용되는 URLSearchParams 객체를 생성하는 구문입니다. 
        // 이를 통해 URL의 파라미터를 손쉽게 추출하거나 조작할 수 있습니다.
        // window.location.search : 현재 페이지 URL의 쿼리 문자열(질의 문자열)을 반환합니다.
        // RLSearchParams는 JavaScript에서 제공하는 내장 객체로,쿼리 문자열을 쉽게 파싱하고 조작하는 기능 제공 
        const urlParams = new URLSearchParams(window.location.search);
        
        const errorMessage = urlParams.get('errorMessage');

        // 오류 메시지가 존재하면 alert로 표시
        if (errorMessage) {
            alert(decodeURIComponent(errorMessage));
        }        
    </script>
    <%@ include file="../include/footer.jsp" %>
