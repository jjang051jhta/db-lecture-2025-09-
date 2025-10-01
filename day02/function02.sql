--변환

--round(1234.5678,2) 2 소수 이하 자리수를 남기겠다.
--round(1234.5678,-2) 만약 음수이면 정수 부분을 가리킨다.
SELECT 
	round(1234.5678) AS round01 ,
	round(1234.5678,0) AS round02,
	round(1234.5678,1) AS round03,
	round(1234.5678,2) AS round04,
	round(1234.5678,-1) AS round05,
	round(1234.5678,-2) AS round06,
	round(1254.5678,-2) AS round07
FROM dual;

--trunc(1234.5678)는 버린다.
SELECT 
	trunc(1234.5678) AS round01 ,
	trunc(1234.5678,0) AS round02,
	trunc(1234.5678,1) AS round03,
	trunc(1234.5678,2) AS round04,
	trunc(1234.5678,-1) AS round05,
	trunc(1234.5678,-2) AS round06,
	trunc(1254.5678,-2) AS round07
FROM dual;

--ceil 은 올림함수, floor는 내림함수
SELECT 
	ceil(1234.1678) AS ceil01,
	floor(1234.9678) AS floor01,
	ceil(-1234.1678) AS ceil02,
	floor(-1234.9678) AS floor02
FROM dual;


SELECT 
	mod(15,6) AS mod01,
	mod(15,5) AS mod02
FROM dual;

--날짜관련
SELECT sysdate ,
       systimestamp,
       current_timestamp  --타임존이 다른 나라일때
FROM dual;
SELECT 
	sysdate  AS now,
	sysdate + 1  AS tommow,
	sysdate - 1  AS yesterday
FROM dual;


SELECT 
	sysdate  AS now,
	add_months(sysdate,3) AS month3after
FROM dual;

SELECT empno, ename,hiredate, 
add_months(HIREDATE ,120) AS work10year 
FROM emp;

--입사한지 45년 지난 사원 출력
SELECT empno, ename,hiredate, add_months(hiredate,42*12)
FROM emp
WHERE add_months(hiredate,40*12) < sysdate;

-- months_betwee 차이를 가리킨다. 
SELECT empno, ename,hiredate, 
	months_between(hiredate,sysdate) AS month01,
	months_between(sysdate,hiredate) AS month02,
	trunc(months_between(sysdate,hiredate)) AS month03
FROM emp;

--ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
ALTER SESSION SET NLS_DATE_LANGUAGE = 'AMERICAN';
SELECT next_day(sysdate,'월요일')  FROM dual;
SELECT next_day(sysdate,'MONDAY')  FROM dual;
SELECT last_day(sysdate)  FROM dual;


SELECT sysdate, 
	trunc(sysdate) AS "일단위 절사",
	trunc(sysdate,'MM') AS "월단위 절사",
	trunc(sysdate,'YYYY') AS "연단위 절사",
	trunc(sysdate,'Q') AS "연분기위 절사",
	trunc(sysdate,'HH') AS "시단위 절사",
	trunc(sysdate,'MI') AS "분단위 절사"
FROM dual;

SELECT sysdate, 
	round(sysdate) AS "일단위 반올림",
	round(sysdate,'MM') AS "월단위 반올림",
	round(sysdate,'YYYY') AS "연단위 반올림",
	round(sysdate,'Q') AS "연분기위 반올림",
	round(sysdate,'HH') AS "시단위 반올림",
	round(sysdate,'MI') AS "분단위 반올림"
FROM dual;



--형변환  type casting

--묵시적 형변환
SELECT empno,ename, empno+'500' FROM emp WHERE ename = 'SCOTT';
SELECT '1000'+empno,ename FROM emp WHERE ename = 'SCOTT';

--to_char,to_number,to_date
--to_char 날짜를 문자로 변환

SELECT sysdate, 
	to_char(sysdate,'YYYY/MM/DD HH:MI:SS') AS formatted_date01 ,
	to_char(sysdate,'YYYY/MM/DD HH24:MI:SS') AS formatted_date02,
	to_char(sysdate,'CC') AS formatted_date03, 
	to_char(sysdate,'MON') AS formatted_date04, 
	to_char(sysdate,'MONTH') AS formatted_date05, 
	to_char(sysdate,'DDD') AS formatted_date06, 
	to_char(sysdate,'DY') AS formatted_date07, 
	to_char(sysdate,'DAY','NLS_DATE_LANGUAGE = KOREAN') AS formatted_date08 ,
	to_char(sysdate,'W') AS formatted_date09
FROM dual;

--fm을 붙이면 공백 제거한다.
SELECT 
	to_char(12345.67) AS num01,
	to_char(12345.67,'99,999.99') AS num02,
	to_char(12345.67,'0000000.99') AS num03,
	to_char(12345.67,'9999999.99') AS num04,
	to_char(12345,'fm9,999,999') || '원' AS num05
FROM dual;

SELECT to_number('1,300','999,999') - to_number('1,500','999,999') FROM dual;


SELECT 
	to_date('2025-09-24','YYYY-MM-DD') AS to_date01,
	to_date('2025/09/24','YYYY/MM/DD') AS to_date02
from dual;


--hiredate
--1981-6-1일 이후에 입사한 출력
SELECT ename,HIREDATE  
FROM emp 
WHERE hiredate > to_date('1981-06-01','YYYY-MM-DD');
--null처리 함수  nvl, nvl2
SELECT sal + nvl(comm,0) FROM emp;
SELECT sal,comm,nvl2(comm ,'O','X') FROM emp;
--만약 있으면 300,500, 없으면 no commission
SELECT ename,comm,
	nvl2(comm, to_char(comm,'fm999,999,999.00'),'no commission') AS comm02 
FROM emp;


--연봉 출력  -- comm + sal*12, sal*12
SELECT ename,sal, nvl2(comm,'o','x') AS commission,
nvl2(comm,comm + sal*12,sal*12) AS annualsal FROM emp;

-- decode 오라클 전용  
-- case when then ansi
-- salesman 연본 10% 인상, manager 5% 인상 analyst 동결 나머지는 3% 인상
-- if문을 쓸 수 있다.
SELECT ename,job, sal,
	decode(job,
		'SALESMAN', sal*1.1,
		'MANAGER',  sal*1.05,
		'ANALYST',  sal,
		            sal*1.03
	) AS up_sal
FROM emp;

SELECT ename,job, sal,
	CASE job
		WHEN 'SALESMAN' THEN sal*1.1
		WHEN 'MANAGER'  THEN sal*1.05
		WHEN 'ANALYST'  THEN sal*1
		ELSE                 sal*1.03
	END AS up_sal
FROM emp;

SELECT ename,job, sal,
	CASE 
		WHEN job = 'SALESMAN' THEN sal*1.1
		WHEN job = 'MANAGER'  THEN sal*1.05
		WHEN job = 'ANALYST'  THEN sal*1
		ELSE                 sal*1.03
	END AS up_sal
FROM emp;

SELECT ename,job, sal,
	CASE 
		WHEN comm IS null THEN '해당사항 없음'
		WHEN comm = 0     THEN '수당 없음'
		ELSE                   concat('수당 : ',comm)
	END AS comm
FROM emp;


-- comm을 가지고 null이면 해당사항 없음, 0이면 수당 없음 있으면 수당 : 3000
--6-1
SELECT empno,rpad(substr(empno,1,2),4,'*') AS masking_empno,
	   ename,rpad(substr(ename,1,1),LENGTH(ename),'*') AS  masking_ename 
FROM emp
WHERE length(ename) >= 5;

--6-2
--trunc는 오라클 전용 
SELECT empno,ename,sal,
       trunc(sal/21.5,2) AS day_pay,
       round(sal/21.5/8,1) AS time_pay
FROM emp;

--6-2-1
SELECT empno,ename,sal,
       floor(sal/21.5*100)/100 AS day_pay,
       round(sal/21.5/8,1) AS time_pay
FROM emp;


--6-3
SELECT empno,ename,hiredate,
	   add_months(hiredate,3) AS r_job ,
	   to_char(next_day(add_months(hiredate,3),'MONDAY'),'YYYY-MM-DD') AS r_job , 
	   nvl2(comm,to_char(comm),'N/A') AS comm
FROM emp;


--6-4
SELECT 
empno,ename,mgr,
	CASE 
		WHEN mgr is NULL THEN '0000'
		WHEN substr(mgr,1,2) = '75' THEN '5555'
		WHEN substr(mgr,1,2) = '76' THEN '6666'
		WHEN substr(mgr,1,2) = '77' THEN '7777'
		WHEN substr(mgr,1,2) = '78' THEN '8888'
		ELSE to_char(mgr)
	END AS chg_mgr
FROM emp;


-- 다중행 함수
-- 여러줄을 합산하여 조회
SELECT deptno,
trunc(avg(sal)) AS AVG_SAL,
max(sal) AS max_sal,
min(sal) AS min_sal,
count(*) AS count,
sum(sal) AS sum_sal
FROM emp
GROUP BY deptno
ORDER BY deptno;

--2 그룹함수는 조건을 Having으로 처리 한다. where 절에서는 그룹함수의 조건은 처리 안됨
SELECT job, count(*) AS num 
FROM emp
GROUP BY job
HAVING count(*) >= 3
order BY num;

--3 각연도별로 몇명이 입사했는지 출력
SELECT to_char(hiredate,'YYYY') AS hire_year, deptno, count(*) AS cnt 
FROM emp
GROUP BY deptno, to_char(hiredate,'YYYY')
ORDER BY hire_year;

--4. 커미션받는 사람 안받는 사람...
SELECT nvl2(comm,'O','X') AS comm ,
	   count(*) AS cnt
FROM emp
GROUP BY nvl2(comm,'O','X');












































