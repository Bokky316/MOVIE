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
                        <h2 class="text-white mb-4">추천 영화</h2>
						    <div class="gallery-item">
							    <c:if test="${not empty randomMovie}">
							        <a href="<c:url value='/movie/detail/${randomMovie.movieId}'/>">
							            <img src="${pageContext.request.contextPath}/movie/upload/${randomMovie.imgList[0].imgPath}/${randomMovie.imgList[0].fileName}" 
							                 alt="${randomMovie.name}" 
							                 onerror="this.onerror=null; this.src='https://dummyimage.com/450x300/dee2e6/6c757d.jpg';">
							            <div class="movie-title">${randomMovie.name}</div>
							            <div class="movie-info">
							                개봉일: <fmt:formatDate value="${randomMovie.movieDate}" pattern="yyyy-MM-dd"/>
							            </div>
							        </a>
							    </c:if>
							</div>
                        
                        <p class="text-white-50">
                            Grayscale is a free Bootstrap theme created by Start Bootstrap. It can be yours right now, simply download the template on
                            <a href="https://startbootstrap.com/theme/grayscale/">the preview page.</a>
                            The theme is open source, and you can use it for any purpose, personal or commercial.
                        </p>
                    </div>
                </div>
                <img class="img-fluid" src="assets/img/ipad.png" alt="..." />
            </div>
        </section>
        <!-- 랜덤 영화 섹션 -->
<section class="projects-section bg-light" id="random-movies">
    <div class="container px-4 px-lg-5">
        <h2 class="text-center">랜덤 영화 추천</h2>
        <div class="gallery">
            <c:forEach items="${randomMovies}" var="movie">
                <div class="gallery-item">
                    <a href="<c:url value='/movie/detail/${movie.movieId}'/>">
                        <img src="${pageContext.request.contextPath}/movie/upload/${movie.imgList[0].imgPath}/${movie.imgList[0].fileName}" 
                             alt="${movie.name}" 
                             onerror="this.onerror=null; this.src='https://dummyimage.com/450x300/dee2e6/6c757d.jpg';">
                        <div class="movie-title">${movie.name}</div>
                        <div class="movie-info">
                            개봉일: <fmt:formatDate value="${movie.movieDate}" pattern="yyyy-MM-dd"/>
                        </div>
                    </a>
                </div>
            </c:forEach>

            <!-- 랜덤 영화가 없을 경우 메시지 -->
            <c:if test="${empty randomMovies}">
                <div class="col mb-5 text-center">
                    <h5>추천할 영화가 없습니다.</h5>
                </div>
            </c:if>
        </div>
    </div>
</section>



<section class="signup-section" id="signup">
    <div class="container px-4 px-lg-5">
        <div class="row gx-4 gx-lg-5">
            <div class="col-md-10 col-lg-8 mx-auto text-center">
                <i class="far fa-paper-plane fa-2x mb-2 text-white"></i>
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
</section>

        <!-- Contact-->
       <!--  <section class="contact-section bg-black">
            <div class="container px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5">
                    <div class="col-md-4 mb-3 mb-md-0">
                        <div class="card py-4 h-100">
                            <div class="card-body text-center">
                                <i class="fas fa-map-marked-alt text-primary mb-2"></i>
                                <h4 class="text-uppercase m-0">Address</h4>
                                <hr class="my-4 mx-auto" />
                                <div class="small text-black-50">4923 Market Street, Orlando FL</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3 mb-md-0">
                        <div class="card py-4 h-100">
                            <div class="card-body text-center">
                                <i class="fas fa-envelope text-primary mb-2"></i>
                                <h4 class="text-uppercase m-0">Email</h4>
                                <hr class="my-4 mx-auto" />
                                <div class="small text-black-50"><a href="#!">hello@yourdomain.com</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3 mb-md-0">
                        <div class="card py-4 h-100">
                            <div class="card-body text-center">
                                <i class="fas fa-mobile-alt text-primary mb-2"></i>
                                <h4 class="text-uppercase m-0">Phone</h4>
                                <hr class="my-4 mx-auto" />
                                <div class="small text-black-50">+1 (555) 902-8832</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="social d-flex justify-content-center">
                    <a class="mx-2" href="#!"><i class="fab fa-twitter"></i></a>
                    <a class="mx-2" href="#!"><i class="fab fa-facebook-f"></i></a>
                    <a class="mx-2" href="#!"><i class="fab fa-github"></i></a>
                </div>
            </div>
        </section> -->
        <!-- Footer-->
        <footer class="footer bg-black small text-center text-white-50"><div class="container px-4 px-lg-5">Copyright &copy; Your Website 2023</div></footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="${pageContext.request.contextPath}/resources/grash/js/scripts.js"></script>
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <!-- * *                               SB Forms JS                               * *-->
        <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    </body>
</html>
