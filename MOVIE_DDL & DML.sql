---- 1. ���� Ȯ�� �� ���� ����
--show user;
--
--/* sys���� �۾� */
--CREATE USER mreview IDENTIFIED BY 1234;
--GRANT CONNECT, RESOURCE TO mreview;
--GRANT UNLIMITED TABLESPACE TO mreview;

/* mreview ���� ���� */

/* 2. ���̺� ����  */
CREATE TABLE ROLE (
   ROLE_ID   VARCHAR2(20)   NOT NULL,    -- ��� ��ȣ(�⺻Ű)
   ROLE_NAME   VARCHAR2(20)   NOT NULL,  -- ��� �̸�
  CONSTRAINT PK_ROLE PRIMARY KEY (ROLE_ID)   -- �⺻Ű����
);


/* ��� ���̺� ���� */
CREATE TABLE MEMBER (                     
   MEMBER_ID VARCHAR2(100)   NOT NULL,   -- ���� ID(�⺻Ű)
   ROLE_ID   VARCHAR2(20)   NOT NULL,    -- ���� ���(�ܷ�Ű)
   PASSWORD VARCHAR2(20)   NOT NULL,     -- ���� PASSWORD
   EMAIL VARCHAR2(50)   NOT NULL,        -- ���� EMAIL
   REG_DATE DATE   DEFAULT SYSDATE,      -- ���� ������
   ADDRESS   VARCHAR2(100)   NOT NULL,   -- ���� �ּ�
   PHONE   VARCHAR2(20)   NOT NULL,      -- ���� �޴��� ��ȣ
   NAME   VARCHAR2(10)   NOT NULL,       -- ���� �̸�
  CONSTRAINT PK_MEMBER PRIMARY KEY (MEMBER_ID),   -- �⺻Ű����
  CONSTRAINT FK_ROLE_MEMBER FOREIGN KEY (ROLE_ID) REFERENCES ROLE (ROLE_ID)   -- �ܷ�Ű����
);

/* ��ȭ ���̺� ���� */
CREATE TABLE MOVIE (  
   MOVIE_ID   NUMBER   NOT NULL,          -- ��ȭID(�⺻Ű, ������)
   NAME   VARCHAR2(100)   NOT NULL,         -- ��ȭ�� 
   DESCRIPTION   VARCHAR2(1000)   NOT NULL, -- ��ȭ ����
   MOVIE_DATE  DATE NOT NULL,       -- ��ȭ ������
   REG_DATE   DATE   DEFAULT SYSDATE,       -- �����
  CONSTRAINT PK_MOVIE PRIMARY KEY (MOVIE_ID)   -- �⺻Ű����
);

/* ��ȭ �̹��� ���̺� ���� */
CREATE TABLE PROD_IMG (
   IMG_ID   NUMBER   NOT NULL,      -- ��ȭ�̹���id(������)
   MOVIE_ID   NUMBER   NOT NULL,      -- ��ȭid(�ܷ�Ű)
   IMG_PATH   VARCHAR2(500)   NOT NULL,   -- ��ȭ �̹��� ���(�ϵ��ũ�� ���, DB�� �����)
   FILE_NAME   VARCHAR2(500)   NOT NULL,   -- ��ȭ �̹����� (�������� ���ϸ�, DB�� �����)-- �̹����� �������� ��� ��ǥ�̹��� (0-��ǥ�̹���, 1-�߰��̹���)
   IS_MAIN   NUMBER(1)   default 0,         -- �̹����� �������� ��� ��ǥ�̹��� (0-��ǥ�̹���, 1-�߰��̹���)
  CONSTRAINT PK_PROD_IMG PRIMARY KEY (IMG_ID),   -- �⺻Ű����
  CONSTRAINT FK_PROD_IMG FOREIGN KEY (MOVIE_ID) REFERENCES MOVIE (MOVIE_ID)   -- �ܷ�Ű����
);

/* �Խñ� ���̺� ���� */
CREATE TABLE BOARD (
   BOARD_NO   NUMBER   NOT NULL,          -- �Խ��� ��ȣ(�⺻Ű, ������)
   MEMBER_ID   VARCHAR2(100)   NOT NULL,   -- ��� ���̵�(�ܷ�Ű)
   TITLE   VARCHAR2(255)   NOT NULL,       -- ����
   CONTENT CLOB NOT NULL,              -- ����
   HIT_NO   NUMBER(4)   DEFAULT 0,        -- ��ȸ��
   REG_DATE   DATE   DEFAULT SYSDATE,    -- �ۼ�����
   REPLY_GROUP   NUMBER(5)   DEFAULT 0, -- ����� �׷��� ����
   REPLY_ORDER   NUMBER(5)   DEFAULT 0, -- ����� ����
   REPLY_INDENT   NUMBER(5)   DEFAULT 0, -- ����� �ٸ� ��ۿ� ���� ���� �������(��, ��������) ����, �鿩�������
  CONSTRAINT PK_BOARD PRIMARY KEY (BOARD_NO),   -- �⺻Ű����
  CONSTRAINT FK_BOARD FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER (MEMBER_ID)   -- �ܷ�Ű����
);

-- 3. ������ ����

-- 3.1 ��ȭID�� ������
create sequence seq_movie
start with 1
increment by 1
nocache    -- ĳ��(������ ��ȣ �޸� �Ͻ� ����) ����
nocycle;   -- �ִ�ġ �ʰ��� ó������ �ٽ� ����

-- 3.2 ��ȭ�̹���ID�� ������
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

CREATE SEQUENCE cart_seq  -- shopping_cart ������
start with 1 -- 1����
increment by 1  -- 1����
nocache -- ĳ��(������ ��ȣ �޸� �Ͻ� ����) ����
nocycle; -- �ִ�ġ �ʰ��� ó������ �ٽ� ����

CREATE SEQUENCE order_seq -- order ������
start with 1 -- 1����
increment by 1  -- 1����
nocache -- ĳ��(������ ��ȣ �޸� �Ͻ� ����) ����
nocycle; -- �ִ�ġ �ʰ��� ó������ �ٽ� ����


/* ���� ������ ���� insert */
insert into role(role_id, role_name) values('admin', '������');
insert into role(role_id, role_name) values('member', '��ȸ��');
insert into role(role_id, role_name) values('guest', '��ȸ��');

/* �⺻ ��� ���� insert */
INSERT INTO member(member_id, password, name, email, reg_date)
values('hong', '1234', 'ȫ�浿', 'abc@naver.com', sysdate);

INSERT INTO member(member_id, password, name, email, reg_date)
values('lee', '1234', '������', 'lee@naver.com', sysdate);

INSERT INTO member(member_id, password, name, email, role_id, address, phone, reg_date)
values('jang', '1234', '�����', 'jang@naver.com',  'member', '��õ ������ ������� 123-2', '010-3333-3422', sysdate);


INSERT INTO member(member_id, password, name, email, reg_date)
values('kim', '1234', '���̼�', 'kim@naver.com', sysdate);

/* �⺻ �Խñ� ���� insert */
INSERT INTO BOARD(BOARD_NO, TITLE, CONTENT, MEMBER_ID, REG_DATE)
VALUES(1, 'ù��° �Խù�', '�̰��� ù��° �Խù�', 'hong', SYSDATE);

INSERT INTO BOARD(BOARD_NO, TITLE, CONTENT, MEMBER_ID, REG_DATE)
VALUES(2, '�ι�° �Խù�', '�̰��� �ι�° �Խù�', 'lee', SYSDATE);

INSERT INTO BOARD(BOARD_NO, TITLE, CONTENT, MEMBER_ID, REG_DATE)
VALUES(3, '����° �Խù�', '�̰��� ����° �Խù�', 'kim', SYSDATE);

commit;

DELETE FROM SHOPPING_CART 
      WHERE SP_CART_ID = 5;
        
--INSERT INTO ORDER_INFO ( ORDER_ID, MOVIE_ID, MEMBER_ID, MOVIE_NAME, MOVIE_DATE, QUANTITY, ADDRESS, PHONE)
--VALUES(seq_order_info.NEXTVAL,


<update id="updateMember" parameterType="MemberVo">
        UPDATE member
        SET password = 1234,
            name = '���¡',
            email = 'jang@naver.com',
--            role_id = '',
            phone = '010-3333-3422',
            address = '��õ ������ ������� 123-2'
        WHERE member_id = 'jang'
    </update>;
    
UPDATE member
SET password = '1234',
    name = '���¡',
    email = 'jang@naver.com',
    phone = '010-3333-3422',
    address = '��õ ������ ������� 123-2'
WHERE member_id = 'jang'