drop database if exists cookdb;
create database cookdb;
use cookdb;
create table usertbl(
userid char(8) not null primary key,
username varchar(10) not null,
birthyear int not null,
addr char(2) not null,
mobile1 char(3),
mobile2 char(8),
height smallint,
mdate date
);
create table buytbl(
num int auto_increment not null primary key,
userid char(8) not null,
prodname char(6) not null,
groupname char(4),
price int not null,
amount smallint not null
);

alter table buytbl 
add constraint FK_usertbl_buytbl foreign key(userid) references usertbl(userid)
on update cascade on delete cascade;		-- foreign key 설정하기

alter table buytbl
drop constraint fk_usertbl_buytbl;			-- foreign key 지우기			

alter table buytbl
drop index fk_usertbl_buytbl;				-- foreign key 인덱스 지우기

alter table buytbl
change column num num int auto_increment;

alter table buytbl
drop primary key;

alter table buytbl
add primary key(num);

delete from usertbl where userid='KHD';

update usertbl set userid='BSH' where userid = 'PSH';
select * from buytbl;



