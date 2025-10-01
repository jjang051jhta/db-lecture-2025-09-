-- subquery  쿼리안에 쿼리 쓰느거...
-- jones 의 sal 보다 많이 받는 사람...
SELECT sal FROM emp WHERE ename = 'JONES';
SELECT ename, sal 
FROM emp 
WHERE sal >= (SELECT sal FROM emp WHERE ename = 'JONES');

-- 조건절에 쓴 subquery
-- allen보다 커미션을 많이 받는 사람 출력

SELECT ename , comm FROM emp WHERE ename = 'ALLEN';
SELECT ename , comm FROM emp WHERE comm >= 300;
SELECT ename , comm 
FROM emp WHERE comm >= 
	(SELECT comm FROM emp WHERE ename = 'ALLEN');

--scott보다 일찍 입사한 사람...
SELECT hiredate  FROM emp WHERE ename = 'SCOTT';

SELECT ename, hiredate FROM emp
WHERE HIREDATE < (SELECT hiredate  FROM emp WHERE ename = 'SCOTT');

-- 20번 부서에 근무하는 사원중 전체 사원의 평균 급여보다 많이 받는 사람의 이름과 잡 부서번호와 부서이름
SELECT avg(sal) FROM emp; --결과가 하나
SELECT e.empno, e.ename,e.job,e.sal,d.deptno,d.dname 
FROM emp e JOIN dept d ON e.deptno = d.DEPTNO 
WHERE e.deptno = 20 AND e.sal > (SELECT avg(sal) FROM emp);

--20,30
SELECT * FROM emp WHERE deptno = 20 OR deptno = 30;
SELECT * FROM emp WHERE deptno IN (20,30);

--부서별 최고 급여 받는 사람
SELECT * FROM EMP e  WHERE sal IN 
	(SELECT max(sal) AS max_sal FROM emp GROUP BY deptno);

SELECT deptno, max(sal) AS max_sal FROM emp
GROUP BY deptno;


--any 다중행을 반환받았을때 하나라도 참이면 결과 출력
SELECT * FROM EMP e  WHERE sal = ANY (SELECT max(sal) AS max_sal FROM emp GROUP BY deptno);
SELECT * FROM EMP e  WHERE sal = SOME (SELECT max(sal) AS max_sal FROM emp GROUP BY deptno);

--30번 부서의 최대급여보다 작은 사람 출력
SELECT * FROM EMP e  WHERE sal < ANY (SELECT sal FROM emp WHERE deptno = 30);
SELECT * FROM EMP e  WHERE sal < ANY (SELECT max(sal) AS max_sal FROM emp WHERE deptno = 30);

--30번 부서의 최소급여보다 큰 사람 출력
SELECT * FROM EMP e  WHERE sal > ANY (SELECT sal FROM emp WHERE deptno = 30);
SELECT * FROM EMP e  WHERE sal > ANY (SELECT min(sal) AS min_sal FROM emp WHERE deptno = 30);

-- ALL  싹다 만족 하면....
-- 30번 부서의 최소 급여보다 작은 사람 출력
SELECT * FROM EMP e  WHERE sal < ALL (SELECT sal FROM emp WHERE deptno = 30);  

-- ALL  싹다 만족 하면....
-- 30번 부서의 최대 급여보다 작은 사람 출력
SELECT * FROM EMP e  WHERE sal > ALL (SELECT sal FROM emp WHERE deptno = 30);
SELECT sal FROM emp WHERE deptno = 30;

--  exists는  하나라도 있으면 전부 true, 없으면 false
SELECT * FROM emp WHERE EXISTS (SELECT dname FROM dept WHERE deptno = 40);

-- from 절에 쓰는 subquery inline view 라고 한다.
-- 10번 부서에 근무하는 사원이름과 10번부서의 loc
SELECT  e10.empno,e10.ename,e10.deptno,d.dname, d.loc 
FROM (SELECT * FROM emp WHERE deptno=10) e10 
JOIN (SELECT * FROM dept) d ON e10.deptno = d.deptno

WITH e10 AS (SELECT * FROM emp WHERE deptno=10),
     d   AS (SELECT * FROM dept)
SELECT e10.empno,e10.ename,e10.deptno,d.dname, d.loc 
FROM e10 
JOIN d ON e10.deptno = d.deptno;

-- select 절에 쓰는 subquery 다른 말로 scalar subquery 단일행 단일 값을 반환해야 한다.

SELECT empno, ename,job,sal,
 (SELECT grade FROM salgrade WHERE e.sal BETWEEN losal AND hisal )  AS salgrade,
 deptno,
 (SELECT dname FROM dept WHERE E.DEPTNO = DEPT.DEPTNO ) AS DNAME
FROM emp e;

SELECT e.empno, e.ename,e.job,e.sal, s.grade AS salgrade,e.deptno, d.dname AS dname
FROM emp e 
JOIN dept d ON e.DEPTNO = d.DEPTNO 
JOIN salgrade s ON e.sal BETWEEN s.LOSAL AND s.HISAL;



 

--01. allen가 같은 직책 
SELECT e.job,e.empno,e.ename,e.sal,d.deptno,d.dname FROM emp e 
JOIN dept d ON e.deptno = d.deptno
WHERE job = (SELECT job FROM emp WHERE ename='ALLEN');

--02 . 평균 급여
SELECT e.empno,e.ename,d.dname,e.hiredate,d.loc,e.sal, s.grade FROM emp e
JOIN dept d ON e.DEPTNO = d.DEPTNO 
JOIN SALGRADE s ON e.SAL BETWEEN  s.losal AND s.HISAL
WHERE e.sal > (SELECT avg(sal) AS avg_sal FROM emp)
ORDER BY e.sal DESC , e.empno;

--03. 10번 부서에 근무하는 사원중 30번 부서에 없는 직책인 사원 정보 부서 정보를 출력
SELECT e.empno,e.ename,e.job,d.deptno,d.dname,d.loc FROM emp e
JOIN dept d ON e.DEPTNO = d.DEPTNO 
WHERE e.DEPTNO = 10 AND 
e.job NOT IN (SELECT DISTINCT job FROM emp WHERE DEPTNO = 30);

--04. 직책이 salesman사람의 최고 급여 보다 많이 받는 사원정보 급여정보 출력
SELECT max(sal) FROM emp WHERE job = 'SALESMAN';
SELECT e.empno,e.ename,e.sal,s.grade FROM emp e
JOIN SALGRADE s  ON e.sal BETWEEN s.LOSAL AND s.HISAL
WHERE e.sal > (SELECT max(sal) FROM emp WHERE job = 'SALESMAN');

SELECT max(sal) FROM emp WHERE job = 'SALESMAN';
SELECT e.empno,e.ename,e.sal,s.grade FROM emp e
JOIN SALGRADE s  ON e.sal BETWEEN s.LOSAL AND s.HISAL
WHERE e.sal > all (SELECT sal FROM emp WHERE job = 'SALESMAN');



--1. 부서번호 10의 최소 급여보다 큰 사원의 이름과 급여 부서명을 출력하시오.
SELECT ename,sal, deptno FROM emp 
WHERE sal > (SELECT min(sal) AS min_sal FROM emp WHERE deptno = 10);
SELECT min(sal) AS min_sal FROM emp WHERE deptno = 10;

--2. 자기 부서 평균 급여보다 높은 사원의 이름과 급여 부서번호를 출력하시오.
SELECT empno, ename,sal, deptno FROM emp e
WHERE sal > (SELECT avg(e2.sal) FROM emp e2 WHERE e2.DEPTNO = e.deptno);


SELECT avg(sal) AS avg_sal FROM emp ;

--3. NEW YORK에 근무하는 사원의 이름과 부서 번호를 출력하시오.
SELECT ename,deptno FROM emp
WHERE deptno = (SELECT deptno FROM dept WHERE loc = 'NEW YORK');

SELECT ename,deptno FROM emp
WHERE deptno IN (SELECT deptno FROM dept WHERE loc = 'NEW YORK');


--4. SALGRADE 3등급 사원의 이름과 급여 등급을 출력하시오.
SELECT ename,sal, (SELECT grade FROM SALGRADE s WHERE e.sal BETWEEN losal AND hisal) AS grade 
FROM emp e
WHERE (SELECT grade FROM SALGRADE s WHERE e.sal BETWEEN losal AND hisal) = 3;

-- join 쓴거
SELECT ename,sal, s.grade 
FROM emp e JOIN SALGRADE s ON e.sal BETWEEN s.LOSAL  AND s.HISAL 
WHERE s.grade = 3;

--5. 상사보다 급여가 높은 사원의 이름과 급여 매니저번호를 출력하시오.
SELECT e1.ename,e1.sal,e1.mgr FROM emp e1
WHERE e1.sal > (SELECT sal FROM emp e2 WHERE e2.empno = e1.mgr);


--6. 부서별 최고 급여 사원의 이름과 급여를 출력하시오.
SELECT deptno, ename, sal 
FROM EMP e 
WHERE (deptno, sal) IN (SELECT deptno,max(sal) FROM emp GROUP BY deptno);

--7. 급여 등급별 사원 수
--서브쿼리
SELECT grade, count(*) AS cnt
FROM (
		SELECT 
			(SELECT grade FROM salgrade s WHERE e.sal BETWEEN s.losal AND s.hisal) AS grade 
		FROM emp e
	 )
GROUP BY grade
ORDER BY grade;

--join써서
SELECT s.grade,count(*) AS cnt FROM emp e
JOIN SALGRADE s ON e.sal BETWEEN s.losal AND s.hisal
GROUP BY s.grade;

--8. 부서 30의 모든 사원보다 급여가 높은 사원
SELECT ename, sal FROM emp
WHERE sal > ALL(SELECT sal FROM emp WHERE deptno = 30);










