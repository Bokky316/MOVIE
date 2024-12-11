package com.javalab.board.advice;

import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Service;

/**
 * After Advice
 * - 타겟 메소드(포인트컷) 실행 후에 적용되는 메소드를 갖고 있는 어드바이스
 */
//@Service
@Aspect
public class AfterAdvice {	
	public AfterAdvice() {		
	}
	/*
	 * 포인트컷 정의
	 * XML에 설정했던 포인트컷을 어노테이션 방식으로 적용
	 *  - allPointCut 메소드 : 별다른 역할은 없고 단지 포인트컷 한정식을 위한 용도임.
	 *  - getPointCut 메소드 : 별다른 역할은 없고 단지 포인트컷 한정식을 위한 용도임.
	 */
	@Pointcut("execution(* com.javalab.board..*Impl.*(..))")
	public void allPointCut(){}
	
	@Pointcut("execution(* com.javalab.board..*Impl.get*(..)) "	// 아랫문장 띄어쓰지 말고 이어서 코딩하세요.
			+ "&& !execution(* com.javalab.board..*Impl.getTotal*(..))")
	public void getPointCut(){}	
	
	
	// 어드바이스 + 시점 = Aspect 역할
	@After("getPointCut()")
	public void finallyLog(){
		System.out.println("[AfterAdvice - 사후처리] 타겟 메소드 실행 후에 수행됩니다.");
	}


}
