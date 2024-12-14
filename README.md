# 영화 리뷰 웹사이트 프로젝트

## 📋 목차
1. [사전 준비사항](#사전-준비사항)
2. [실행 순서](#실행-순서)
3. [프로젝트 개요](#프로젝트-개요)
4. [주요 기능](#주요-기능)
5. [기술 스택](#기술-스택)
6. [산출물](#산출물)
7. [프로젝트 구조](#프로젝트-구조)
8. [설치 및 실행](#설치-및-실행)

## 사전 준비사항
1. Java 11 이상 버전 설치
2. Dynamic Web Module 4.0 이상 버전 설정

## 실행 순서
1. DDL(Data Definition Language) 및 DML(Data Manipulation Language) 스크립트 실행
2. Spring Tool Suite(STS)를 사용한 프로젝트 세팅
3. 이미지 파일은 `yyyy/mm/dd` 경로의 폴더에 저장
4. 프로젝트 실행

## 프로젝트 개요
영화 리뷰 웹사이트 구현. 영화, 리뷰, 회원 관리가 핵심 기능이며, 사용자와 콘텐츠가 유기적으로 연결된 구조.

## 주요 기능
1. **영화 관리**
   - 관리자만 영화 등록 가능
   - 영화 상세페이지에서 해당 영화의 리뷰 목록 제공
2. **리뷰 관리**
   - 로그인한 회원만 리뷰 작성 가능
   - 리뷰 수정 및 삭제는 작성자만 가능
   - 리뷰 목록 및 상세페이지에서 작성자 프로필 확인 가능
3. **회원 관리**
   - 회원가입, 로그인, 로그아웃 기능 제공
   - 관리자만 회원 정보 관리 가능
4. **검색 및 추천**
   - 영화/리뷰 목록 페이지에서 검색어 기반 검색 기능 제공
   - 인덱스 페이지에서 랜덤으로 3개의 영화 추천
5. **UI/UX**
   - 헤더(네비게이션 바)를 통해 주요 페이지로 쉽게 접근 가능
   - 로그인 유무 및 관리자 권한에 따라 보이는 버튼 차별화

## 기술 스택
- **Backend**: Java, Spring Boot, MyBatis 
- **Database**: MySQL 데이터베이스 
- **Frontend**: JSP, HTML, CSS, JavaScript 
- **AJAX**: 비동기 통신 구현 
- **Version Control**: Git 및 GitHub 사용 

## 산출물
1. **요구사항 분석서**: 프로젝트의 요구사항과 기능 정의 문서
2. **유스케이스 다이어그램**: 주요 사용 사례 시각적 표현 문서
3. **클래스 다이어그램**: 시스템 클래스 구조 및 관계 정의 문서
4. **ERD**: 데이터베이스 테이블 간 관계 표현 문서
5. **테이블 정의서**: 각 테이블의 스키마 및 속성 정의 문서
6. **프로젝트 설명 PPT**: 프로젝트 주요 개념 및 기능 설명 문서
7. **프로젝트 소스코드**: 전체 프로젝트 파일(코드, 리소스, SQL 스크립트 등)

## 프로젝트 구조 
Java Spring 기반의 영화 리뷰 웹 애플리케이션 구조 설명

### 1. 프로젝트 디렉토리 구조 

src/
├── main/
│   ├── java/
│   │   └── com/
│   │       └── javalab/
│   │           ├── board/
│   │           │   └──advice/
│   │           │    ├── AfterAdvice.java
│   │           │   ├── AfterThrowingAdvice.java
│   │           │   ├── AroundAdvice.java
│   │           │   ├── BeforeAdvice.java
│   │           ├── controller/
│   │           │   ├── BoardController.java
│   │           │   ├── HomeController.java
│   │           │   ├── LoginController.java
│   │           │   ├── MemberController.java
│   │           │   └── MovieController.java
│   │           ├── dto/
│   │           │   ├── Criteria.java
│   │           │   ├── PageDto.java
│   │           │   └── ReplyDto.java
│   │           ├── exception/
│   │           │   ├── ControllerAdviceHandler.java
│   │           │   └── UnauthorizedAccessException.java
│   │           ├── interceptor/
│   │           │   ├── LoginInterceptor.java
│   │           │   └── LogoutInterceptor.java
│   │           ├── repository/
│   │           │   ├── BoardRepository.java
│   │           │   ├── LoginRepository.java
│   │           │   ├── MemberRepository.java
│   │           │   └── MovieRepository.java
│   │           └── service/
│   │               ├── BoardService.java
│   │               ├── LoginService.java
│   │               ├── MemberService.java
│   │               └── MovieService.java
│   └── resources/
│   │    ├── config/
│   │    │   ├── log4j.xml
│   │    │    ├── log4jdbc.log4j2.properties
│   │    │    └── logback.xml
│   │    └── com/
│   │       └── javalab/  
│   │       └── board/
│   │      	   └── repository/  
│   │      		  ├── BoardMapper.xml
│   │     		  ├── LoginMapper.xml
│   │     		  ├── MemberMapper.xml
│   │     		  └── MovieMapper.xml
│   └── webapp/
│           └──  WEP-INF/
 |                 └── view
│  		          └── board/
│          	        │   ├── boardInsert.jsp
│                     │   ├── boardList.jsp
│                     │   ├── boardsByMember.jsp
│                     │   ├── boardUpdate.jsp
│                     │   └── boardView.jsp
│                     ├── include/
│                     │   ├── footer.jsp
│                     │   └── header.jsp
│                     ├── login/
│                     │   └── login.jsp
│                     ├── member/
│                     │   ├── memberInsert.jsp
│                     │   ├── memberList.jsp
│                     │   ├── memberUpdate.jsp
│                     │   └── memberView.jsp
│                     ├── movie/
│                     │   ├── movieCreate.jsp
│                     │   ├── movieList.jsp
│                     │   ├── movieDetail.jsp
│                     │   ├── movieUpdate.jsp
│                     │   └── uploadFailuew.jsp
│                     ├── error.jsp
│                     └── index.jsp
└── pom.xml

### 2. 주요 디렉토리 및 파일 설명 

#### 2.1 `java/com/javalab/board`
- **advice/**: AOP(Aspect-Oriented Programming) 관련 클래스들.
- `AfterAdvice.java`: 메서드 실행 후 처리 클래스.
- `BeforeAdvice.java`: 메서드 실행 전 처리 클래스.
- `AroundAdvice.java`: 메서드 실행 전후 처리 클래스.
- `AfterThrowingAdvice.java`: 예외 발생 시 처리 클래스.

- **controller/**: 클라이언트 요청 처리 컨트롤러 클래스들.
- `BoardController.java`: 게시물 관련 요청 처리 클래스.
- `HomeController.java`: 홈 페이지 요청 처리 클래스.
- `LoginController.java`: 로그인 관련 요청 처리 클래스.
- `MemberController.java`: 회원 관련 요청 처리 클래스.
- `MovieController.java`: 영화 관련 요청 처리 클래스.

- **dto/**: 데이터 전송 객체(DTO) 포함.
- `Criteria.java`: 페이징 및 검색 정보 저장 클래스.
- `PageDto.java`: 페이지 정보 저장 클래스.
- `ReplyDto.java`: 댓글 정보 저장 클래스.

- **exception/**: 사용자 정의 예외 및 예외 처리 클래스들.
- `ControllerAdviceHandler.java`: 전역 예외 처리 클래스.
- `UnauthorizedAccessException.java`: 권한 없는 접근 예외 클래스.

- **interceptor/**: 요청과 응답 가로채기 인터셉터 클래스들.
- `LoginInterceptor.java`: 로그인 상태 확인 인터셉터.
- `LogoutInterceptor.java`: 로그아웃 처리 인터셉터.

- **repository/**: 데이터베이스와 상호작용하는 리포지토리 클래스들.
- `BoardRepository.java`, `LoginRepository.java`, `MemberRepository.java`, `MovieRepository.java`: 각각 게시물, 로그인, 회원, 영화 데이터베이스 작업 수행 인터페이스.

- **service/**: 비즈니스 로직 구현 서비스 클래스들.
- `BoardService.java`, `LoginService.java`, `MemberService.java`, `MovieService.java`: 각각 게시물, 로그인, 회원, 영화 비즈니스 로직 구현 서비스 클래스.

#### 2.2 `resources/`
- **config/**: 애플리케이션 설정 파일 포함.
- `log4j.xml`, `log4jdbc.log4j2.properties`, `logback.xml`: 로깅 설정 파일들.

#### 2.3 `webapp/`
- **WEB-INF/**: 웹 애플리케이션 구성 요소 포함, 직접 접근 불가.
  
- **view/**: JSP 파일들이 위치한 디렉토리로 클라이언트에게 보여질 UI 정의.

### 3. 기술 스택 
- **Backend**: Java, Spring Boot, MyBatis 
- **Database**: MySQL 데이터베이스 
- **Frontend**: JSP, HTML, CSS, JavaScript 
- **AJAX**: 비동기 통신 구현 
- **Version Control**: Git 및 GitHub 사용 

### 4. 주요 기능 
1. 게시물 CRUD 작업 
2. 회원가입 및 로그인 기능 
3. 영화 등록 및 관리 기능 
4. 리뷰 작성 및 관리 기능 

### 5. 설치 및 실행 
1. JDK 11 이상 설치 
2. Maven을 통한 의존성 관리 
3. Tomcat 서버 설정 


