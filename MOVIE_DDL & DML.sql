-- =====================================
-- 1. 계정 생성 및 권한 부여 [ sys에서 작업 ]
-- =====================================
-- CREATE USER mreview IDENTIFIED BY 1234;
-- GRANT CONNECT, RESOURCE TO mreview;
-- GRANT UNLIMITED TABLESPACE TO mreview;

-- =====================================
-- 2. 테이블 생성
-- =====================================

-- 2.1 등급 테이블 (ROLE)
CREATE TABLE ROLE (
   ROLE_ID   VARCHAR2(20)   NOT NULL,    -- 등급 번호(기본키)
   ROLE_NAME   VARCHAR2(20)   NOT NULL,  -- 등급 이름
   CONSTRAINT PK_ROLE PRIMARY KEY (ROLE_ID)   -- 기본키 제약
);

-- 2.2 멤버 테이블 (MEMBER)
CREATE TABLE MEMBER (                     
   MEMBER_ID VARCHAR2(100)   NOT NULL,   -- 유저 ID(기본키)
   ROLE_ID   VARCHAR2(20)   NOT NULL,    -- 유저 등급(외래키)
   PASSWORD VARCHAR2(20)   NOT NULL,     -- 유저 PASSWORD
   EMAIL VARCHAR2(50)   NOT NULL,        -- 유저 EMAIL
   REG_DATE DATE   DEFAULT SYSDATE,      -- 유저 가입일
   PHONE   VARCHAR2(20)   NOT NULL,      -- 유저 휴대폰 번호
   NAME   VARCHAR2(10)   NOT NULL,       -- 유저 이름
   CONSTRAINT PK_MEMBER PRIMARY KEY (MEMBER_ID),   -- 기본키 제약
   CONSTRAINT FK_ROLE_MEMBER FOREIGN KEY (ROLE_ID) REFERENCES ROLE (ROLE_ID)   -- 외래키 제약
);

-- 2.3 영화 테이블 (MOVIE)
CREATE TABLE MOVIE (  
   MOVIE_ID       NUMBER       NOT NULL,          -- 영화ID(기본키, 시퀀스)
   NAME           VARCHAR2(100) NOT NULL,         -- 영화명 
   DESCRIPTION    VARCHAR2(1000) NOT NULL,        -- 영화 설명
   MOVIE_DATE     DATE         NOT NULL,          -- 영화 개봉일
   REG_DATE       DATE         DEFAULT SYSDATE,   -- 등록일
   GENRE          VARCHAR2(100),                  -- 장르
   RUNNING_TIME   VARCHAR2(50),                   -- 상영시간
   RATING         VARCHAR2(10),                   -- 평점
   AGE_RATING     VARCHAR2(20),                   -- 연령등급
   DIRECTOR       VARCHAR2(100),                  -- 감독
   CAST           VARCHAR2(1000),                 -- 출연
   CONSTRAINT PK_MOVIE PRIMARY KEY (MOVIE_ID)    -- 기본키 제약
);

-- 2.4 게시글 테이블 (BOARD)
CREATE TABLE BOARD (
   BOARD_NO   NUMBER   NOT NULL,          -- 게시판 번호(기본키, 시퀀스)
   MEMBER_ID   VARCHAR2(100)   NOT NULL,   -- 멤버 아이디(외래키)
   TITLE   VARCHAR2(255)   NOT NULL,       -- 제목
   CONTENT CLOB NOT NULL,                  -- 내용
   HIT_NO   NUMBER(4)   DEFAULT 0,         -- 조회수
   REG_DATE   DATE   DEFAULT SYSDATE,      -- 작성일자
   RATING NUMBER(2, 1) DEFAULT NULL,       -- 별점
   SPOILER VARCHAR2(1) DEFAULT 'N',        -- 스포일러 여부
   CONSTRAINT PK_BOARD PRIMARY KEY (BOARD_NO),   -- 기본키 제약
   CONSTRAINT FK_BOARD FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER (MEMBER_ID)   -- 외래키 제약
);

-- =====================================
-- 3. 시퀀스 생성
-- =====================================

-- 영화 시퀀스 생성
CREATE SEQUENCE seq_movie
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 게시글 시퀀스 생성
CREATE SEQUENCE board_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- =====================================
-- 4. 기본 데이터 삽입
-- =====================================

-- 4.1 등급 데이터 삽입
INSERT INTO role(role_id, role_name) VALUES('admin', '관리자');
INSERT INTO role(role_id, role_name) VALUES('member', '정회원');
--insert into role(role_id, role_name) values('guest', '준회원');

-- 4.2 멤버 데이터 삽입
INSERT INTO member (member_id, password, name, email, role_id, phone, reg_date) 
VALUES ('bokky', '1234', '장보키', 'bokky@example.com', 'admin', '010-1111-1111', SYSDATE);

INSERT INTO member (member_id, password, name, email, role_id, phone, reg_date) 
VALUES ('lee', '1234', '이수빈', 'leesubin@example.com', 'member', '010-2222-2222', SYSDATE);

-- 4.3 게시글 데이터 삽입
INSERT INTO BOARD (BOARD_NO, MEMBER_ID, TITLE, CONTENT, HIT_NO, REG_DATE, RATING, SPOILER)
VALUES (board_seq.NEXTVAL, 'bokky', '첫번째 게시물', '이것은 첫번째 게시물', 0, SYSDATE, 4.5, 'N');

INSERT INTO BOARD (BOARD_NO, MEMBER_ID, TITLE, CONTENT, HIT_NO, REG_DATE, RATING, SPOILER)
VALUES (board_seq.NEXTVAL, 'lee', '두번째 게시물', '이것은 두번째 게시물', 10, SYSDATE, 3.5, 'Y');

-- 4.4 영화 데이터 삽입
INSERT INTO MOVIE (MOVIE_ID, NAME, DESCRIPTION, MOVIE_DATE, REG_DATE, GENRE, RUNNING_TIME, RATING, AGE_RATING, DIRECTOR, CAST)
VALUES (seq_movie.NEXTVAL, '인셉션', '꿈 속의 꿈을 다룬 SF 영화', TO_DATE('2010-07-21', 'YYYY-MM-DD'), SYSDATE, 
'액션, SF', '147분', '9.5/10', '12세 이상 관람가', '크리스토퍼 놀란', '레오나르도 디카프리오, 조셉 고든 레빗, 엘리엇 페이지');

commit;
