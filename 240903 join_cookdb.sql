use cookdb;
create table testtbl2
(id int auto_increment primary key,
username char(3),
age int);
insert into testtbl2 values (null,'에디',15);
insert into testtbl2 values (null,'포비',12);
insert into testtbl2 values (null,'통통이',11);
select * from testtbl2;

alter table testtbl2 auto_increment=100;
insert into testtbl2 values (null,'패티',13);
select * from testtbl2;

create table testtbl4 (id int, fname varchar(50), lname varchar(50));
insert into testtbl4
select emp_no, first_name, last_name from employees.employees;
select * from testtbl4; -- limit 100;

drop table if exists testtbl5;

create table testtbl5
(select emp_no as id, first_name as fname, last_name as lname from employees.employees);
select * from testtbl5 limit 3;

update testtbl5
set lname='없음'
where fname='kyoichi';
select * from testtbl5 where fname='kyoichi';

update buytbl
set price=price*1.5;
select * from buytbl;

select * from testtbl5 where fname='aamer' order by id;
delete from testtbl5 where fname='Aamer' limit 5;

create table bigtbl1 (select * from employees.employees);
create table bigtbl2 (select * from employees.employees);
create table bigtbl3 (select * from employees.employees);

delete from bigtbl1;
drop table bigtbl2;
truncate table bigtbl3;

select *
from buytbl
inner join usertbl
on buytbl.userid = usertbl.userid
where buytbl.userid = 'KHD';

select B.userid, U.username, B.prodname, U.addr, concat(U.mobile1, U.mobile2) as '연락처'
from buytbl B
inner join usertbl U
on B.userid=U.userid where addr in ('서울','경북');

select U.userid, U.username, B.prodname, U.addr, concat(U.mobile1, U.mobile2) as '연락처'
from usertbl U
inner join buytbl B
on U.userid=B.userid
order by U.userid;

select distinct U.userid, U.username, U.addr
from usertbl U
inner join buytbl B
on U.userid=B.userid
order by U.userid;

CREATE TABLE stdTBL
( stdName VARCHAR(10) NOT NULL PRIMARY KEY, 
addr CHAR(4) NOT NULL
);
CREATE TABLE clubTBL
( clubName VARCHAR(10) NOT NULL PRIMARY KEY, 
roomNo CHAR(4) NOT NULL
);
CREATE TABLE stdclubTBL
( num int AUTO_INCREMENT NOT NULL PRIMARY KEY, 
stdName VARCHAR(10) NOT NULL, 
clubName VARCHAR(10) NOT NULL, 
FOREIGN KEY(stdName) REFERENCES stdTBL(stdName), 
FOREIGN KEY(clubName) REFERENCES clubTBL(clubName)
);
INSERT INTO stdTBL VALUES ('강호동', '경북'), ('김제동', '경남'), ('김용만', '서울'), 
('이휘재', '경기'), ('박수홍', '서울');
INSERT INTO clubTBL VALUES ('수영', '101호'), ('바둑', '102호'), ('축구', '103호'), 
('봉사', '104호');
INSERT INTO stdclubTBL VALUES (NULL, '강호동', '바둑'), (NULL, '강호동', '축구'), 
(NULL, '김용만', '축구'), (NULL, '이휘재', '축구'), (NULL, '이휘재', '봉사'), 
(NULL, '박수홍', '봉사');
select * from stdclubtbl;

SELECT C.clubName, C.roomNo, S.stdName, S.addr 
FROM stdTBL S 
INNER JOIN stdclubTBL SC
ON S.stdName = SC.stdName
INNER JOIN clubTBL C
ON SC.clubName = C.clubName
ORDER BY S.stdName;


use madangdb;
-- 고객과 고객의 주문에 관한 데이터를 모두 조회
select C.custid, C.name, C.addr, C.phone, O.bookid, O.saleprice,
O.orderdate
from customer C
inner join orders O
on C.custid = O.custid;
-- 박지성의 고객아이디와 이름, 주소, 구매액, 구매날짜를 조회
select C.custid, C.name, C.addr, O.saleprice, O.orderdate
from customer C
inner join orders O
on C.custid = O.custid
where C.name='박지성';
-- 고객별로 이름과 주소와 총 구매액을 조회
select distinct C.name, C.addr, sum(O.saleprice) as 총구매액
from customer C
inner join orders O
on C.custid = O.custid
group by C.custid;
-- 가격이 20,000원이상인 도서를 주문한 고객의 이름과 도서의 이름 조회
select C.name, B.bookname, B.price
from customer C
inner join orders O
on C.custid = O.custid
inner join book B
on O.bookid = B.bookid
where B.price >=20000;
-- 정가보다 싸게 산 고객의 아이디, 이름, 구매가격을 조회
select C.custid, C.name, O.saleprice ,B.price
from customer C
inner join orders O
on C.custid = O.custid
inner join book B
on O.bookid = B.bookid
where B.price > O.saleprice;

-- cookdb
use cookdb;

-- KYM이라는 아이디를 가진 회원이 구매한 물건과 회원 정보 조회(아이디, 이름, 물품, 물품 가격, 주소, 연락처)
select U.userid, U.username, B.prodname, B.price,B.amount, U.addr, concat(U.mobile1, U.mobile2)
from usertbl U
inner join buytbl B
on U.userid = B.userid
where U.userid='KYM';
-- 경북에 거주하는 유저들의 아이디, 이름, 구매물품, 구매액을 조회
select U.userid, U.username, B.prodname, B.price * B.amount as 구매액
from usertbl U
inner join buytbl B
on U.userid = B.userid
where U.addr='경북';
-- 경북에 거주하거나 물품 분류가 없는 물건을 구입한 유저들의 아이디, 이름, 구매물품, 주소를 조회
select U.userid, U.username, B.prodname, U.addr
from usertbl U
inner join buytbl B
on U.userid = B.userid
where U.addr='경북' or B.groupname is null;

select U.userID, U.userName, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
 from usertbl U 
 left outer join buytbl B 
 on U.userid=B.userid
 where b.prodname is null
 order by u.userid;
 
 select s.stdname, s.addr, c.clubname, c.roomno
 from stdtbl s 
 left outer join stdclubtbl sc 
 on s.stdname=sc.stdname
 left outer join clubtbl c 
 on sc.clubname=c.clubname;
 
 SELECT C.clubName, C.roomNo, S.stdName, S.addr
FROM stdTBL S 
LEFT OUTER JOIN stdclubTBL SC 
ON SC.stdName = S.stdName
RIGHT OUTER JOIN clubTBL C 
ON SC.clubName = C.clubName;

 select s.stdname, s.addr, c.clubname, c.roomno
 from stdtbl s 
 left outer join stdclubtbl sc 
 on s.stdname=sc.stdname
 left outer join clubtbl c 
 on sc.clubname=c.clubname
 union
 SELECT s.stdname, s.addr, c.clubname, c.roomno
FROM stdTBL S 
LEFT OUTER JOIN stdclubTBL SC 
ON SC.stdName = S.stdName
RIGHT OUTER JOIN clubTBL C 
ON SC.clubName = C.clubName;
