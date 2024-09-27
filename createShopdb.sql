drop database if exists shopdb;
create database shopdb;
use shopdb;
create table usertbl(
memberid char(8) not null primary key,
membername char(5) not null,
memberaddress char(20)
);
desc usertbl;

create table prducttbl(
productname char(4) not null primary key,
cost int not null,
makedate date,
company char(5),
amount int
);
desc prducttbl;

INSERT INTO usertbl VALUES ('Thomas','토마스','경기 부천시 중동');
INSERT INTO usertbl VALUES ('Edward','에드워드','서울 은평구 중산동');
INSERT INTO usertbl VALUES ('Henry','헨리','인천 남구 주안동');
INSERT INTO usertbl VALUES ('Gordon','고든','경기 성남시 분당구');

INSERT INTO prducttbl VALUES ('냉장고',10,'2019-07-01','삼성',17);
INSERT INTO prducttbl VALUES ('컴퓨터',20,'2020-03-01','LG',3);
INSERT INTO prducttbl VALUES ('모니터',5,'2021-09-01','롯데',22);

select * from usertbl;
select * from prducttbl;

use cookdb;

select userid, username, birthyear, height from usertbl where birthyear >=1970
and height >= 182;

select userid, username, birthyear, height from usertbl where height 
between 180 and 182;

select username, addr from usertbl where addr='경남' or addr='충남' or addr='경북';

select username, addr from usertbl where addr in ('경남','충남','경북');

select username, height from usertbl where username like '김%';

select username, height from usertbl where username like '_경규';

select username, mdate from usertbl order by mdate desc;

select username, height from usertbl order by height desc, username asc;

select username from usertbl order by username;

select addr from usertbl;

select distinct addr from usertbl order by addr;

use employees;

select emp_no, hire_date from employees order by hire_date asc limit 5,5 ;

select emp_no, hire_date from employees where hire_date='1985-01-01';

select * from employees limit 100;
-- 생년월일이 60년대인사람찾기 
select * from employees where gender='m' and hire_date >= '1990-01-01' 
order by hire_date asc, emp_no asc;

select * from employees where gender='m' and hire_date between'1990-01-01' and 
'2010-12-31 ' order by hire_date asc, emp_no asc;

desc employees;
-- 퍼스트네임이a로시작하 는사람 
select * from employees where first_name like 'a%' order by first_name;

use cookdb;

desc usertbl;
-- 서울에사는 사람중 유씨들의 레코드를 가져오자
select * from usertbl where addr='서울' and username like '유%';

select * from buytbl;

select * from buytbl where groupname is null;

select * from buytbl where groupname is not null;
-- 그룹이름이 의류이거나 프라이스가 50이상인 것들 나열
select * from buytbl where groupname='의류' or price >= 50;
-- 제품이 모니터 이거나 청바지 이거나 책인것
select * from buytbl where prodname in ('모니터','청바지','책') order by prodname;

use cookdb;

create table buytbl2 (select * from buytbl);
select * from buytbl2;

desc buytbl2;

use cookdb;

select userid, amount from buytbl order by userid;
select userid, price*amount as 구매액 from buytbl;
select userid, sum(price*amount) as `총 구매액` from buytbl group by userid;

select * from usertbl;
select * from buytbl;

select addr, avg(height) as 키평균  from usertbl group by addr;
select addr, avg(height) as 키평균 from usertbl where addr='서울';
select userid, sum(price*amount) as '총구매액' from buytbl group by userid
having 총구매액 > 1000 order by 총구매액 desc;


