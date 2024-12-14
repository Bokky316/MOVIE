package com.javalab.board.advice;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Service;

/**
 * Around Advice
 * - 타겟 메소드(포인트컷) 실행 전후에 적용되는 메소드를 갖고 있는 어드바이스
 * @Service : 이 클래스가 빈으로 생성될 수 있도록 하는 기능(XML에 bean설정해야 되었던 부분)
 * @Aspect : 이 클래스가 Advice 기능과 애스펙트 기능이 함께 있음을 알린다.
 * - 애스펙트 : 어드바이스가 어느 포인트컷에 어느 시점에 적용되어야 할지에 대한 설정(3가지 요소)
 */
//@Service
//@Aspect
public class AroundAdvice {	
	public AroundAdvice() {		
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
	
	
	/**
     * 어라운드 어드바이스 정의
     * - @Around: 메소드 실행 전후에 동작
     * - pointcut: 어드바이스가 적용될 포인트컷
     */
    @Around("getPointCut()")
    public Object aroundLog(ProceedingJoinPoint pjp) throws Throwable {
        System.out.println("[AroundAdvice - Before] : 타겟 메소드 수행 전에 실행 ==========================");

        // 타겟 메소드를 실행
        Object returnObj = null;
        try {
            returnObj = pjp.proceed();
        } catch (Throwable throwable) {
            System.out.println("[AroundAdvice - Exception] : 예외 발생 ==========================");
            throw throwable; // 예외를 다시 던짐
        }

        System.out.println("[AroundAdvice - After] : 타겟 메소드 수행 후에 실행 ==========================");

        return returnObj;
    }
}
