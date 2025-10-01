--함수 오라클 내장 함수
--1. 문자열관련 함수
SELECT ename, 
upper(ename), 
lower(ename), 
initcap(ename)  
FROM emp;
--upper('SMith')  = upper('smith')

SELECT * FROM emp WHERE upper(ename) = upper('smith');
--quiz s, S로 시작하는 이름 다 찾아보기...
SELECT * FROM emp WHERE UPPER(ename) LIKE UPPER('s%');

--2. length  길이
SELECT ename, LENGTH(ename) FROM emp;
--이름이 다섯글자 이상인 사람
SELECT ename, length(ename) FROM emp
WHERE length(ename) >= 5;
--length은 우리가 알고 있는 문자열 길이
SELECT LENGTH('한글'), 
lengthb('한글') FROM dual;  -- dual 가상테이블

-- utf-8기준
-- 오라클에서 한글은 3byte로 취급한다. 영어는 1byte로 취급한다.
SELECT LENGTH('abc'), 
lengthb('abc') FROM dual;  -- dual 가상테이블


---조건절에는 alias를 쓸 수 없다.
-- where는 아직 연산이 마치지 않은 상태라서 alias를 쓸 수 없다.
SELECT ename, length(ename) AS namelength FROM emp
WHERE length(ename) >= 5
ORDER BY namelength;

--3. substr(값,시작 1부터,끝 (길이))
--   substr(값,시작 1부터,끝 (길이)) 음수는 뒤에서 부터 센다.
SELECT ename, 
substr(ENAME,1,3)||'**' , 
substr(ENAME,3) ,
substr(ENAME,-3,2)  
FROM emp;

--'oracle'에서 cl만 출력하기... 앞에서 자르기 뒤에서 자르기 둘다
SELECT 'oracle', 
substr('oracle',4,2),
substr('oracle',-3,2)
FROM dual;

-- 생년월일 뽑기
SELECT substr('910304-1234567',1,6) FROM dual;

-- 전화번호 마지막 네자리
SELECT substr('01011112222',-4) FROM dual;

--instr(문자열,찾을 문자열, [시작지점, 몇번째])
SELECT 
   instr('HELLO ORACLE!','L') AS instr01 , -- 첫번째 등장하는 L의 인덱스
   instr('HELLO ORACLE!','L',4) AS instr02, -- 시작지점을 4번부터해서 처음 등장하는 L의 인덱스
   instr('HELLO ORACLE!','L',4,2) AS instr03, --시작지점을 4번부터해서 두번째 등장하는 L의 인덱스
   instr('HELLO ORACLE!','L',-1) AS instr04, --뒤에서 첫번째 나오는 L의 인덱스
   instr('HELLO ORACLE!','OX') AS instr05 --없는 글자면 0을 리턴한다.
FROM dual;

--서버에서 database또는 DATABASE DatABaSe가 넘어올지 모를때 위치 맞기
SELECT instr(upper('Oracle DataBase 21c Release'),upper('DataBAse')) FROM dual;

--21c 버전인지 확인
--WITH 가상테이블 만들때 쓴다 1회용
--테스트할때 많이 쓴다.
WITH temp AS (
   SELECT 'Oracle DataBase 21c Release' AS alias FROM dual
)
SELECT * FROM temp 
WHERE instr(alias,'21c') > 0;

--이름중에 s가 포함되어 있으면 출력 LIKE쓰지 말고
SELECT * FROM emp WHERE ename LIKE '%S%';
SELECT * FROM emp WHERE instr(ename,'S') > 0;
--fjdksjfl.dsjfl.kdsfds.pdf  확장자 출력  subquery 를 사용해도 된다.
SELECT substr('fdsfds.pdf',
               instr('fdsfds.pdf','.',-1)+1,3) 
FROM dual;

SELECT substr(filename,
               instr(filename,'.',-1)+1,3) 
FROM (SELECT 'fdsfds.pdf' AS filename FROM dual); 
--쿼리안에 쿼리를 또 쓰는 걸 subquery라고 한다.
WITH filedata AS (
   SELECT 'fdsfds.pdf' AS filename FROM dual
) 
SELECT substr(filename, instr(filename,'.',-1)+1,3) FROM filedata;

