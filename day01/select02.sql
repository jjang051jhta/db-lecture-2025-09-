-- where는 조건절이라고 부른다.
SELECT * FROM emp;
SELECT * FROM emp WHERE empno = 7369;
SELECT * FROM emp WHERE DEPTNO = 20;
--문자열의 경우 대소문자를 구분한다.
SELECT ename AS "직원 이름", job FROM emp WHERE job = 'SALESMAN';
SELECT * FROM emp WHERE job = 'SALESMAN';
-- and 조건 둘다 만족
SELECT * FROM emp deptno WHERE deptno = 30 AND job = 'SALESMAN';
-- and 조건 둘 중 하나만 만족해도 될떄
SELECT * FROM emp WHERE deptno = 30 OR job = 'CLERK' ORDER BY deptno desc;
-- 이상일때
SELECT * FROM emp WHERE sal >= 3000;
-- 이하일때
SELECT * FROM emp WHERE sal <= 3000;
-- 이상 이하 문자열 처리  알파벳 순서
SELECT * FROM emp WHERE ename >= 'F';
-- 이상 이하 문자열 처리  알파벳 순서
SELECT * FROM emp WHERE ename <= 'F';
-- 다르다  != , <> , ^=
SELECT * FROM emp WHERE sal != 3000;
SELECT * FROM emp WHERE sal <> 3000;
SELECT * FROM emp WHERE sal ^= 3000;
-- quiz job이 MANAGER, SALESMAN, CLERK
SELECT * FROM emp WHERE job = 'MANAGER' OR job = 'SALESMAN' OR job = 'CLERK';
-- or조건 여러개 일때는 좀 줄여쓰는게 필요하다. in 구문을 쓰면 편하다. 
SELECT * FROM emp WHERE job IN ('MANAGER','SALESMAN','CLERK');

-- 10, 30 부서 인원 조회
SELECT * FROM emp WHERE deptno = 10 OR deptno = 30;
SELECT * FROM emp WHERE deptno IN (10,30);  -- in은 OR 조건
SELECT * FROM emp WHERE job NOT IN ('MANAGER','SALESMAN','CLERK');

-- quiz sal 2000이상 3000이하  2000~3000
SELECT * FROM emp WHERE sal >= 2000 AND sal <=3000;
-- and 조건을 between으로 처리할 수 있다.
SELECT * FROM emp WHERE sal BETWEEN 2000 AND 3000;
-- or 조건을 not between으로 처리할 수 있다.
SELECT * FROM emp WHERE sal 2000 < 2000 OR sal > 3000;
-- and 조건을 between으로 처리할 수 있다.
SELECT * FROM emp WHERE sal NOT BETWEEN 2000 AND 3000;

--중요한거  s로 시작하는 사람 조회 홍로 홍로사과 %는 어떤게 와도 상관없다. 
SELECT * FROM emp WHERE ename LIKE 'S%';
SELECT * FROM emp WHERE ename LIKE '%ER';
SELECT * FROM emp WHERE ename LIKE '%AR%';

-- 이름 중에 M과 I가 동시에 존재하는 사원 검색 M이 먼저 나와야 한다.
SELECT * FROM emp WHERE ename LIKE '%M%I%';

-- 이름이 다섯 글자인 사람
SELECT * FROM emp WHERE ename LIKE '%M%I%';
-- _는 자릿수를 결정한다.
SELECT * FROM emp WHERE ename LIKE '_____';

-- _는 자릿수를 결정한다.
SELECT * FROM emp WHERE ename LIKE '____S';

-- 이름 중에 두번째 글자가 L인 사람
SELECT * FROM emp WHERE ename LIKE '_L%';


--1. 이름이 N으로 끝난느 사람
SELECT * FROM emp WHERE ename LIKE '%N';
--2. 이름의 세번째 글자가 A인 사람
SELECT * FROM emp WHERE ename LIKE '__A%';
--3. 이름의 A로 시작하는 사람
SELECT * FROM emp WHERE ename LIKE 'A%';

-- null 비교
SELECT ename,comm FROM emp;
-- null은 = 로 찾을 수 없다. is 키워드를 써야 한다.
SELECT ename,comm FROM emp WHERE comm IS NULL;

SELECT ename,comm FROM emp WHERE comm IS NOT NULL;

-- null은 비교연산으로 처리 불가능하다.  함수로 처리 가능 nvl(), nvl2()로 처리해야 한다.
SELECT ename,comm FROM emp WHERE comm > NULL;  


--집합연산자  
--union은 합집합
SELECT empno, ename, sal, deptno FROM emp WHERE deptno=10
union
SELECT empno, ename, sal, deptno FROM emp WHERE deptno=20;

--union은 합집합 컬럼이 두개가 일치해야한다.
SELECT empno, ename, sal, deptno FROM emp WHERE deptno=10
union
SELECT empno, ename, sal FROM emp WHERE deptno=20;

--union은 합집합 컬럼이 일치해야한다. 만약 순서가 다르면 먼저인걸 따른다.
SELECT empno, ename, deptno, sal FROM emp WHERE deptno=10
union
SELECT empno, ename, sal, deptno FROM emp WHERE deptno=20;

--union은 합집합 만약 조건이 같으면 중복은 제외된다.
SELECT empno, ename, deptno, sal FROM emp WHERE deptno=10
union
SELECT empno, ename, deptno, sal FROM emp WHERE deptno=10;

--union all 은 합집합 만약 조건이 같아도 중복을 허용한다.
SELECT empno, ename, deptno, sal FROM emp WHERE deptno=10
UNION ALL 
SELECT empno, ename, sal, deptno FROM emp WHERE deptno=10;

--minus 은  차집합
SELECT empno, ename, deptno, sal FROM emp
MINUS  
SELECT empno, ename, deptno, sal FROM emp WHERE deptno=10;

--intersect 은  교집합
SELECT empno, ename, deptno, sal FROM emp
INTERSECT 
SELECT empno, ename, deptno, sal FROM emp WHERE deptno=10;



--01. s로 끝나는 사원 
SELECT * FROM emp WHERE ename LIKE '%S';

--02. 30번 부서에 근무하는 사원
SELECT empno,ename,job,sal, deptno  FROM emp 
WHERE deptno = 30 
AND job = 'SALESMAN';

--03. 20,30번 부서 근무하는 sal > 2000
--0301 집합연산 쓰지 않고
SELECT empno,ename,job,sal, deptno FROM emp
WHERE (deptno = 20 OR deptno = 30) AND sal > 2000;

SELECT empno,ename,job,sal, deptno FROM emp
WHERE deptno  IN (20,30) 
AND sal > 2000;

--0302 집합연산 쓰고
SELECT empno,ename,job,sal, deptno FROM emp
WHERE deptno = 20 AND sal > 2000
UNION 
SELECT empno,ename,job,sal, deptno FROM emp
WHERE deptno = 30 AND sal > 2000;


--0303 집합연산 쓰고
SELECT empno,ename,job,sal, deptno FROM emp
WHERE sal > 2000 
INTERSECT  
SELECT empno,ename,job,sal, deptno FROM emp
WHERE deptno  IN (20,30) ORDER BY deptno, sal desc;

--04. not between 을 쓰지 않고 sal 2000이상 3000 이하 이외의 값
SELECT * FROM emp WHERE sal < 2000 OR sal > 3000;

--0402. not between을 쓰고
SELECT * FROM emp WHERE sal not BETWEEN 2000 AND 3000;  -- >=  AND <= 

--05. 사원이름에 E가 포함된 30번 부서의 사원 중 급여가 1000~2000 사이가 아닌 사람
-- C(insert)R(select)U(update)D(delete)
SELECT ename, empno,sal,deptno FROM emp
WHERE deptno = 30 
AND ename LIKE '%E%' 
AND sal NOT BETWEEN 1000 AND 2000;

--06. 추가수당이 없고, 상급자가 있고 직책이 Manager, clerk 인 사원중에 사원이름의 두번째 글자가
--L이 아닌 사원 정보
SELECT * FROM emp
WHERE comm IS NULL 
AND MGR IS NOT NULL
AND JOB IN ('MANAGER','CLERK')
AND ename NOT LIKE '_L%';
































