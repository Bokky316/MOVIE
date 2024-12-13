
<%@ include file="include/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


        <!-- Masthead-->
        <header class="masthead">
            <div class="container px-4 px-lg-5 d-flex h-100 align-items-center justify-content-center">
                <div class="d-flex justify-content-center">
                    <div class="text-center">
                        <h1 class="mx-auto my-0 text-uppercase">무비무빗</h1>
                        <h2 class="text-white-50 mx-auto mt-2 mb-5">당신의 영화 여정을 한 편의 스토리처럼 만들어가는 영화 리뷰 플랫폼</h2>
                        <a class="btn btn-primary" href="#about">Get Started</a>
                    </div>
                </div>
            </div>
        </header>
        <!-- About-->
        <section class="about-section text-center" id="about">
            <div class="container px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-lg-8">
                        <h2 class="text-white mb-5">영화 제목을 검색하세요.</h2>
                <!-- 검색 폼 -->
                <form class="form-signup" id="searchForm" action="<c:url value='/movie/list' />" method="get">
                    <!-- 영화 제목 입력 -->
                    <div class="row input-group-newsletter">
                        <div class="col">
                            <input class="form-control" type="text" name="searchText" id="searchText" placeholder="영화 제목을 검색하세요" required>
                        </div>
                        <div class="col-auto">
                            <button type="submit" class="btn btn-info me-2">검색</button>
                        </div>
                    </div>
                    <!-- 유효성 검사 메시지 -->
                    <div class="invalid-feedback mt-2" data-sb-feedback="searchText:required">영화 제목이 필요합니다.</div>
                </form>
            </div>
        </div>
    </div>
    <!-- Projects-->  
   <section class="projects-section bg-light" id="projects">
		<div class="container px-4 px-lg-5">
			<!-- Featured Project Row-->
			<div class="row gx-0 mb-4 mb-lg-5 align-items-center">
				<div class="col-xl-8 col-lg-7">
					<img class="img-fluid mb-3 mb-lg-0"
						src="assets/img/bg-masthead.jpg" alt="..." />
				</div>
				<div class="col-xl-4 col-lg-5">
					<div class="featured-text text-center text-lg-left">
						<h4>Shoreline</h4>
						<p class="text-black-50 mb-0">Grayscale is open source and MIT
							licensed. This means you can use it for any project - even
							commercial projects! Download it, customize it, and publish your
							website!</p>
					</div>
				</div>
			</div>   
        
   <!-- Project Two Row-->
			

<c:forEach items="${randomMovies}" var="movie">
			<div class="row gx-0 justify-content-center">
				<div class="col-lg-6">
				    <a href="<c:url value='/movie/detail/${movie.movieId}'/>">
				        <img class="img-fluid mb-3 mb-lg-0" 
				             src="${pageContext.request.contextPath}/movie/upload/${movie.imgList[0].imgPath}/${movie.imgList[0].fileName}" 
				             alt="${movie.name}" 
				             onerror="this.onerror=null; this.src='https://dummyimage.com/670x480/dee2e6/6c757d.jpg';" 
				             style="width: 670px; height: 480px; object-fit: cover;">
				    </a> 
				</div>

				<div class="col-lg-6 order-lg-first">
					<div class="bg-black text-center h-100 project">
						<div class="d-flex h-100">
							<div class="project-text w-100 my-auto text-center text-lg-right">
								<h4 class="text-white">${movie.name}</h4>
								<p class="mb-0 text-white-50">
									개봉일:
									<fmt:formatDate value="${movie.movieDate}" pattern="yyyy-MM-dd" />
								</p>
								<p class="text-white-50">${movie.description}</p>
								<!-- 영화 설명 추가 -->
							</div>
						</div>
					</div>
				</div>
			</div>
			</c:forEach>

			<!-- 랜덤 영화가 없을 경우 메시지 -->
			<c:if test="${empty randomMovies}">
				<div class="col mb-5 text-center">
					<h5>추천할 영화가 없습니다.</h5>
				</div>
			</c:if> 

                </div>
        </section> 
        <%@ include file="../include/footer.jsp" %>
      