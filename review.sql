CREATE TABLE dept (
	deptno NUMBER(2) CONSTRAINT dept_deptno_pk PRIMARY KEY,
	dname varchar2(14),
	loc varchar2(13)
);

CREATE TABLE emp (
	empno number(4) CONSTRAINT emp_empno_pk PRIMARY KEY,
	ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(7,2),
    COMM NUMBER(7,2),
    DEPTNO NUMBER(2) 
    CONSTRAINT emp_deptno_fk REFERENCES dept (deptno)
);
CREATE TABLE bonus (
	ename varchar2(20),
	job varchar2(9),
	sal NUMBER,
	comm NUMBER
);
CREATE TABLE salgrade (
	grade NUMBER,
	losal NUMBER,
	hisal NUMBER 
);


--dept
INSERT INTO DEPT (deptno,dname,loc) VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');

INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,to_date('13-JUL-87')-85,3000,NULL,20);
INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,to_date('13-JUL-87')-51,1100,NULL,20);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);


INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

COMMIT;

SELECT * FROM emp;
SELECT * FROM dept;
SELECT * FROM salgrade;

--1. select 
SELECT * FROM emp;
SELECT empno, ename FROM emp WHERE empno = 7369; --empno가 7369인 사람
SELECT * FROM emp WHERE empno = 7369;
--SELECT * FROM members WHERE login_id = 'jjang051' AND login_pw = '1234';
SELECT * FROM emp WHERE deptno = 30 AND job = 'SALESMAN'; -- &&
SELECT * FROM emp WHERE job = 'CLERK' OR deptno = 30 ORDER BY job, deptno;
SELECT * FROM emp WHERE sal >= 3000;
SELECT * FROM emp WHERE sal <= 3000;
SELECT * FROM emp WHERE sal != 3000;
SELECT * FROM emp WHERE job = 'CLERK' OR job = 'SALESMAN' OR job = 'MANAGER';
SELECT * FROM emp WHERE job IN ('CLERK' ,'SALESMAN','MANAGER');
SELECT * FROM emp WHERE deptno IN (10,20,30) ORDER BY deptno, sal DESC;
SELECT * FROM emp WHERE sal >= 2000 AND sal <= 3000;
SELECT * FROM emp WHERE sal BETWEEN 2000 AND 3000 ORDER BY sal;

SELECT * FROM emp WHERE deptno NOT IN (10,20) ORDER BY deptno, sal DESC;
SELECT * FROM emp WHERE sal NOT BETWEEN 2000 AND 3000 ORDER BY sal;

--like
SELECT * FROM emp WHERE ename LIKE 'S%'; --ename이 S로 시작하는 모든 사람
SELECT * FROM emp WHERE ename LIKE '%S%'; --ename이 S가 들어가는 모든 사람
SELECT * FROM emp WHERE ename LIKE '_____'; --ename이 다섯글자인 모든 사람
SELECT * FROM emp WHERE ename LIKE '____S'; --ename이 다섯글자인 모든 사람

SELECT * FROM emp WHERE comm IS NULL; -- null은 = 로 비교 불가
SELECT * FROM emp WHERE comm IS NOT NULL; -- null은 = 로 비교 불가


--단일행 함수 single row function vs group function 
SELECT lower(ename) AS lower_ename,upper(ename) AS upper_ename,initcap(ename) AS initcap_ename FROM emp;
SELECT * FROM emp WHERE lower(ename) LIKE lower('%s%');
SELECT ename , length(ename) FROM emp WHERE LENGTH(ename) >= 5;
SELECT '한글', length('한글'), lengthb('한글'), 'abc',length('abd'), lengthb('abc') FROM dual;
SELECT 'oracle', substr('oracle',1,2) FROM dual;
SELECT ename, substr(ename,1,2) FROM emp;
SELECT substr('210101-1234567',1,6) AS birth FROM dual;
SELECT substr('210101-1234567',-7) AS birth FROM dual;
SELECT instr('oracle','r') FROM dual; --r이 처음 등장하는 자릿수
SELECT instr('hello oracle','l',5) FROM dual; -- 5번째 글자 이후에 나오는 l의 자릿수
SELECT instr('hello oracle lol','l',-1) FROM dual; --뒤에서 부터 찾기
SELECT instr('hello oracle lol','f') FROM dual;

--abcd.pdf에서 filename 찾기, 확장자 찾기
SELECT substr('abcd.pdf',1,instr('abcd.pdf','.',-1)-1) AS filename ,
       substr('abcd.pdf',instr('abcd.pdf','.',-1)+1) AS extension
FROM dual;


SELECT rpad('210101-',14,'*') FROM dual; --오른쪽 채우기
SELECT lpad('210101-',14,'*') FROM dual; --왼쪽 채우기
SELECT concat(empno,ename),empno||ename AS empno_ename FROM emp;     --문자열 합치기
SELECT '     abc    ', ltrim('     abc    ') AS ltrim,
                       rtrim('     abc    ') AS rtrim,
                       trim('     abc    ') AS trim  FROM emp;     --공백제거
                       
SELECT '     abc    ', trim(LEADING FROM '     abc    ') AS ltrim,
                       trim(TRAILING FROM '     abc    ') AS rtrim,
                       trim(BOTH FROM '     abc    ') AS trim  FROM emp;     --공백제거


--
SELECT round(1234.5678) ,
       round(1234.5678,1) ,
       round(1234.5678,2) ,
       round(1234.5678,-1),
       ceil(1234.5678),
       floor(1234.5678),
       MOD(99,4)
FROM dual;

SELECT sysdate AS today,
       sysdate+1 AS tomorrow,
       sysdate-1 AS yesterday,
       sysdate+30 AS "one MONTH later",
       add_months(sysdate,1) AS "one MONTH later"
FROM dual;

SELECT to_char(sysdate,'YYYY-MM-DD DAY HH:MI:SS', 'NLS_DATE_LANGUAGE=KOREAN') 
FROM dual;

--글자를 날짜형태로 바꾸어 넣기
SELECT to_date('2025-10-01', 'YYYY-MM-DD') FROM dual;
SELECT to_date('2025/10/01', 'YYYY/MM/DD') FROM dual;

--null 처리 함수  nvl(), nvl2()
SELECT ename,comm,nvl(comm,0),nvl2(comm,'o','x') FROM emp;

--case when then  switch
SELECT empno,ename,job,sal ,
CASE job 
	WHEN 'MANAGER' THEN sal*1.1
	WHEN 'CLERK' THEN sal*1.5
	ELSE sal*1.25
END AS upsal
FROM emp;

-- 다중행 함수
SELECT  sum(sal) AS sum FROM emp;
SELECT  sum(comm) AS sum FROM emp; --null은 제외
SELECT  count(sal) AS count FROM emp; --null은 제외
SELECT  count(comm) AS count FROM emp; --null은 제외
SELECT  max(sal) AS max,min(sal) AS min, max(sal) - min(sal) AS diff FROM emp; --null은 제외
SELECT  avg(sal) AS abg_sal FROM emp; --null은 제외

--group by일때는 where 절을 쓸 수 없다. having 을 쓰면 된다.
SELECT deptno,sum(sal),avg(sal), max(sal), min(sal) FROM emp
GROUP BY deptno
HAVING avg(sal) > 2000;

--group by를 쓰지 않으면 where를 쓸 수 있다.
SELECT sum(sal),avg(sal), max(sal), min(sal) FROM emp
WHERE sal > 2000;

-- join  가로확장  세로확장쉬운데 가로 확장은 어렵다.
SELECT * FROM emp;
SELECT * FROM dept;
--ansi join
SELECT e.empno,e.ename,e.job,e.sal,deptno,d.dname,d.loc 
FROM emp e NATURAL JOIN dept d;  --알아서 같은 컬럼을 찾음

--등가 조인
SELECT e.empno,e.ename,e.job,e.sal,e.deptno,d.dname,d.loc 
FROM emp e JOIN dept d ON e.deptno = d.deptno;  --inner는 생략 가능하다.

--비등가 조인
SELECT e.empno,e.ename,e.job,e.sal,e.deptno,e.sal,s.grade 
FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;  --inner는 생략 가능하다.

--outer join
SELECT e.empno,e.ename,e.job,e.sal,d.deptno, d.dname,d.loc 
FROM emp e RIGHT OUTER JOIN dept d ON e.deptno = d.deptno;

SELECT e.empno,e.ename,e.job,e.sal,d.deptno, d.dname,d.loc 
FROM dept d FULL OUTER JOIN emp e ON e.deptno = d.deptno;

--안쓴다 이거 썼다가는 망하는 수가 있다.  카타시안곱으로 출력된다.
SELECT e.empno,e.ename,e.job,e.sal,d.deptno, d.dname,d.loc 
FROM dept d CROSS JOIN emp e;

-- emp 테이블에서 job이 'CLERK'인 직원의 이름과 부서명을 출력하세요. 
-- 부서 정보는 dept 테이블에서 가져오세요.
SELECT e.empno,e.ename,e.job, d.dname,d.loc FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE job = 'CLERK';

-- emp 테이블과 dept 테이블을 INNER JOIN하여 각 부서별로 직원 수를 출력하세요.
SELECT d.dname,count(*) AS count FROM emp e
JOIN dept d ON e.deptno = d.deptno
GROUP BY d.dname;

--join을 잘할려면 설계를 잘해야하고...내부 구조를 잘파악하고 있어야 한다.

-- emp, salgrade,dept join을 해서 매니저 번호와 매니지 이름, 부서명, 부서번호, 급여 등급 출력
-- 없는 경우도 다 출력...
SELECT e.empno,e.ename, e.mgr,e.sal, d.deptno, s.grade, e.mgr, e2.ename 
FROM emp e RIGHT JOIN dept d ON e.deptno = d.deptno
           LEFT JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
           LEFT JOIN emp e2 ON e.mgr = e2.empno;

-- 사원이 없는 부선 명과 부서번호 empno 출력

SELECT e.empno,e.ename,e.job, d.dname,d.loc FROM emp e
RIGHT JOIN dept d ON e.deptno = d.deptno
WHERE ename is NULL;


--subquery  쿼리안에 쿼리 또 쓰기....
SELECT * FROM emp WHERE sal > 2975;
SELECT sal FROM emp WHERE ename = 'JONES';

SELECT * FROM emp WHERE sal > (SELECT sal FROM emp WHERE ename = 'JONES');

--scott입사일이 빠른 사람.
SELECT hiredate FROM emp WHERE ename = 'SCOTT';
SELECT * FROM emp 
WHERE hiredate < (SELECT hiredate FROM emp WHERE ename = 'SCOTT');


--jones보다 급여받는 사람 출력
--부서별 최고 급여 받는 사람...
SELECT max(sal) FROM emp GROUP BY deptno;
SELECT * FROM emp WHERE sal IN (2850,3000,5000);

--서브쿼리를 사용하는 이유 
--서버에서 db연결할때 비용이 발생한다.
SELECT * FROM emp WHERE sal IN (
	SELECT max(sal) FROM emp GROUP BY deptno
);

-- any, some ==  하나라도 만족하면 true, all == 싹다 만족하면 true
-- 부서별 최고 급여보다 큰사람 출력
SELECT * FROM emp WHERE sal >= ANY(SELECT max(sal) FROM emp GROUP BY deptno);
SELECT * FROM emp WHERE sal <= some(SELECT min(sal) FROM emp GROUP BY deptno);
SELECT * FROM emp WHERE sal >= all(SELECT max(sal) FROM emp GROUP BY deptno);

-- join, subquery 중요
-- DML 
CREATE TABLE dept_temp AS SELECT * FROM dept WHERE 1=0; --테이블 껍데기만 들고오기
CREATE TABLE dept_temp AS SELECT * FROM dept; -- 테이블 복제
SELECT * FROM dept_temp;
DROP TABLE dept_temp;
INSERT INTO dept_temp (dname, loc,deptno) values('mobile','seoul',60);
COMMIT;

--emp 복제해서 2025-09-30에 입사한 사원 입력 --홍길동
CREATE TABLE emp_temp AS SELECT * FROM emp;
INSERT INTO emp_temp (empno,ename,sal,mgr, hiredate,comm,deptno) 
values(9999,'홍길동',3200, NULL,to_date('2025-09-30','YYYY-MM-DD'),NULL,20);
SELECT * FROM emp_temp;
COMMIT;


-- table lock이 있고 
-- row lock이 있다.
UPDATE emp_temp SET hiredate = sysdate WHERE empno = 9999;
SELECT * FROM emp_temp;
ROLLBACK ;

--delete 
DELETE FROM emp_temp WHERE empno = 9999;
COMMIT;

--rollback , commit


-- ROW lock은 같은 row에 동시에 접근을 할떄 lock이 걸린다. update,delete,insert할때 발생한다.
LOCK TABLE emp_temp IN EXCLUSIVE MODE; --무시해도 된다.
--transaction   일의 한 묶음  접근을 막는다. row에 lock이 생긴다.
--insert , update, delete구문을 쓰면 자동으로 row lock이 걸린다.
--다른데서 접근이 안된다. commit, rollback을 통해 lock을 해제할 수 있다
-- ddl data definition language create,drop, alter 등등
DROP TABLE emp_ddl;
CREATE TABLE emp_ddl (
	empno number(4),
	ename varchar2(10),
	job varchar2(10),
	mgr number(4),
	hiredate date,
	sal number(7,2), 
	comm number(7,2),
	deptno number(2)	
);
ALTER TABLE  emp_ddl 
ADD hp varchar2(20); --컬럼 추가

ALTER TABLE  emp_ddl 
RENAME COLUMN hp TO tel; --컬럼 이름 바꾸기

ALTER TABLE emp_ddl
MODIFY empno number(5);

ALTER TABLE emp_ddl
DROP COLUMN tel;

RENAME emp_ddl TO emp_rename;

SELECT * FROM emp_rename;

DROP TABLE emp_rename;
	
CREATE TABLE emp_ddl (
	empno number(4),
	ename varchar2(10),
	job varchar2(10),
	mgr number(4),
	hiredate date,
	sal number(7,2), 
	comm number(7,2),
	deptno number(2)	
);
--bigo 추가 varchar2(20)
--이름을 remark 바꾸기
--타입도 바꿔보기 varchar2(20)
ALTER TABLE emp_ddl
ADD bigo varchar2(20);

ALTER TABLE emp_ddl
RENAME COLUMN bigo TO remark;

ALTER TABLE emp_ddl
MODIFY remark varchar2(30);

ALTER TABLE emp_ddl
DROP COLUMN remark;

RENAME emp_ddl  TO emp_aaa; --테이블의 이름 바꾸기

DROP TABLE emp_aaa;

SELECT * FROM emp_ddl;



--무결성이 깨지면 안됨..
CREATE TABLE members  (
	userid varchar2(100) CONSTRAINT members_userid_pk PRIMARY KEY,
	userpw varchar2(100) CONSTRAINT members_userpw_nn NOT NULL,
	regdate DATE,
	email varchar2(100)  CONSTRAINT members_email_unq unique
);

CREATE TABLE members02  (
	userid varchar2(100),
	userpw varchar2(100),
	regdate DATE,
	email varchar2(100),
    CONSTRAINT members_userid_pk02 PRIMARY KEY (userid),
    CONSTRAINT members_email_unq02 UNIQUE (email),
    CONSTRAINT members_userpw_nn02 CHECK (userpw IS NOT NULL)
);
CREATE TABLE board  (
	boardid number(5),
	title varchar2(4000),
	content clob,
	regdate DATE,
	writer varchar2(100),
	hit NUMBER,
    CONSTRAINT board_boardid_pk PRIMARY KEY (boardid),
    CONSTRAINT board_writer_fk FOREIGN KEY (writer) REFERENCES members02(userid)
);
--quiz board table 
--     boardid number(5) primary key ,
--     title varchar2(4000),
--     content clob,
--     regdate date,
--     writer varchar2(100),  레퍼런스 member에 userid,
--     hit number
--     insert 해보기

INSERT INTO members02 values('aaa','1234',sysdate,'aaa@aaa.com');
INSERT INTO board values(2,'제목02','내용02',sysdate,'aaa',1);

SELECT * FROM members02;



-- 상품은 product_id로 식별되고, 상품명은 같은 걸로 여러 개 만들 수 있다.
-- 주문은 order_id로 식별된다.
-- 주문 상세는 한 주문 내에서 product_id가 중복되면 안 된다. (복합 유니크)
-- 수량은 1개 이상이어야 한다.
-- 주문 상세는 반드시 존재하는 주문과 상품을 참조해야 한다.

-- 제품테이블 , 주문테이블, 주문상세테이블

CREATE TABLE products02 (
	product_id number(10),
	name varchar2(1000) CONSTRAINT products_name_nn02 NOT NULL,
	price number(10,2) CONSTRAINT products_price_chk02 CHECK(price >= 0),
	CONSTRAINT products_productid_pk02 PRIMARY KEY (product_id)
);
INSERT INTO products02 VALUES (1, 'computer',1000000);
INSERT INTO products02 VALUES (2, 'monitor',300000);
INSERT INTO products02 VALUES (3, 'keyboard',10000);


--status 여기에 준비중,결제완료,취소
CREATE TABLE orders02 (
	order_id number(10),
	order_date DATE DEFAULT sysdate, --안쓰면 현재 날짜
	status varchar2(30) DEFAULT '준비중' 
	CONSTRAINT order_status_chk02 CHECK (status IN ('준비중','결제완료','취소')),
	CONSTRAINT orders_orderid_pk02 PRIMARY KEY (order_id)
);

-- java  enum
INSERT INTO orders02 VALUES (1001, sysdate,'준비중');
INSERT INTO orders02 VALUES (1002, sysdate,'취소');
INSERT INTO orders02 VALUES (1003, sysdate,'결제완료');


--primary key가 하나만 있으란 법은 없다. 만약에 복합키를 primary key는 table 단위에서의 제약조건으로만 가능하다.
CREATE TABLE order_items02 (
	order_id number(10),
	product_id number(10),
	quantity number(10) CONSTRAINT orderitems_quantity_chk02 CHECK (quantity >= 1),
	total_price number(10,2) CONSTRAINT orderitems_totalprice_chk02 CHECK (total_price >= 0),
    CONSTRAINT orderitems_pk02 PRIMARY KEY (order_id,product_id),
	CONSTRAINT orderitems_orderid_fk02 FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE cascade, --삭제할때 연결된걸 같이 지워라
    CONSTRAINT orderitems_productid_fk02 FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items02 VALUES (1001,1,2,9900);
INSERT INTO order_items02 VALUES (1001,2,1,9900);
INSERT INTO order_items02 VALUES (1002,1,2,9900);



























 



















