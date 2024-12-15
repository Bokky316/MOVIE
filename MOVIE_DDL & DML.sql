-- =====================================
-- 1. 유저 확인 및 계정 생성
-- =====================================
-- show user;
--
-- /* sys에서 작업 */
-- CREATE USER mreview IDENTIFIED BY 1234;
-- GRANT CONNECT, RESOURCE TO mreview;
-- GRANT UNLIMITED TABLESPACE TO mreview;

-- =====================================
-- 2. 테이블 생성
-- =====================================

/* 역할 테이블 생성 */
CREATE TABLE ROLE (
   ROLE_ID   VARCHAR2(20)   NOT NULL,    -- 등급 번호(기본키)
   ROLE_NAME VARCHAR2(20)   NOT NULL,    -- 등급 이름
   CONSTRAINT PK_ROLE PRIMARY KEY (ROLE_ID)   -- 기본키 제약
);

/* 멤버 테이블 생성 */
CREATE TABLE MEMBER (                     
   MEMBER_ID VARCHAR2(100)   NOT NULL,   -- 유저 ID(기본키)
   ROLE_ID   VARCHAR2(20)   NOT NULL,    -- 유저 등급(외래키)
   PASSWORD  VARCHAR2(20)   NOT NULL,     -- 유저 PASSWORD
   EMAIL     VARCHAR2(50)   NOT NULL,     -- 유저 EMAIL
   REG_DATE  DATE DEFAULT SYSDATE,        -- 유저 가입일
   PHONE     VARCHAR2(20)   NOT NULL,     -- 유저 휴대폰 번호
   NAME      VARCHAR2(10)   NOT NULL,     -- 유저 이름
   CONSTRAINT PK_MEMBER PRIMARY KEY (MEMBER_ID),  -- 기본키 제약
   CONSTRAINT FK_ROLE_MEMBER FOREIGN KEY (ROLE_ID) REFERENCES ROLE (ROLE_ID)  -- 외래키 제약
);

/* 영화 테이블 생성 */
CREATE TABLE MOVIE (  
   MOVIE_ID       NUMBER       NOT NULL,          -- 영화ID(기본키)
   NAME           VARCHAR2(100) NOT NULL,         -- 영화명 
   DESCRIPTION    VARCHAR2(1000) NOT NULL,        -- 영화 설명
   MOVIE_DATE     DATE         NOT NULL,          -- 영화 개봉일
   REG_DATE       DATE         DEFAULT SYSDATE,   -- 등록일
   GENRE          VARCHAR2(100),                  -- 장르
   RUNNING_TIME   VARCHAR2(50),                   -- 상영시간
   RATING         VARCHAR2(10),                   -- 평점
   AGE_RATING     VARCHAR2(30),                   -- 연령등급
   DIRECTOR       VARCHAR2(100),                  -- 감독
   CAST           VARCHAR2(1000),                 -- 출연
   CONSTRAINT PK_MOVIE PRIMARY KEY (MOVIE_ID)    -- 기본키 제약
);

/* 영화 이미지 테이블 생성 */
CREATE TABLE PROD_IMG (
   IMG_ID     NUMBER       NOT NULL,      -- 영화이미지id(시퀀스)
   MOVIE_ID   NUMBER       NOT NULL,      -- 영화id(외래키)
   IMG_PATH   VARCHAR2(500) NOT NULL,      -- 영화 이미지 경로
   FILE_NAME  VARCHAR2(500) NOT NULL,      -- 영화 이미지명 
   IS_MAIN    NUMBER(1) DEFAULT 0,         -- 대표이미지 여부
   CONSTRAINT PK_PROD_IMG PRIMARY KEY (IMG_ID),  -- 기본키 제약
   CONSTRAINT FK_PROD_IMG FOREIGN KEY (MOVIE_ID) REFERENCES MOVIE (MOVIE_ID)  -- 외래키 제약
);

/* 게시글 테이블 생성 */
CREATE TABLE BOARD (
    BOARD_NO    NUMBER       NOT NULL,          -- 게시판 번호(기본키)
    MEMBER_ID    VARCHAR2(100) NOT NULL,        -- 멤버 아이디(외래키)
    MOVIE_ID     NUMBER,                          -- 영화 아이디(외래키) 추가
    TITLE       VARCHAR2(255) NOT NULL,          -- 제목
    CONTENT     CLOB        NOT NULL,            -- 내용
    HIT_NO      NUMBER(4) DEFAULT 0,             -- 조회수
    REG_DATE    DATE DEFAULT SYSDATE,            -- 작성일자
    REPLY_GROUP  NUMBER(5) DEFAULT 0,            -- 답글의 그룹을 정의
    REPLY_ORDER  NUMBER(5) DEFAULT 0,            -- 답글의 순서
    REPLY_INDENT NUMBER(5) DEFAULT 0,            -- 대댓글 여부 및 들여쓰기 관리
    RATING      NUMBER(2,1) DEFAULT NULL,        -- 별점 
    SPOILER     VARCHAR2(1) DEFAULT 'N',         -- 스포일러 여부 
    CONSTRAINT PK_BOARD PRIMARY KEY (BOARD_NO),  -- 기본키 제약
    CONSTRAINT FK_BOARD FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER (MEMBER_ID),  -- 외래키 제약
    CONSTRAINT FK_MOVIE FOREIGN KEY (MOVIE_ID) REFERENCES MOVIE (MOVIE_ID)      -- 외래키 제약
);


-- =====================================
-- 3. 시퀀스 생성
-- =====================================

-- 영화ID용 시퀀스 생성
CREATE SEQUENCE seq_movie 
START WITH 1 
INCREMENT BY 1 
NOCACHE 
NOCYCLE;

-- 게시글ID용 시퀀스 생성
CREATE SEQUENCE board_seq 
START WITH 1 
INCREMENT BY 1 
NOCACHE 
NOCYCLE;

-- 영화 이미지ID용 시퀀스 생성
CREATE SEQUENCE seq_img 
START WITH 1 
INCREMENT BY 1 
NOCACHE 
NOCYCLE;

-- =====================================
-- 4. 기본 데이터 삽입
-- =====================================

-- 권한 데이터 정보 삽입
INSERT INTO role(role_id, role_name) VALUES('admin', '관리자');
INSERT INTO role(role_id, role_name) VALUES('member', '정회원');

ALTER TABLE MEMBER MODIFY (ROLE_ID DEFAULT 'member'); -- 멤버 새로 추가시 기본 권한 member

-- 기본 멤버 정보 삽입
INSERT INTO member (member_id, password, name, email, role_id, phone, reg_date) VALUES ('bokky', '1234', '장보키', 'bokky@example.com', 'admin', '010-1111-1111', SYSDATE);
INSERT INTO member (member_id, password, name, email, role_id, phone, reg_date) VALUES ('lee', '1234', '이수빈', 'leesubin@example.com', 'member', '010-2222-2222', SYSDATE);
INSERT INTO member (member_id, password ,name ,email ,role_id ,phone ,reg_date ) VALUES ('park' ,'1234' ,'박지훈' ,'parkjihun@example.com' ,'member' ,'010-3333-3333' ,SYSDATE);
INSERT INTO member (member_id,password,name,email ,role_id ,phone ,reg_date ) VALUES ('choi','1234','최미래','choimirae@example.com','member','010-4444-4444' ,SYSDATE);
INSERT INTO member (member_id,password,name,email ,role_id ,phone ,reg_date ) VALUES ('jung','1234','정하늘','junghaneul@example.com','member','010-5555-5555' ,SYSDATE);
INSERT INTO member (member_id,password,name,email ,role_id ,phone ,reg_date ) VALUES ('han','1234','한서연','hanseoyeon@example.com','member','010-6666-6666' ,SYSDATE);
INSERT INTO member (member_id,password,name,email ,role_id ,phone ,reg_date ) VALUES ('oh','1234','오민재','ominjae@example.com','member','010-7777-7777' ,SYSDATE);
INSERT INTO member (member_id,password,name,email ,role_id ,phone ,reg_date ) VALUES ('lim','1234','임유진','limyujin@example.com','member','010-8888-8888' ,SYSDATE);
INSERT INTO member (member_id,password,name,email ,role_id ,phone ,reg_date ) VALUES ('yang','1234','양지민','yangjimin@example.com','member','010-9999-9999' ,SYSDATE);
INSERT INTO member (member_id,password,name,email ,role_id ,phone ,reg_date ) VALUES ('seo','1234','서준호','seojunho@example.com','member','010-0000-0000' ,SYSDATE);


/* 영화 리뷰 데이터 삽입 */
INSERT INTO BOARD (BOARD_NO, MEMBER_ID, MOVIE_ID, TITLE, CONTENT, HIT_NO, REG_DATE, REPLY_GROUP, REPLY_ORDER, REPLY_INDENT, RATING, SPOILER)
VALUES (board_seq.NEXTVAL, 'bokky', (SELECT MOVIE_ID FROM MOVIE WHERE NAME = '어바웃 타임'), '어바웃 타임 리뷰', '정말 감동적인 영화입니다. 시간 여행을 통해 사랑을 찾는 이야기.', 0, SYSDATE, 0, 0, 0, 4, 'N');

INSERT INTO BOARD (BOARD_NO, MEMBER_ID, MOVIE_ID, TITLE, CONTENT, HIT_NO, REG_DATE, REPLY_GROUP, REPLY_ORDER, REPLY_INDENT, RATING, SPOILER)
VALUES (board_seq.NEXTVAL, 'lee', (SELECT MOVIE_ID FROM MOVIE WHERE NAME = '어벤져스'), '어벤져스 리뷰', '슈퍼히어로들이 모여서 지구를 지키는 이야기가 너무 재미있었습니다!', 5, SYSDATE, 0, 0, 0, 3, 'N');

INSERT INTO BOARD (BOARD_NO, MEMBER_ID, MOVIE_ID, TITLE, CONTENT, HIT_NO, REG_DATE, REPLY_GROUP, REPLY_ORDER, REPLY_INDENT, RATING, SPOILER)
VALUES (board_seq.NEXTVAL,'park', (SELECT MOVIE_ID FROM MOVIE WHERE NAME = '빅 피쉬'), '빅 피쉬 리뷰', '아버지의 이야기를 통해 가족의 의미를 다시 생각하게 해주는 영화입니다.', 3, SYSDATE ,0 ,0 ,0 ,2 ,'Y');

INSERT INTO BOARD (BOARD_NO,MEMBER_ID,MOVIE_ID,TITLE ,CONTENT ,HIT_NO ,REG_DATE ,REPLY_GROUP ,REPLY_ORDER ,REPLY_INDENT ,RATING ,SPOILER)
VALUES (board_seq.NEXTVAL,'choi', (SELECT MOVIE_ID FROM MOVIE WHERE NAME = '해리 포터와 마법사의 돌'), '해리 포터 리뷰','마법과 모험이 가득한 해리 포터 시리즈는 언제 봐도 재밌어요!', 10,SYSDATE ,0 ,0 ,0 ,5 ,'N');

INSERT INTO BOARD (BOARD_NO,MEMBER_ID,MOVIE_ID,TITLE ,CONTENT ,HIT_NO ,REG_DATE ,REPLY_GROUP ,REPLY_ORDER ,REPLY_INDENT ,RATING ,SPOILER)
VALUES (board_seq.NEXTVAL,'jung', (SELECT MOVIE_ID FROM MOVIE WHERE NAME = '인셉션'), '인셉션 리뷰','꿈 속의 꿈을 다룬 SF 영화로 정말 흥미진진했습니다.', 8,SYSDATE ,0 ,0 ,0 ,4 ,'Y');

INSERT INTO BOARD (BOARD_NO,MEMBER_ID,MOVIE_ID,TITLE ,CONTENT ,HIT_NO ,REG_DATE ,REPLY_GROUP ,REPLY_ORDER ,REPLY_INDENT ,RATING ,SPOILER)
VALUES (board_seq.NEXTVAL,'han', (SELECT MOVIE_ID FROM MOVIE WHERE NAME = '라라랜드'), '라라랜드 리뷰','음악과 사랑이 어우러진 멋진 뮤지컬 드라마입니다.', 6,SYSDATE ,0 ,0 ,0 ,3 ,'Y');

INSERT INTO BOARD (BOARD_NO, MEMBER_ID, MOVIE_ID, TITLE, CONTENT, HIT_NO, REG_DATE, REPLY_GROUP, REPLY_ORDER, REPLY_INDENT, RATING, SPOILER)
VALUES (board_seq.NEXTVAL, 'yang', (SELECT MOVIE_ID FROM MOVIE WHERE NAME = '기생충'), '기생충 리뷰', '계급 격차를 날카롭게 비판한 블랙 코미디 걸작', 10, SYSDATE, 0, 0, 0, 5, 'N');

INSERT INTO BOARD (BOARD_NO, MEMBER_ID, MOVIE_ID, TITLE, CONTENT, HIT_NO, REG_DATE, REPLY_GROUP, REPLY_ORDER, REPLY_INDENT, RATING, SPOILER)
VALUES (board_seq.NEXTVAL, 'lee', (SELECT MOVIE_ID FROM MOVIE WHERE NAME = '플로리다 프로젝트'), '플로리다 프로젝트 리뷰', '어린 소녀의 시선으로 본 미국 하층민의 삶', 8, SYSDATE, 0, 0, 0, 4, 'N');

INSERT INTO BOARD (BOARD_NO, MEMBER_ID, MOVIE_ID, TITLE, CONTENT, HIT_NO, REG_DATE, REPLY_GROUP, REPLY_ORDER, REPLY_INDENT, RATING, SPOILER)
VALUES (board_seq.NEXTVAL, 'park', (SELECT MOVIE_ID FROM MOVIE WHERE NAME = '그랜드 부다페스트 호텔'), '그랜드 부다페스트 호텔 리뷰', '웨스 앤더슨 특유의 아름다운 미장센과 유머', 7, SYSDATE, 0, 0, 0, 4, 'N');

INSERT INTO BOARD (BOARD_NO, MEMBER_ID, MOVIE_ID, TITLE, CONTENT, HIT_NO, REG_DATE, REPLY_GROUP, REPLY_ORDER, REPLY_INDENT, RATING, SPOILER)
VALUES (board_seq.NEXTVAL, 'choi', (SELECT MOVIE_ID FROM MOVIE WHERE NAME = '나홀로 집에'), '나홀로집에 리뷰', '크리스마스 시즌의 필수 가족 코미디 영화', 15, SYSDATE, 0, 0, 0, 4, 'Y');




-- 영화 데이터 삽입
-- 어바웃 타임 추가
INSERT INTO MOVIE (MOVIE_ID, NAME, DESCRIPTION, MOVIE_DATE, REG_DATE, GENRE, RUNNING_TIME, RATING, AGE_RATING, DIRECTOR, CAST)
VALUES (seq_movie.NEXTVAL, '어바웃 타임', '시간 여행을 통해 사랑을 찾는 남자의 이야기', TO_DATE('2013-09-04', 'YYYY-MM-DD'), SYSDATE,
'로맨스, 판타지', '123분', '8.6/10', '12세 이상 관람가', '리차드 커티스', '돔놀 글리슨, 레이첼 맥아담스');

-- 어바웃 타임 포스터 추가
INSERT INTO PROD_IMG (IMG_ID, MOVIE_ID, IMG_PATH, FILE_NAME, IS_MAIN)
VALUES (seq_img.NEXTVAL, (SELECT MOVIE_ID FROM MOVIE WHERE NAME = '어바웃 타임'), TO_CHAR(SYSDATE,'YYYY') || '\' || TO_CHAR(SYSDATE,'MM') || '\' || TO_CHAR(SYSDATE,'DD') || '\',
'about_time.jpg', 1);

-- 어벤져스 추가
INSERT INTO MOVIE (MOVIE_ID, NAME, DESCRIPTION, MOVIE_DATE, REG_DATE, GENRE, RUNNING_TIME, RATING, AGE_RATING, DIRECTOR, CAST)
VALUES (seq_movie.NEXTVAL, '어벤져스', '지구를 지키기 위해 모인 슈퍼히어로들의 이야기', TO_DATE('2012-05-04', 'YYYY-MM-DD'), SYSDATE,
'액션, 모험', '143분', '8.0/10', '12세 이상 관람가', '조스 웨던', '로버트 다우니 주니어, 크리스 에반스');

-- 어벤져스 포스터 추가
INSERT INTO PROD_IMG (IMG_ID, MOVIE_ID, IMG_PATH, FILE_NAME, IS_MAIN)
VALUES (seq_img.NEXTVAL, (SELECT MOVIE_ID FROM MOVIE WHERE NAME = '어벤져스'), TO_CHAR(SYSDATE,'YYYY') || '\' || TO_CHAR(SYSDATE,'MM') || '\' || TO_CHAR(SYSDATE,'DD') || '\',
'avengers_endgame.jpg', 1);

-- 빅 피쉬 추가
INSERT INTO MOVIE (MOVIE_ID, NAME, DESCRIPTION, MOVIE_DATE, REG_DATE, GENRE, RUNNING_TIME, RATING, AGE_RATING, DIRECTOR, CAST)
VALUES (seq_movie.NEXTVAL, '빅 피쉬', '아버지의 허풍 같은 이야기를 통해 진정한 사랑과 가족의 의미를 찾아가는 이야기.', TO_DATE('2003-12-10', 'YYYY-MM-DD'), SYSDATE,
'판타지, 드라마', '126분', '8.0/10', '12세 이상 관람가', '팀 버튼', '이완 맥그리거');

-- 빅 피쉬 포스터 추가
INSERT INTO PROD_IMG (IMG_ID, MOVIE_ID, IMG_PATH, FILE_NAME, IS_MAIN)
VALUES (seq_img.NEXTVAL, (SELECT MOVIE_ID FROM MOVIE WHERE NAME = '빅 피쉬'), TO_CHAR(SYSDATE,'YYYY') || '\' || TO_CHAR(SYSDATE,'MM') || '\' || TO_CHAR(SYSDATE,'DD') || '\', 
'big_fish.jpg', 1);

-- 해리포터 추가
INSERT INTO MOVIE (MOVIE_ID, NAME, DESCRIPTION, MOVIE_DATE, REG_DATE, GENRE, RUNNING_TIME, RATING, AGE_RATING, DIRECTOR, CAST)
VALUES (seq_movie.NEXTVAL,'해리 포터와 마법사의 돌','마법사 해리 포터가 호그와트에서 마법과 모험을 경험하며 마법사의 돌의 비밀을 풀어갑니다.', TO_DATE('2001-11-16','YYYY-MM-DD'), SYSDATE,
'판타지','152분','9.4/10','전체 관람가','크리스 콜롬버스','다니엘 래드클리프');

-- 해리포터 포스터 추가
INSERT INTO PROD_IMG (IMG_ID,MOVIE_ID ,IMG_PATH ,FILE_NAME ,IS_MAIN)
VALUES (seq_img.NEXTVAL,(SELECT MOVIE_ID FROM MOVIE WHERE NAME = '해리 포터와 마법사의 돌'),TO_CHAR(SYSDATE,'YYYY') || '\' || TO_CHAR(SYSDATE,'MM') || '\' || TO_CHAR(SYSDATE,'DD') || '\',
'harry_potter.jpg',1);

-- 나홀로 집에 추가
INSERT INTO MOVIE (MOVIE_ID ,NAME ,DESCRIPTION ,MOVIE_DATE ,REG_DATE ,GENRE ,RUNNING_TIME ,RATING ,AGE_RATING ,DIRECTOR ,CAST)
VALUES (seq_movie.NEXTVAL,'나홀로 집에','크리스마스에 혼자 남겨진 소년의 이야기.', TO_DATE('1990-11-16','YYYY-MM-DD'), SYSDATE,
'코미디','103분','7.6/10','전체 관람가','크리스 콜럼버스','맥컬리 컬킨');

-- 나홀로 집에 포스터 추가
INSERT INTO PROD_IMG (IMG_ID,MOVIE_ID ,IMG_PATH ,FILE_NAME ,IS_MAIN)
VALUES (seq_img.NEXTVAL,(SELECT MOVIE_ID FROM MOVIE WHERE NAME = '나홀로 집에'),TO_CHAR(SYSDATE,'YYYY') || '\' || TO_CHAR(SYSDATE,'MM') || '\' || TO_CHAR(SYSDATE,'DD') || '\',
'home_alone.jpg',1);

-- 인셉션 추가
INSERT INTO MOVIE (MOVIE_ID ,NAME ,DESCRIPTION ,MOVIE_DATE ,REG_DATE ,GENRE ,RUNNING_TIME ,RATING ,AGE_RATING ,DIRECTOR ,CAST)
VALUES (seq_movie.NEXTVAL,'인셉션','꿈 속의 꿈을 다룬 SF 영화.', TO_DATE('2010-07-21','YYYY-MM-DD'), SYSDATE,
'액션,SF','147분','9.5/10','12세 이상 관람가','크리스토퍼 놀란','레오나르도 디카프리오');

-- 인셉션 포스터 추가
INSERT INTO PROD_IMG (IMG_ID,MOVIE_ID ,IMG_PATH ,FILE_NAME ,IS_MAIN)
VALUES (seq_img.NEXTVAL,(SELECT MOVIE_ID FROM MOVIE WHERE NAME = '인셉션'),TO_CHAR(SYSDATE,'YYYY') || '\' || TO_CHAR(SYSDATE,'MM') || '\' || TO_CHAR(SYSDATE,'DD') || '\',
'inception.jpg',1);

-- 라라랜드 추가
INSERT INTO MOVIE (MOVIE_ID ,NAME ,DESCRIPTION ,MOVIE_DATE ,REG_DATE ,GENRE ,RUNNING_TIME ,RATING ,AGE_RATING ,DIRECTOR ,CAST)
VALUES (seq_movie.NEXTVAL,'라라랜드','꿈을 쫓는 두 연인의 이야기.', TO_DATE('2016-12-07','YYYY-MM-DD'), SYSDATE,
'뮤지컬 드라마','128분','8.0/10','12세 이상 관람가','다미엔 차젤레','엠마 스톤');

-- 라라랜드 포스터 추가
INSERT INTO PROD_IMG (IMG_ID,MOVIE_ID ,IMG_PATH ,FILE_NAME ,IS_MAIN)
VALUES (seq_img.NEXTVAL,(SELECT MOVIE_ID FROM MOVIE WHERE NAME = '라라랜드'),TO_CHAR(SYSDATE,'YYYY') || '\' || TO_CHAR(SYSDATE,'MM') || '\' || TO_CHAR(SYSDATE,'DD') || '\',
'lalaland.jpg',1);

-- 기생충 추가
INSERT INTO MOVIE (MOVIE_ID ,NAME ,DESCRIPTION ,MOVIE_DATE ,REG_DATE ,GENRE ,RUNNING_TIME ,RATING ,AGE_RATING ,DIRECTOR ,CAST)
VALUES (seq_movie.NEXTVAL,'기생충','부유한 가족과 가난한 가족의 이야기를 다룬 영화.', TO_DATE('2019-05-30','YYYY-MM-DD'), SYSDATE,
'드라마','132분','8.6/10','15세 이상 관람가','봉준호','송강호');

-- 기생충 포스터 추가
INSERT INTO PROD_IMG (IMG_ID,MOVIE_ID ,IMG_PATH ,FILE_NAME ,IS_MAIN)
VALUES (seq_img.NEXTVAL,(SELECT MOVIE_ID FROM MOVIE WHERE NAME = '기생충'),TO_CHAR(SYSDATE,'YYYY') || '\' || TO_CHAR(SYSDATE,'MM') || '\' || TO_CHAR(SYSDATE,'DD') || '\',
'parasite.jpg',1);

-- 플로리다 프로젝트 추가
INSERT INTO MOVIE (MOVIE_ID ,NAME ,DESCRIPTION ,MOVIE_DATE ,REG_DATE ,GENRE ,RUNNING_TIME ,RATING ,AGE_RATING ,DIRECTOR ,CAST)
VALUES (seq_movie.NEXTVAL,'플로리다 프로젝트','플로리다 주의 한 모텔에서 살아가는 아이와 엄마의 이야기.', TO_DATE('2017-10-06','YYYY-MM-DD'), SYSDATE,
'드라마','111분','7.6/10','15세 이상 관람가','숀 베이커','브루클린 프린스');

-- 플로리다 프로젝트 포스터 추가
INSERT INTO PROD_IMG (IMG_ID,MOVIE_ID ,IMG_PATH ,FILE_NAME ,IS_MAIN)
VALUES (seq_img.NEXTVAL,(SELECT MOVIE_ID FROM MOVIE WHERE NAME = '플로리다 프로젝트'),TO_CHAR(SYSDATE,'YYYY') || '\' || TO_CHAR(SYSDATE,'MM') || '\' || TO_CHAR(SYSDATE,'DD') || '\',
'the_florida_project.jpg',1);

-- 그랜드 부다페스트 호텔 추가
INSERT INTO MOVIE (MOVIE_ID, NAME, DESCRIPTION, MOVIE_DATE, REG_DATE, GENRE, RUNNING_TIME, RATING, AGE_RATING, DIRECTOR, CAST)
VALUES (seq_movie.NEXTVAL, '그랜드 부다페스트 호텔', 
        '유명한 호텔의 수석 집사와 그의 제자의 이야기를 그린 코미디 드라마.', 
        TO_DATE('2014-03-28', 'YYYY-MM-DD'), SYSDATE,
        '코미디', '99분', '8.1/10', '12세 이상 관람가', 
        '웨스 앤더슨', '레아 세이두');

-- 그랜드 부다페스트 호텔 포스터 추가
INSERT INTO PROD_IMG (IMG_ID, MOVIE_ID, IMG_PATH, FILE_NAME, IS_MAIN) 
VALUES (seq_img.NEXTVAL, (SELECT MOVIE_ID FROM MOVIE WHERE NAME = '그랜드 부다페스트 호텔'), 
        TO_CHAR(SYSDATE,'YYYY') || '\' || TO_CHAR(SYSDATE,'MM') || '\' || TO_CHAR(SYSDATE,'DD') || '\', 
        'the_grand_budapest_hotel.jpg', 1);




commit;

/* board에 별점 추가 */    
ALTER TABLE BOARD ADD RATING NUMBER(2,1) DEFAULT NULL; 

/* board에 사진 추가 */    
ALTER TABLE BOARD ADD IMAGE_PATH VARCHAR2(255) DEFAULT NULL; 

/* board에 스포일러 추가 */    
ALTER TABLE board ADD spoiler VARCHAR2(1) DEFAULT 'N';

/* BOARD_SEQ 시퀀스에서 다음 값 가져오기 */
SELECT BOARD_SEQ.NEXTVAL FROM DUAL;

/* BOARD_SEQ 시퀀스에서 현재 값 가져오기 */
SELECT BOARD_SEQ.CURRVAL FROM DUAL;

commit;



--about_time.jpg
--avengers_endgame.jpg
--big_fish.jpg
--harry_potter.jpg
--home_alone.jpg
--inception.jpg
--lalaland.jpg
--parasite.jpg
--the_florida_project.jpg
--the_grand_budapest_hotel.jpg
