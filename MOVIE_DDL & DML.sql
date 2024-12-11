<<<<<<< HEAD
---- 1. 유저 확인 및 계정 생성
--show user;
--
--/* sys에서 작업 */
--CREATE USER mreview IDENTIFIED BY 1234;
--GRANT CONNECT, RESOURCE TO mreview;
--GRANT UNLIMITED TABLESPACE TO mreview;

/* mreview 접속 생성 */

/* 2. 테이블 생성  */
CREATE TABLE ROLE (
   ROLE_ID   VARCHAR2(20)   NOT NULL,    -- 등급 번호(기본키)
   ROLE_NAME   VARCHAR2(20)   NOT NULL,  -- 등급 이름
  CONSTRAINT PK_ROLE PRIMARY KEY (ROLE_ID)   -- 기본키제약
);


/* 멤버 테이블 생성 */
CREATE TABLE MEMBER (                     
   MEMBER_ID VARCHAR2(100)   NOT NULL,   -- 유저 ID(기본키)
   ROLE_ID   VARCHAR2(20)   NOT NULL,    -- 유저 등급(외래키)
   PASSWORD VARCHAR2(20)   NOT NULL,     -- 유저 PASSWORD
   EMAIL VARCHAR2(50)   NOT NULL,        -- 유저 EMAIL
   REG_DATE DATE   DEFAULT SYSDATE,      -- 유저 가입일
   PHONE   VARCHAR2(20)   NOT NULL,      -- 유저 휴대폰 번호
   NAME   VARCHAR2(10)   NOT NULL,       -- 유저 이름
  CONSTRAINT PK_MEMBER PRIMARY KEY (MEMBER_ID),   -- 기본키제약
  CONSTRAINT FK_ROLE_MEMBER FOREIGN KEY (ROLE_ID) REFERENCES ROLE (ROLE_ID)   -- 외래키제약
);

/* 영화 테이블 생성 */
CREATE TABLE MOVIE (  
   MOVIE_ID   NUMBER   NOT NULL,          -- 영화ID(기본키, 시퀀스)
   NAME   VARCHAR2(100)   NOT NULL,         -- 영화명 
   DESCRIPTION   VARCHAR2(1000)   NOT NULL, -- 영화 설명
   MOVIE_DATE  DATE NOT NULL,       -- 영화 개봉일
   REG_DATE   DATE   DEFAULT SYSDATE,       -- 등록일
  CONSTRAINT PK_MOVIE PRIMARY KEY (MOVIE_ID)   -- 기본키제약
);

/* 영화 이미지 테이블 생성 */
CREATE TABLE PROD_IMG (
   IMG_ID   NUMBER   NOT NULL,      -- 영화이미지id(시퀀스)
   MOVIE_ID   NUMBER   NOT NULL,      -- 영화id(외래키)
   IMG_PATH   VARCHAR2(500)   NOT NULL,   -- 영화 이미지 경로(하드디스크상 경로, DB에 저장됨)
   FILE_NAME   VARCHAR2(500)   NOT NULL,   -- 영화 이미지명 (물리적인 파일명, DB에 저장됨)-- 이미지가 여러장일 경우 대표이미지 (0-대표이미지, 1-추가이미지)
   IS_MAIN   NUMBER(1)   default 0,         -- 이미지가 여러장일 경우 대표이미지 (0-대표이미지, 1-추가이미지)
  CONSTRAINT PK_PROD_IMG PRIMARY KEY (IMG_ID),   -- 기본키제약
  CONSTRAINT FK_PROD_IMG FOREIGN KEY (MOVIE_ID) REFERENCES MOVIE (MOVIE_ID)   -- 외래키제약
);

/* 게시글 테이블 생성 */
CREATE TABLE BOARD (
   BOARD_NO   NUMBER   NOT NULL,          -- 게시판 번호(기본키, 시퀀스)
   MEMBER_ID   VARCHAR2(100)   NOT NULL,   -- 멤버 아이디(외래키)
   TITLE   VARCHAR2(255)   NOT NULL,       -- 제목
   CONTENT CLOB NOT NULL,              -- 내용
   HIT_NO   NUMBER(4)   DEFAULT 0,        -- 조회수
   REG_DATE   DATE   DEFAULT SYSDATE,    -- 작성일자
   REPLY_GROUP   NUMBER(5)   DEFAULT 0, -- 답글의 그룹을 정의
   REPLY_ORDER   NUMBER(5)   DEFAULT 0, -- 답글의 순서
   REPLY_INDENT   NUMBER(5)   DEFAULT 0, -- 답글이 다른 답글에 대한 하위 답글인지(즉, 대댓글인지) 여부, 들여쓰기관리
  CONSTRAINT PK_BOARD PRIMARY KEY (BOARD_NO),   -- 기본키제약
  CONSTRAINT FK_BOARD FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER (MEMBER_ID)   -- 외래키제약
);

-- 3. 시퀀스 생성

-- 3.1 영화ID용 시퀀스
create sequence seq_movie
start with 1
increment by 1
nocache    -- 캐싱(시퀀스 번호 메모리 일시 저장) 없음
nocycle;   -- 최대치 초과시 처음부터 다시 없음

-- 3.2 영화이미지ID용 시퀀스
create sequence seq_img
start with 1
increment by 1
nocache
nocycle;

CREATE SEQUENCE board_seq
start with 1
increment by 1
nocache
nocycle;

CREATE SEQUENCE cart_seq  -- shopping_cart 시퀀스
start with 1 -- 1부터
increment by 1  -- 1증가
nocache -- 캐싱(시퀀스 번호 메모리 일시 저장) 없음
nocycle; -- 최대치 초과시 처음부터 다시 없음

CREATE SEQUENCE order_seq -- order 시퀀스
start with 1 -- 1부터
increment by 1  -- 1증가
nocache -- 캐싱(시퀀스 번호 메모리 일시 저장) 없음
nocycle; -- 최대치 초과시 처음부터 다시 없음


/* 권한 데이터 정보 insert */
insert into role(role_id, role_name) values('admin', '관리자');
insert into role(role_id, role_name) values('member', '정회원');
--insert into role(role_id, role_name) values('guest', '준회원');

/* 기본 멤버 정보 insert */

INSERT INTO member(member_id, password, name, email, role_id, phone, reg_date)
values('jang', '1234', '장발장', 'jang@naver.com',  'member', '010-3333-3422', sysdate);


/* 기본 게시글 정보 insert */
INSERT INTO BOARD(BOARD_NO, TITLE, CONTENT, MEMBER_ID, REG_DATE)
VALUES(1, '첫번째 게시물', '이것은 첫번째 게시물', 'hong', SYSDATE);

INSERT INTO BOARD(BOARD_NO, TITLE, CONTENT, MEMBER_ID, REG_DATE)
VALUES(2, '두번째 게시물', '이것은 두번째 게시물', 'lee', SYSDATE);

INSERT INTO BOARD(BOARD_NO, TITLE, CONTENT, MEMBER_ID, REG_DATE)
VALUES(3, '세번째 게시물', '이것은 세번째 게시물', 'kim', SYSDATE);

commit;

DELETE FROM SHOPPING_CART 
      WHERE SP_CART_ID = 5;
        


    



ALTER TABLE MEMBER MODIFY (ROLE_ID DEFAULT 'member');
=======
---- 1. 유저 확인 및 계정 생성
--show user;
--
--/* sys에서 작업 */
--CREATE USER mreview IDENTIFIED BY 1234;
--GRANT CONNECT, RESOURCE TO mreview;
--GRANT UNLIMITED TABLESPACE TO mreview;

/* mreview 접속 생성 */

/* 2. 테이블 생성  */
CREATE TABLE ROLE (
   ROLE_ID   VARCHAR2(20)   NOT NULL,    -- 등급 번호(기본키)
   ROLE_NAME   VARCHAR2(20)   NOT NULL,  -- 등급 이름
  CONSTRAINT PK_ROLE PRIMARY KEY (ROLE_ID)   -- 기본키제약
);


/* 멤버 테이블 생성 */
CREATE TABLE MEMBER (                     
   MEMBER_ID VARCHAR2(100)   NOT NULL,   -- 유저 ID(기본키)
   ROLE_ID   VARCHAR2(20)   NOT NULL,    -- 유저 등급(외래키)
   PASSWORD VARCHAR2(20)   NOT NULL,     -- 유저 PASSWORD
   EMAIL VARCHAR2(50)   NOT NULL,        -- 유저 EMAIL
   REG_DATE DATE   DEFAULT SYSDATE,      -- 유저 가입일
   PHONE   VARCHAR2(20)   NOT NULL,      -- 유저 휴대폰 번호
   NAME   VARCHAR2(10)   NOT NULL,       -- 유저 이름
  CONSTRAINT PK_MEMBER PRIMARY KEY (MEMBER_ID),   -- 기본키제약
  CONSTRAINT FK_ROLE_MEMBER FOREIGN KEY (ROLE_ID) REFERENCES ROLE (ROLE_ID)   -- 외래키제약
);

/* 영화 테이블 생성 */
CREATE TABLE MOVIE (  
   MOVIE_ID   NUMBER   NOT NULL,          -- 영화ID(기본키, 시퀀스)
   NAME   VARCHAR2(100)   NOT NULL,         -- 영화명 
   DESCRIPTION   VARCHAR2(1000)   NOT NULL, -- 영화 설명
   MOVIE_DATE  DATE NOT NULL,       -- 영화 개봉일
   REG_DATE   DATE   DEFAULT SYSDATE,       -- 등록일
  CONSTRAINT PK_MOVIE PRIMARY KEY (MOVIE_ID)   -- 기본키제약
);

/* 영화 이미지 테이블 생성 */
CREATE TABLE PROD_IMG (
   IMG_ID   NUMBER   NOT NULL,      -- 영화이미지id(시퀀스)
   MOVIE_ID   NUMBER   NOT NULL,      -- 영화id(외래키)
   IMG_PATH   VARCHAR2(500)   NOT NULL,   -- 영화 이미지 경로(하드디스크상 경로, DB에 저장됨)
   FILE_NAME   VARCHAR2(500)   NOT NULL,   -- 영화 이미지명 (물리적인 파일명, DB에 저장됨)-- 이미지가 여러장일 경우 대표이미지 (0-대표이미지, 1-추가이미지)
   IS_MAIN   NUMBER(1)   default 0,         -- 이미지가 여러장일 경우 대표이미지 (0-대표이미지, 1-추가이미지)
  CONSTRAINT PK_PROD_IMG PRIMARY KEY (IMG_ID),   -- 기본키제약
  CONSTRAINT FK_PROD_IMG FOREIGN KEY (MOVIE_ID) REFERENCES MOVIE (MOVIE_ID)   -- 외래키제약
);

/* 게시글 테이블 생성 */
CREATE TABLE BOARD (
   BOARD_NO   NUMBER   NOT NULL,          -- 게시판 번호(기본키, 시퀀스)
   MEMBER_ID   VARCHAR2(100)   NOT NULL,   -- 멤버 아이디(외래키)
   TITLE   VARCHAR2(255)   NOT NULL,       -- 제목
   CONTENT CLOB NOT NULL,              -- 내용
   HIT_NO   NUMBER(4)   DEFAULT 0,        -- 조회수
   REG_DATE   DATE   DEFAULT SYSDATE,    -- 작성일자
   REPLY_GROUP   NUMBER(5)   DEFAULT 0, -- 답글의 그룹을 정의
   REPLY_ORDER   NUMBER(5)   DEFAULT 0, -- 답글의 순서
   REPLY_INDENT   NUMBER(5)   DEFAULT 0, -- 답글이 다른 답글에 대한 하위 답글인지(즉, 대댓글인지) 여부, 들여쓰기관리
  CONSTRAINT PK_BOARD PRIMARY KEY (BOARD_NO),   -- 기본키제약
  CONSTRAINT FK_BOARD FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER (MEMBER_ID)   -- 외래키제약
);

-- 3. 시퀀스 생성

-- 3.1 영화ID용 시퀀스
create sequence seq_movie
start with 1
increment by 1
nocache    -- 캐싱(시퀀스 번호 메모리 일시 저장) 없음
nocycle;   -- 최대치 초과시 처음부터 다시 없음

-- 3.2 영화이미지ID용 시퀀스
create sequence seq_img
start with 1
increment by 1
nocache
nocycle;

CREATE SEQUENCE board_seq
start with 1
increment by 1
nocache
nocycle;

CREATE SEQUENCE cart_seq  -- shopping_cart 시퀀스
start with 1 -- 1부터
increment by 1  -- 1증가
nocache -- 캐싱(시퀀스 번호 메모리 일시 저장) 없음
nocycle; -- 최대치 초과시 처음부터 다시 없음

CREATE SEQUENCE order_seq -- order 시퀀스
start with 1 -- 1부터
increment by 1  -- 1증가
nocache -- 캐싱(시퀀스 번호 메모리 일시 저장) 없음
nocycle; -- 최대치 초과시 처음부터 다시 없음


/* 권한 데이터 정보 insert */
insert into role(role_id, role_name) values('admin', '관리자');
insert into role(role_id, role_name) values('member', '정회원');
--insert into role(role_id, role_name) values('guest', '준회원');

/* 기본 멤버 정보 insert */

INSERT INTO member(member_id, password, name, email, role_id, phone, reg_date)
values('jang', '1234', '장발장', 'jang@naver.com',  'member', '010-3333-3422', sysdate);


/* 기본 게시글 정보 insert */
INSERT INTO BOARD(BOARD_NO, TITLE, CONTENT, MEMBER_ID, REG_DATE)
VALUES(1, '첫번째 게시물', '이것은 첫번째 게시물', 'hong', SYSDATE);

INSERT INTO BOARD(BOARD_NO, TITLE, CONTENT, MEMBER_ID, REG_DATE)
VALUES(2, '두번째 게시물', '이것은 두번째 게시물', 'lee', SYSDATE);

INSERT INTO BOARD(BOARD_NO, TITLE, CONTENT, MEMBER_ID, REG_DATE)
VALUES(3, '세번째 게시물', '이것은 세번째 게시물', 'kim', SYSDATE);

commit;

DELETE FROM SHOPPING_CART 
      WHERE SP_CART_ID = 5;
        


    



ALTER TABLE MEMBER MODIFY (ROLE_ID DEFAULT 'member');
>>>>>>> 006e59749ab191f40524bec0346917788d855245
