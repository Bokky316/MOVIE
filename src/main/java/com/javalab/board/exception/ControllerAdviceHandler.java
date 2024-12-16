package com.javalab.board.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;
import org.springframework.http.HttpStatus;


/**
 * 컨트롤러 어드바이스
 * - 컨트롤러에서 발생하는 또는 컨트롤러로 던져지는 예외를 처리하는 클래스이다.
 * - 서비스 레이어 등에서 발생하는 예외를 컨트롤러로 모아서 한곳에서 처리할 수 있다.
 * - 하지만 서비스 레이어에서 발생하는 예외를 컨트롤러로 던지지 않으면 처리할 수 없다.
 * 컨트롤러 어드바이스가 잡을 수 있는 예외
 * - 컨트롤러 자체에서 발생한 예외
 * - 서비스 레이어에서 발생하여 컨트롤러로 전파(던져지면)되는 예외
 * - 스프링에서 처리하는 일반적인 HTTP 예외(404등)
 * 매퍼 인터페이스에 예외처리를 넣지 않는 이유?
 * - MyBatis는 스프링과 통합되어 있을 때 예외를 스프링의 데이터 액센스 예외 계층으로 변환하고
 * 	 서비스 계층으로 전파되기 때문에 서비스 계층에서 예외를 처리하면 된다. 그리고 리포지토리 계층은
 * 	 서비스 계층과 달리 단일 쿼리 작업으로 진행되는 경우가 많기 때문에 모든 메소드에 예외처리 비추천됨.
 * 	 
 *
 */
@ControllerAdvice
public class ControllerAdviceHandler {

	/**
	 * RuntimeException 처리
	 */
	@ExceptionHandler(RuntimeException.class)
	public ModelAndView handleRuntimeException(RuntimeException ex) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("errorMessage", ex.getMessage());
		mav.setViewName("error/500"); // 에러 페이지로 이동
		return mav;
	}
	
	@ExceptionHandler(NoHandlerFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public ModelAndView handleNoHandlerFoundException(NoHandlerFoundException ex) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("errorMessage", "요청하신 페이지를 찾을 수 없습니다.");
        mav.setViewName("error/404"); // 404 에러 페이지로 이동
        return mav;
    }

	/**
	 * Exception 처리 (모든 예외)
	 */
	@ExceptionHandler(Exception.class)
	public ModelAndView handleException(Exception ex) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("errorMessage", "예기치 못한 오류가 발생했습니다: " + ex.getMessage());
		mav.setViewName("error/500"); // 공통 에러 페이지
		return mav;
	}
}
