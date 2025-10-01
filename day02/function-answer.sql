--1.사원 이름(ENAME)을 모두 대문자로 출력하세요.
SELECT ename,lower(ename), initcap(ename) FROM emp;
--2.사원 이름(ENAME)을 모두 소문자로 출력하세요.  
SELECT ename,lower(ename), initcap(ename) FROM emp;
--3.사원 이름(ENAME)을 첫 글자만 대문자로 출력하세요.
SELECT ename,lower(ename), initcap(ename) FROM emp;
--4. 사원 이름의 앞 두 글자만 추출해서 출력하세요.
SELECT substr(ename,1,2) FROM emp;
--5. 사원 이름의 끝에서 두 글자만 추출해서 출력하세요.
SELECT substr(ename,-2) FROM emp;
--6. 사원 이름 중에서 'A' 문자가 포함된 사원을 출력하세요.
SELECT ename FROM emp WHERE ename LIKE '%A%';
SELECT ename FROM emp WHERE instr(ename,'A') > 0;
--7. 사원 이름에서 'A'를 모두 '*' 로 바꿔 출력하세요.
SELECT ename, replace(ename,'A','*') FROM emp;
--8. 사원 번호(EMPNO)를 6자리로 만들고, 앞쪽을 0으로 채워 출력하세요.
SELECT empno, lpad(empno,6,0) AS empno_lpad FROM emp;
--9. 사원 이름 오른쪽에 #을 붙여서 총 10자리 문자열로 출력하세요.
SELECT empno,ename, rpad(ename,10,'#') AS empname_rpad FROM emp;
--10. 사원 이름(ENAME)을 모두 소문자로 변환한 뒤, 
--이름 길이가 5글자 이상인 사원만 출력하세요.
SELECT ename, lower(ename) AS ename_lower FROM emp 
WHERE length(ename) >= 5 ;
--11. 사원 이름의 두 번째 글자가 'A'인 사원만 출력하세요.
SELECT ename FROM emp WHERE ename like '_A%';
--12. 사원 이름에 'E' 문자가 몇 번째 위치에 있는지 출력하세요. (없는 경우는 0)
SELECT ename, instr(ename,'E') FROM emp; 
--13. 사원 이름의 마지막 글자가 'N'으로 끝나는 사원만 출력하세요.
SELECT ename FROM emp WHERE ename LIKE '%N';
--14. 사원 이름을 10자리 문자열로 만들고, 
--남는 부분은 모두 *로 채워서 출력하세요. (왼쪽 정렬 유지)
SELECT ename, rpad(ENAME,10,'*') e FROM emp;
--15. 사원 이름에서 'A' 또는 'E'를 모두 '-'로 치환하여 출력하세요.
SELECT ename, REPLACE(replace(ename,'A','-'),'E','-') AS replace_ename  
FROM emp;
--버전이 12c 이상일때만
SELECT ename, translate(ename,'AE','--') AS translate_ename  
FROM emp;
--16. 사원 번호(EMPNO)의 뒷자리 2자리를 제외한 부분은 
--#으로 마스킹해서 출력하세요.  (예: '7369' → ##69)
SELECT ename,empno,lpad(substr(to_char(empno),-2),
                        LENGTH(to_char(empno)),'#') AS masking_empno FROM emp;

--17. 이름을 거꾸로 뒤집은 문자열과 함께 출력
SELECT ename,reverse(ename) AS reverse_ename FROM emp;
--18. 사원 이름에서 모음(A, E, I, O, U)을 모두 제거하고 출력하세요.
SELECT ename, regexp_replace(ename,'A|E|I|O|U','*') AS regexp_replace_name FROM emp;
SELECT ename, regexp_replace(ename,'[AEIOU]','*') AS regexp_replace_name FROM emp;


--regular expression  정규표현식
SELECT 
	regexp_replace('oracle database','oracle') AS regexp01 ,
	regexp_replace('oracle database','database') AS regexp02 ,
	regexp_replace('oracle database','sql') AS regexp03
FROM dual;

SELECT 
	regexp_replace('oracle database','oracle','mysql') AS regexp01 ,
	regexp_replace('oracle database','database','db') AS regexp02 ,
	regexp_replace('oracle database','sql','sssqqqlll') AS regexp03
FROM dual;

SELECT 
	regexp_replace('orAcle database','a','*',1,0,'i') AS regexp01
FROM dual;

--SELECT 
	--regexp_replace('oracle database','a','*',시작 지점 1, 몇번째 바꿀꺼 1) AS regexp01
	-- 몇번째 바꿀꺼 0을 쓰면 싹 다 찾아서 바꿔라
--FROM dual;
--regexp_replace('문자열','정규표현식','치환문자열',검색시작위치,매칭순번,일치옵션);

SELECT 
	regexp_replace('Oracle Database 21c','Oracle','******') AS regexp01
FROM dual;

--숫자를 찾아서 바꿔라
SELECT 
	regexp_replace('Oracle Database 23c','[0-9]','*') AS regexp01
FROM dual;
SELECT 
	regexp_replace('Oracle Database 23c','[[:digit:]]','*') AS regexp01
FROM dual;
SELECT 
	regexp_replace('Oracle Database 23c','\d','*') AS regexp01
FROM dual;

--영어를 찾아서 바꾸고 싶다.
SELECT 
	regexp_replace('Oracle Database 23c','[a-zA-Z]','*') AS regexp01
FROM dual;
SELECT 
	regexp_replace('Oracle Database 23c','[[:alpha:]]','*') AS regexp01
FROM dual;

-- or 찾기
SELECT 
	regexp_replace('Oracle Database 23c','Ora|base|23','***') AS regexp01
FROM dual;

SELECT 
	regexp_replace('오라클, "Oracle Database 23c" 버전','[가-힣]|[,"]') AS regexp01
FROM dual;
SELECT 
	regexp_replace('오라클, "Oracle Database 23c" 버전','[가-힣]|[[:punct:]]') AS regexp01
FROM dual;

SELECT 
	regexp_replace('오라클, "Oracle Database 23c" 버전','[^a-zA-Z0-9]') AS regexp01
FROM dual;

SELECT 
	regexp_replace('Oracle  Database  23c',' ') AS regexp01,
	regexp_replace('Oracle  Database  23c','( ){2,}',' ') AS regexp02,
	regexp_replace('Oracle  Database  23c','\s{2,}',' ') AS regexp03
FROM dual;

--19.사원 이름과 직업(JOB)을 연결하여 "ENAME (JOB)" 형태로 출력하세요. (예: SMITH (CLERK))
SELECT ename,job, ename||'('||job||')' AS result01,
concat(concat(concat(ename,'('),job),')') AS result02 FROM emp;




















