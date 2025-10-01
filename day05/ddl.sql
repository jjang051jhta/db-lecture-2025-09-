-- sql DML (Data Manipulation Language)  select 
-- DDL DCL TCL
-- insert , update, delete  
-- select는 테이블에 영향을 미치지 않음
-- 테이블 만드는 방법
CREATE TABLE dept_temp 
AS SELECT * FROM dept;

DROP TABLE dept_temp CASCADE CONSTRAINTS;  
--제약사항 다른 테이블이 삭제할 테이블을 참조하고 있으면 삭제 안됨.
--제약사항이 걸려있는 테이블이 삭제되면서 기존 제약사항도 같이 삭제
TRUNCATE TABLE dept_temp;  -- 테이블에 있는 모든 데이터 삭제

SELECT * FROM dept_temp;

INSERT INTO dept_temp (deptno, dname,loc) 
VALUES (50,'DATABASE','ILSAN');

--갯수가 안맞음
INSERT INTO dept_temp (deptno, dname,loc) 
VALUES (60,'NETWORK');

--타입이 안맞음
INSERT INTO dept_temp (deptno, dname,loc) 
VALUES ('BAD','NETWORK','BUNDANG');


--컬럼을 지우면 순서 맞추고 처음 부터 마지막 컬럼까지 넣어야 한다.
INSERT INTO dept_temp  
VALUES (60,'NETWORK','BUNDANG');

--명시적을 null을 넣는게 좋다.
INSERT INTO dept_temp (deptno, dname,loc) 
VALUES (70,'MOBILE',NULL);

--공백을 넣으면 null이 들어간다 별로 좋지 않다.
INSERT INTO dept_temp (deptno, dname,loc) 
VALUES (80,'WEB','');

SELECT * FROM dept_temp;

CREATE TABLE emp_temp 
AS SELECT * FROM emp;
TRUNCATE TABLE emp_temp;
SELECT * FROM emp_temp;

DROP TABLE emp_temp;

--껍데기만 들고오기 조건을 만족하지 않기 때문에 틀만 들고올때 쓴다.
CREATE TABLE emp_temp 
AS SELECT * FROM emp WHERE 1 = 0;
SELECT * FROM emp_temp;

INSERT INTO emp_temp 
(empno,ename,job,mgr,hiredate,sal,comm,deptno) 
VALUES (2000,'장동건','MANAGER',NULL,
to_date('2025-09-29','YYYY-MM-DD'),4000,200,10);

INSERT INTO emp_temp 
(empno,ename,job,mgr,hiredate,sal,comm,deptno) 
VALUES (2001,' 유재석','SALESMAN',NULL,
to_date('2025/09/28','YYYY/MM/DD'),4000,200,10);

--to_date()를 사용하면 날짜를 포맷에 맞춰서 넣을 수 있다.
-- html input type = date  2025-09-25 -
-- 생일 to_date() , 회원가입 날짜 sysdate
INSERT INTO emp_temp 
(empno,ename,job,mgr,hiredate,sal,comm,deptno) 
VALUES (2002,'정형돈','SALESMAN',NULL,
sysdate,4000,200,10);
SELECT * FROM emp_temp;
-- update
CREATE TABLE dept_temp02 
AS SELECT * FROM dept;
  
SELECT * FROM dept_temp02;
-- 수정할때 update 반드시 조건을 달아서 수정해야한다.
-- insert, update,delete할때 transaction 처리할때 쓴다.
-- TCL  (ROLLBACK, COMMIT)
UPDATE dept_temp02 SET loc = 'ILSAN';
UPDATE dept_temp02 SET loc = 'SEOUL' WHERE deptno=40;
COMMIT;
ROLLBACK;
-- auto commit
-- create table 은 tcl의 대상이 아니다. rollback, commit;
CREATE TABLE emp_temp02 
AS SELECT * FROM emp;
SELECT * FROM emp_temp02;
DELETE FROM emp_temp02 WHERE job = 'MANAGER';
TRUNCATE table emp_temp02; -- 전체삭제
DELETE FROM emp_temp02; --전체삭제

CREATE TABLE chap10hw_emp 
AS SELECT * FROM emp;

CREATE TABLE chap10hw_dept 
AS SELECT * FROM dept;

CREATE TABLE chap10hw_salgrade 
AS SELECT * FROM salgrade;

SELECT * FROM chap10hw_emp;
SELECT * FROM chap10hw_dept;
SELECT * FROM chap10hw_salgrade;

INSERT INTO chap10hw_dept (deptno,dname,loc)
VALUES (50,'ORACLE','BUSAN');
INSERT INTO chap10hw_dept (deptno,dname,loc)
VALUES (60,'SQL','ILSAN');
INSERT INTO chap10hw_dept (deptno,dname,loc)
VALUES (70,'SELECT','INCHEON');
INSERT INTO chap10hw_dept (deptno,dname,loc)
VALUES (80,'DML','BUNDANG');

COMMIT;

INSERT INTO chap10hw_emp 
VALUES (7201,'TEST_USER','MANAGER',7788,
to_date('2016/01/02','YYYY/MM/DD'),4500,NULL,50);



SELECT * FROM chap10hw_emp;

UPDATE chap10hw_emp SET deptno = 70
WHERE sal > 
(SELECT avg(sal) FROM chap10hw_emp WHERE deptno = 50);

UPDATE chap10hw_emp SET 
sal = sal*1.1, 
deptno = 80 
WHERE hiredate > 
(SELECT min(hiredate)  FROM chap10hw_emp WHERE deptno = 60);

SELECT * FROM chap10hw_emp;

DELETE FROM chap10hw_emp WHERE empno IN (
	SELECT e.empno FROM chap10hw_emp e 
	JOIN chap10hw_salgrade s
	ON e.sal BETWEEN s.losal AND s.hisal
	WHERE s.grade = 5
);


ROLLBACK;


-- TCL transaction control language
COMMIT;
ROLLBACK;

CREATE TABLE dept_tcl 
AS SELECT * FROM dept;

SELECT * FROM dept_tcl;

INSERT INTO dept_tcl (deptno, dname,loc) 
VALUES (50,'DB','SEOUL');

UPDATE dept_tcl SET loc = 'BUSAN' WHERE deptno=40;

DELETE FROM dept_tcl WHERE dname = 'RESEARCH';

COMMIT;
ROLLBACK;   
-- TRANSACTION 은 일의 묶음  (입금 / 출금)   COMMIT / rollback


SELECT * FROM dept_tcl;

DELETE FROM dept_tcl WHERE deptno = 50;

COMMIT;

--lock  잠그기...
UPDATE dept_tcl SET loc = 'AAAA' WHERE deptno=40;

-- db에 접속을 한  특정 session(연결되 계정)에서 
-- insert,update,delete를 수행할때 lock을 걸어둔다.
-- 이러면 다른 session에서는 insert,update,delete는  
-- 수행되지 않는다.
-- 반드시 commit; rollback을 해야지만 다른 세션에서의
-- insert,update,delete가 수행된다.




-- java에서 auto commit을 설정할 수 있다.
-- table 만들기 DDL  create 생성, drop 지우기, alter 변경
-- create table 테이블 이름 (
	--컬럼명 자료형,
	--컬럼명 자료형,
	--컬럼명 자료형,
	--컬럼명 자료형,
	--컬럼명 자료형
--)

DROP TABLE emp_ddl;
--fjdksj
CREATE TABLE emp_ddl (
	empno     number(4),
	ename     varchar2(100),
	job       varchar2(100),
	mgr       number(4),
	hiredate  DATE,
	sal       number(7,2),
	comm      number(7,2),
	deptno    number(2)
);

--한글은 3byte이므로 계산 잘해야함...
INSERT INTO emp_ddl (empno,ename,job,mgr,hiredate,sal,comm,deptno) 
VALUES (1000,'김수한','영업사원',2000,
	to_date('2025-09-25','YYYY-MM-DD'),
	2800,
	1000,
	20);


CREATE TABLE emp_ddl_30 
AS SELECT * FROM emp WHERE deptno=30;
SELECT * FROM emp_ddl_30;
CREATE TABLE emp_dept_ddl 
AS 
SELECT e.empno, 
       e.ename, 
       e.job,
       e.hiredate, 
       e.sal, e.comm, 
	   d.deptno,d.dname, d.loc
FROM emp e JOIN dept d ON e.deptno = d.deptno
WHERE 1 = 0;
SELECT * FROM emp_dept_ddl;
DROP TABLE emp_dept_ddl;



DROP TABLE board;
-- long 은 2gb 저장 가능 대신 테이블당 하나만 가능
-- clob 은 4bg ~ 128tb character large object (텍스트 저장)
-- blob 은 4bg ~ 128tb binary large object  (이미지, 영상 등등 raw)
-- base64 인코딩 이미지를 텍스트로 바꿔서 저장하는 방법
-- 파일을 전달받아서 다른 곳 저장에 옮겨서 저장을 하고 그 이미지의 경로를 저장해둔다.
CREATE TABLE board (
	subject varchar2(100),  --가변 데이터
--	content LONG,
	content_clob clob,   --가변데이터 100
	content_blob blob,   
	file_name varchar2(1000), -- fkjdksjfkldjsfd.jpg
);
--number(precision,scala)
CREATE TABLE numbers (
	num01 number,
	num02 number(3),
	num03 number(3,2),
	num04 number(5,2),
	num05 number(7,1),
	num06 number(7,-1),
	num07 number(4,5),
	num08 number(4,5),
	num09 number(4,7)
);
INSERT into numbers (num01) VALUES (1000000000000000000000000000000000000);
INSERT into numbers (num02) VALUES (999.4); -- 정수 3자리
INSERT into numbers (num03) VALUES (12); -- 정수 3자리
INSERT into numbers (num04) VALUES (1000.555); -- 정수 3자리
INSERT into numbers (num05) VALUES (123.5); -- 정수 3자리
INSERT into numbers (num06) VALUES (126.74); -- 정수 3자리
INSERT into numbers (num07) VALUES (0.01234);
INSERT into numbers (num09) VALUES (0.0001234); 
-- 예전에 쓴 코드 만나면 알아만 두시면 됩니다.
--소수점 이하 5자리까지 유효 숫자가 맞아야 함
--p보다 s가 큰 경우 정수는 못쓴다. p가 유효한 소수의 자리수이다.
-- 소수의 자릿수를 맞춰서 쓰면 된다.

SELECT * FROM numbers;

-- alter는 바꾸기....
CREATE TABLE emp_alter 
AS SELECT * FROM emp;
SELECT * FROM emp_alter;
-- ALTER 로 할 수 있는 것들 add(컬럼 추가), rename(컬럼이름변경), modify(데이커 타입 변경)
ALTER TABLE emp_alter
ADD hp varchar2(20);

ALTER TABLE emp_alter
RENAME COLUMN hp TO tel;

ALTER TABLE emp_alter
MODIFY empno NUMBER(5); 
--타입을 바꿀때는 크게 바꾸는건 문제가 되지 않는다, 
--작게 바꿀때는 유의해야 한다.

ALTER TABLE emp_alter
DROP COLUMN tel; -- 다른 테이블과 연관되어 있으면 유의해야 한다. 지워지지 않는다.
--ddl은 커밋없음

--테이블의 이름 바꾸기....
RENAME emp_alter TO emp_rename;
SELECT * FROM emp_rename;
TRUNCATE TABLE emp_rename; --데이터 삭제 주의할점은 transaction없다. 바로 삭제 된다.
DELETE FROM emp_rename; -- 롤백이 가능하다. 
--오라클에 없음... mysql, postgre
--DROP TABLE IF EXISTS emp_rename;
-- empno,ename,job,mgr,hiredate, sal, comm, deptno
CREATE TABLE emp_hw (
	empno     number(4),
	ename     varchar2(10),
	job       varchar2(9),
	mgr       NUMBER(4),
	hiredate  date, 
	sal       NUMBER(7,2), 
	comm      NUMBER(7,2), 
	deptno    number(2)
);
SELECT * FROM emp_hw;
--02. bigo
ALTER TABLE emp_hw 
ADD bigo varchar2(20);

--02. bigo 열크기를 30으로 변경
ALTER TABLE emp_hw
MODIFY bigo varchar2(30);

ALTER TABLE emp_hw 
RENAME COLUMN bigo TO remark;

INSERT INTO emp_hw (SELECT empno,ename,job,mgr,hiredate,sal,comm, deptno, NULL 
FROM emp);
DROP TABLE emp_hw;


--1. STUDENT 테이블을 생성하세요.
--컬럼: 학번(STUD_ID) 숫자(4), 이름(NAME) 가변문자(20), 학년(GRADE) 숫자(1), 입학일(ADMISSION_DATE) 날짜형

CREATE TABLE  STUDENT(
	STUD_ID number(4),
	NAME varchar2(40),
	GRADE number(1),
	ADMISSION_DATE date
);
SELECT * from STUDENT;

--2. BOOK 테이블을 생성하세요.
--컬럼: 책번호(BOOK_ID) 숫자(5), 제목(TITLE) 가변문자(50), 가격(PRICE) 숫자(7,2)
CREATE TABLE  BOOK(
	BOOK_ID number(5),
	TITLE varchar2(50),
	PRICE number(7,2)
);

--3. 컬럼 추가STUDENT 테이블에 이메일(EMAIL) 컬럼(가변문자 50)을 추가하세요.
ALTER TABLE STUDENT 
ADD email varchar2(50);
SELECT * from STUDENT;

--4. 컬럼 자료형 변경 BOOK 테이블의 TITLE 컬럼 크기를 100자로 변경하세요.
ALTER TABLE book
MODIFY TITLE varchar2(100);


--5. 컬럼 이름 변경 STUDENT 테이블의 NAME 컬럼을 STUDENT_NAME 으로 이름 변경하세요.
ALTER TABLE student 
RENAME COLUMN name TO STUDENT_NAME;

--6. 컬럼 삭제 STUDENT 테이블에서 GRADE 컬럼을 삭제하세요.
ALTER TABLE STUDENT
DROP COLUMN GRADE;

--7. 테이블 이름 변경 BOOK 테이블의 이름을 BOOK_INFO 로 변경하세요.
ALTER TABLE book RENAME TO book_info;
SELECT * FROM book_info;

--8. STUDENT 테이블의 구조만 복제하여 STUDENT_COPY 테이블을 생성하세요.
CREATE TABLE STUDENT_COPY
AS SELECT * FROM student WHERE 1 = 0;
SELECT * FROM STUDENT_COPY;

--9. STUDENT 테이블의 모든 데이터를 삭제하되, 구조는 유지하세요.
SELECT * FROM student;

INSERT INTO student (stud_id, student_name,admission_date,email) VALUES 
(1111,'장성호',sysdate, 'jjang051@fdfhds.com');
INSERT INTO student (stud_id, student_name,admission_date,email) VALUES 
(2222,'장동건',sysdate, 'jjang051@fdsjfkjdskflds.com');
COMMIT;
TRUNCATE TABLE  student;
DELETE FROM student;
COMMIT;

--10. BOOK_INFO 테이블을 완전히 삭제하세요.
DROP TABLE BOOK_INFO CASCADE CONSTRAINTS;
-- 제약조건



