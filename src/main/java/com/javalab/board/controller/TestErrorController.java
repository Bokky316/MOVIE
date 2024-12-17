package com.javalab.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 *  에러 페이지를 테스트하기 위한 테스트에러 컨트롤러. 
 *  - 404 에러는 페이지 경로 오류로, 존재하지 않는 페이지를 띄우는 형식으로 테스트.
 *- 컨트롤러에 의도적으로 예외를 발생시키는 테스트 엔드포인트를 만듦. (500)
 *- 다른 예외를 발생시키는 테스트 엔드포인트를 주가해 기타 오류 테스트.
 */
@Controller
public class TestErrorController {
	
	// http://localhost:8080${pageContext.request.contextPath}/non-existent-page
	
	// http://localhost:8080${pageContext.request.contextPath}/test-500
	@GetMapping("/test-500")
    public String testInternalServerError() {
        throw new RuntimeException("This is a test 500 error");
    }
	
	// http://localhost:8080${pageContext.request.contextPath}/test-exception
	@GetMapping("/test-exception")
	public String testException() throws Exception {
	    throw new Exception("This is a test general exception");
	}
}
