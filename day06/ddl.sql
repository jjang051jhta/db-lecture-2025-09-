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

INSERT INTO emp_ddl (empno,ename,job,mgr,hiredate,sal,comm,deptno) 
VALUES (1000,'김수한','영업사원',2000,
	to_date('2025-09-25','YYYY-MM-DD'),
	2800,
	1000,
	20);

INSERT INTO emp_ddl (empno,ename,job,mgr,hiredate,sal,comm,deptno) 
VALUES (1000,'김수한','영업사원',2000,
	to_date('2025-09-25','YYYY-MM-DD'),
	999999.9,
	1000,
	20);
COMMIT;









