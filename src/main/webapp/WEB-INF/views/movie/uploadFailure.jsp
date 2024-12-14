<%@ include file="../include/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 본문-->
<section class="about-section text-center" id="about">
   <div class="container px-4 px-lg-5">
      <div class="row gx-4 gx-lg-5 justify-content-center">
         <div class="col-lg-8">
            <h2 class="text-white mb-5">영화등록 실패</h2>
            <!-- c:url로 영화 목록으로 이동 -->
			<a href="<c:url value='/movie/list'/>">영화 목록으로 이동</a>
         </div>
      </div>
   </div>
</section>

<%@ include file="../include/footer.jsp" %>