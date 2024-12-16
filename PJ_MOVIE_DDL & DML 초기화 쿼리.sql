-- 트리거 삭제
DROP TRIGGER set_reply_group_trigger;

-- 시퀀스 삭제
DROP SEQUENCE seq_movie;
DROP SEQUENCE board_seq;
DROP SEQUENCE reply_group_sequence;
DROP SEQUENCE seq_img;

-- 테이블 삭제 (외래 키 제약 조건 때문에 순서 중요)
DROP TABLE PROD_IMG;
DROP TABLE BOARD;
DROP TABLE MOVIE;
DROP TABLE MEMBER;
DROP TABLE ROLE;
