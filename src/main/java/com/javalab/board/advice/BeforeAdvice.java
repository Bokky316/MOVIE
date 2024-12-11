package com.javalab.board.advice;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Service;

/**
 * BeforeAdvice 를 어노테이션 방식으로 적용
 * @Service 어노테이션
 *  - 본 어드바이스가 스프링 컨테이너에의해서 적용되기 위해서는 root-context.xml에 
 *    빈등록(XML) 되어 있거나 객체로 생성되어 있어야 한다. 그래서 @Service 붙어 있어야 한다.
 * @Aspect : XML에 설정했던 애스펙트를 어노테이션 방식으로 적용하겠다는 의미임.
 * 	이 클래스가 AspectJ 어노테이션을 사용한 AOP 구성 클래스임
 */
//@Service
@Aspect
public class BeforeAdvice {

	public BeforeAdvice() {
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
	 * 어드바이스 정의
	 * - 어드바이스 + 시점 = Aspect 역할
	 * - "getPointCut()" : 위에서 정의해놓은 포인트컷 메소드명
	 */
	@Before("getPointCut()")	// @Before : 적용시점, allPointCut() : 한정식 정의 메소드  
	public void beforeLog(JoinPoint jp){ // JoinPoint : 타겟메소드 정보(파라미터 포함)
		String method = jp.getSignature().getName(); // 타겟메소드명
		Object[] args = jp.getArgs();	// 파라미터
		
		System.out.println("[어노테이션 방식의 BeforeAdvice] 타겟 메소드 실행 전에 수행됩니다.");
	}
}
