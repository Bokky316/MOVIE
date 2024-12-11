package com.javalab.board.advice;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Service;

/**
 * After Throwing Advice
 * - 타겟 메소드(포인트컷) 실행중 예외가 발생했을 때 처리를 담당하는 클래스
 * @Service : 이 클래스가 빈으로 생성될 수 있도록 하는 기능(XML에 bean설정해야 되었던 부분)
 * @Aspect : 이 클래스가 Advice 기능과 애스펙트 기능이 함께 있음을 알린다.
 * - 애스펙트 : 어드바이스가 어느 포인트컷에 어느 시점에 적용되어야 할지에 대한 설정(3가지 요소)
 */
@Service
@Aspect
public class AfterThrowingAdvice {	
	public AfterThrowingAdvice() {		
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
	
	
	/*
     * 타겟 메소드 실행 중 예외가 발생하면 이 메소드가 호출된다.
     * @AfterThrowing : 예외 발생 후 실행
     * pointcut : 적용할 포인트컷 정의
     * throwing : 발생한 예외를 전달받을 변수 이름
     */
    @AfterThrowing(pointcut = "allPointCut()", throwing = "exceptObj")
    public void exceptionLog(JoinPoint jp, Exception exceptObj) {
        String methodName = jp.getSignature().getName(); // 타겟 메소드 이름
        System.out.println("[AfterThrowingAdvice 예외처리] 메소드명: " + methodName);
        System.out.println("[AfterThrowingAdvice 예외처리] 예외 메시지: " + exceptObj.getMessage());
    }
}
