--sys는 건드리는거 아니다.
--계정을 만들어서 사용해야 한다.
--1회용
ALTER SESSION SET "_oracle_script" = TRUE;
CREATE USER scott04 IDENTIFIED BY 1234;
GRANT CREATE SESSION TO scott04; --연결권한
GRANT CREATE TABLE TO scott04; --테이블 만드는 권한
ALTER USER scott04 quota 500m ON users;