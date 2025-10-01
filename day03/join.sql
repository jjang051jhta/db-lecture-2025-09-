--  join  테이블 합쳐서 옆으로 확장하기..... 오라클 조인 ansi 조인
SELECT * FROM emp;  
SELECT * FROM dept;

SELECT * FROM emp,dept; --모든 경우의 수를 다 출력
-- 카테시안 곱, 데카르트 곱
--emp 14 * dept 4 = 56

--join의 종류 
-- 1. 등가조인(equi join, inner join)  두개의 공통 컬럽값이 있는 행만 반환하는 join
-- 2. 비등가조인(non-equi join)

--중복컬럼을 쓸때는 누구의 것인지를 확인해야 한다.
--as 는 컬럼에 쓴다. 테이블의 별칭은 한칸 띄워쓰면 된다.
SELECT empno, ename, job, d.deptno 
FROM emp e,dept  d
WHERE e.deptno = d.deptno
ORDER BY d.deptno;

-- 2. 비등가조인(non-equi join)  특정범위내의 검색
SELECT * FROM salgrade;
SELECT * FROM emp;
select * FROM emp e,salgrade s
WHERE e.sal BETWEEN s.losal AND s.hisal;

--3. self조인 자기케이블을 한번 더쓰기...
SELECT e1.empno, e1.ename, e1.mgr,e2.empno AS mgr_empno, e2.ename AS mgr_ename
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno;


--4. 조건에 맞지 않더라도 출력해야 되는 경우 외부조인 outer join
SELECT e1.empno, e1.ename, e1.mgr,
       e2.empno AS mgr_empno, e2.ename AS mgr_ename
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno(+); --LEFT OUTER JOIN  왼쪽의 테이블의 내용을 전부 출력

SELECT e1.empno, e1.ename, e1.mgr,
       e2.empno AS mgr_empno, e2.ename AS mgr_ename
FROM emp e1, emp e2
WHERE e1.mgr(+) = e2.empno; --RIGHT OUTER JOIN  오른쪽의 테이블의 내용을 전부 출력

SELECT * FROM emp;

--ansi join 표준조인

--1. natural join  겹치는 컬럼명은 별칭을 붙이지 않는다.
SELECT e.empno, e.ename, deptno, d.loc, d.dname
FROM emp e NATURAL JOIN dept d;

--만약 join만 쓴다면 using keyword를 사용해야 한다.
SELECT e.empno, e.ename, deptno, d.loc, d.dname
FROM emp e JOIN dept d USING(deptno);

-- 가장 많이 쓰는 방법 보통 inner를 쓰지않고 쓴다. 그러면 inner join이 된다. 
SELECT e.empno, e.ename, e.deptno, d.loc, d.dname
FROM emp e INNER JOIN dept d ON (e.deptno = d.deptno);

--  외부 조인 left outer join
SELECT e1.empno, e1.ename, e1.mgr,
       e2.empno AS mgr_empno, e2.ename AS mgr_ename
FROM emp e1 LEFT OUTER JOIN emp e2 ON (e1.mgr = E2.empno);

SELECT e1.empno, e1.ename, e1.mgr,
       e2.empno AS mgr_empno, e2.ename AS mgr_ename
FROM emp e1 RIGHT OUTER JOIN emp e2 ON (e1.mgr = E2.empno);

SELECT e1.empno, e1.ename, e1.mgr,
       e2.empno AS mgr_empno, e2.ename AS mgr_ename
FROM emp e1 FULL OUTER JOIN emp e2 ON (e1.mgr = E2.empno);


--01 급여가 2000을 초과한 사원의 부서정보
--01-오라클 조인
SELECT d.deptno,d.dname,e.empno,e.ename,e.sal 
FROM emp e, dept d
WHERE e.deptno = d.deptno  AND e.sal > 2000;
--01-ansi 조인
SELECT deptno,d.dname,e.empno,e.ename,e.sal 
FROM emp e NATURAL join dept d
WHERE e.sal > 2000;

SELECT d.deptno,d.dname,e.empno,e.ename,e.sal 
FROM emp e JOIN dept d ON e.deptno = d.deptno
WHERE e.sal > 2000;

--02 부서별 평균 급여,촤대급여, 최소급여, 사원수 출력
SELECT d.deptno,d.dname,
       avg(sal) AS avg_sal, 
       max(sal) AS max_sal, 
       min(sal) AS min_sal, 
       count(*) AS cnt
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY d.deptno, d.dname;

--02 ansi using사용
SELECT deptno,d.dname,
       avg(sal) AS avg_sal, 
       max(sal) AS max_sal, 
       min(sal) AS min_sal, 
       count(*) AS cnt
FROM emp e JOIN dept d using(deptno)
GROUP BY deptno, d.dname;

SELECT d.deptno,d.dname,
       avg(sal) AS avg_sal, 
       max(sal) AS max_sal, 
       min(sal) AS min_sal, 
       count(*) AS cnt
FROM emp e JOIN dept d ON (d.deptno = e.deptno)
GROUP BY d.deptno, d.dname;


--03. 모든 부서 정보와 사원정보 부서번호,사원이름순으로 출력
SELECT d.deptno, d.dname,e.empno, e.ename, e.sal
FROM emp e, dept d
WHERE e.deptno(+) = d.deptno
ORDER BY deptno, d.dname;

--03 ansi
SELECT d.deptno, d.dname,e.empno, e.ename, e.sal
FROM dept d LEFT OUTER JOIN  emp e ON (e.deptno = d.deptno)
ORDER BY deptno, d.dname;

--싹다 조회  카타시안 곱, 데카르트 곱
SELECT d.deptno, d.dname,e.empno, e.ename, e.sal
FROM dept d CROSS JOIN  emp e
ORDER BY deptno, d.dname;

--04. 
--04 오라클
SELECT d.deptno,
       d.dname, 
       e1.empno,
       e1.ename,
       e1.mgr, 
       e1.sal,
       d.deptno AS dept_1, 
       s.losal, 
       s.hisal,
       s.grade, 
       e1.empno AS mgr_empno,
       e1.ename AS mgr_ename
FROM emp e1, dept d, salgrade s, emp e2
WHERE e1.deptno(+) = d.deptno 
AND e1.sal BETWEEN s.losal(+) AND s.hisal(+)
AND e1.mgr = e2.empno(+);


--ansi
SELECT d.deptno,
       d.dname, 
       e1.empno,
       e1.ename,
       e1.mgr, 
       e1.sal,
       d.deptno AS dept_1, 
       s.losal, 
       s.hisal,
       s.grade, 
       e1.empno AS mgr_empno,
       e1.ename AS mgr_ename
FROM   dept d LEFT OUTER JOIN emp e1 
	            ON (e1.deptno = d.deptno)  --조건을 만족하지 않는 operation을 출력
            LEFT OUTER JOIN salgrade s
            	ON (e1.sal BETWEEN s.losal AND s.hisal)
            LEFT OUTER JOIN emp e2
               	ON (e1.mgr = e2.empno)
ORDER BY d.deptno, e1.empno;




---------------------------------------------------------
--01 모든 사원의 이름(ENAME)과 부서번호(DEPTNO), 부서명(DNAME)을 출력하세요.
SELECT 
	e.ename,d.deptno,d.dname
FROM emp e JOIN dept d ON e.deptno = d.deptno;

--02 사원 이름(ENAME)과 상사의 이름(MGR_ENAME)을 출력하세요.
SELECT e1.ename AS emp_name,e2.ename AS mgr_name
FROM emp e1 JOIN emp e2 ON (e1.mgr = e2.empno);

--03 모든 사원(ENAME)과 그 사원이 속한 부서명(DNAME), 부서위치(LOC)를 출력하세요.
SELECT 
	e.ename,d.dname, d.loc
FROM emp e JOIN dept d ON e.deptno = d.deptno;


--04 부서에는 존재하지만, 해당 부서에 소속된 사원이 없는 경우도 포함하여 부서명 + 사원명을 출력하세요.
SELECT 
	e.ename, d.dname
FROM emp e RIGHT OUTER JOIN dept d ON e.deptno = d.deptno;

--05 모든 사원의 이름(ENAME), 급여(SAL), 급여등급(GRADE)을 출력하세요.
SELECT 
	e.ename, e.sal , s.grade
FROM emp e JOIN salgrade s on e.sal BETWEEN s.losal AND s.hisal;

--06 부서별 평균 급여를 구하고, 부서명(DNAME)과 함께 출력하세요.
SELECT d.DNAME , trunc(avg(e.sal),2) AS avg_sal
FROM emp e JOIN dept d ON e.deptno = d.deptno
GROUP BY d.dname;

--07 사원 이름(ENAME), 부서명(DNAME), 상사 이름(MGR_NAME)을 한 번에 출력하세요.
SELECT e1.ename,d.dname,e2.ename AS mgr_name
FROM emp e1 JOIN dept d ON e1.deptno = d.deptno
LEFT OUTER JOIN emp e2 ON e1.mgr = e2.empno;

--08 사원이 없는 부서를 출력하세요.
SELECT d.deptno, d.dname, e.empno FROM 
dept d LEFT OUTER JOIN  emp e ON d.deptno = e.deptno
WHERE e.empno IS NULL;

--09 부서별 최고 급여를 받는 사원의 이름, 급여, 부서명을 출력하세요.
SELECT e.ename,e.sal,d.dname 
FROM emp e JOIN dept d ON e.deptno = d.deptno
WHERE e.sal = (SELECT max(sal) FROM emp WHERE deptno = e.DEPTNO);

--10. 모든 사원과 모든 부서를 카테시안 곱(CROSS JOIN)으로 출력하세요.
SELECT e.ename, d.dname FROM emp e CROSS JOIN dept d;











SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO
   WHERE E.DEPTNO = 20
   AND E.SAL > (SELECT AVG(SAL)
                  FROM EMP);
SELECT * FROM emp WHERE EXISTS (SELECT * FROM dept WHERE deptno = 10);























