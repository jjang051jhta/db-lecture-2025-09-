-- 주석
-- 오라클 버전이 바뀌면 이름에 c## 붙여서 계정을 생성해야 한다.
-- 아래 명령어를 통해 그냥 일반 이름으로 계정을 생성하게 할 수 있다.
/*
ALTER SESSION SET "_oracle_script" = true;
DROP USER scott;  -- 계정 삭제
CREATE USER scott IDENTIFIED BY tiger 
DEFAULT TABLESPACE users quota unlimited ON users;
GRANT CREATE SESSION, CREATE TABLE TO scott;
*/
DROP USER scott cascade;
ALTER SESSION SET "_oracle_script" = true; -- 
CREATE USER scott02 IDENTIFIED BY tiger 
DEFAULT TABLESPACE users quota unlimited ON users;
GRANT CREATE SESSION, CREATE TABLE TO scott02;



DROP USER jjang051 cascade;
ALTER SESSION SET "_oracle_script" = true; -- 
CREATE USER jjang051 IDENTIFIED BY 1234 
DEFAULT TABLESPACE users quota unlimited ON users;
GRANT CREATE SESSION, CREATE TABLE TO jjang051;
ALTER USER jjang051 quota unlimited ON users;

GRANT CREATE ANY TABLE TO jjang051;



ALTER SESSION SET "_oracle_script" = true;
CREATE USER orclstudy IDENTIFIED BY 1234;
--DEFAULT TABLESPACE users quota ON users;

--session은 사용자가 db에 연결되면 session이 하나 생성됨...
GRANT CREATE SESSION TO orclstudy;
SELECT * FROM all_users WHERE username = 'orclstudy';
ALTER USER orclstudy IDENTIFIED BY 5678;
DROP USER orclstudy cascade;
GRANT RESOURCE, CONNECT , CREATE SESSION , 
CREATE TABLE   TO orclstudy;
GRANT unlimited tablespace TO orclstudy;

--권한 뺏기
REVOKE RESOURCE, CREATE TABLE FROM orclstudy;

--connect (alter session, create session)

--connect는 role이다 create session, create sequence, create table
CREATE USER orclstudy03 IDENTIFIED BY 1234;
CREATE ROLE my_role;
GRANT 
	CREATE SESSION, 
	CREATE TABLE,
	CREATE SEQUENCE,
	CREATE VIEW,
	CREATE synonym 
TO my_role;
--역할을 부여받았다. my_role이 가지고 있는 
GRANT my_role TO orclstudy03;

ALTER USER orclstudy03 DEFAULT TABLESPACE users;
ALTER USER orclstudy03  quota 500m ON users;


-- 오라클 전반적으로 복습





