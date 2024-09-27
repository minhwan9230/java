drop database if exists ibrary;
create database ibrary;
use ibrary;

drop table if exists book;
create table book(
id varchar(30) primary key,
title varchar(50) not null,
category_id bigint not null,
writer varchar(20),
publisher varchar(20),
description varchar(150),
isrent bit(1)
);
insert into book values ('9791138378147','파이썬 프로그래밍',1,'박영권','시대인','파이썬 핵심 문법과 다양한 실전 프로그래밍을 경험',0);
insert into book values ('9791163036012','Do it! 깡샘의 안드로이드 앱 프로그래밍 with 코틀린',1,'강성윤','이지스퍼블리싱','안드로이드 14(업사이드다운케이크)를 기준으로 달라진 안드로이드 개발 과정',0);
insert into book values ('9791169210911','혼자 공부하는 C 언어',1,'서현우','한빛미디어','1:1 과외하듯 배우는 C 프로그래밍 자습서',0);
insert into book values ('9791192932163','DB설계 입문자를 위한 데이터베이스 설계 및 구축',2,'오세종','생능출판','데이터베이스 설계에 대한 기본적인 지식을 전달',0);
insert into book values ('9791156640127','MySQL로 배우는 데이터베이스 개론과 실습',2,'박우창','한빛아카데미','기초 이론부터 워크북 실습까지 한 권으로 배우는 데이터베이스',0);
insert into book values ('9791161757926','개발자를 위한 레디스',2,'김가림','에이콘출판사','효율적인 개발을 위한 인메모리 데이터베이스 사용 가이드 (오픈소스 프로그래밍)',0);
insert into book values ('9791156645429','쉽게 배우는 소프트웨어 공학',3,'김치수','한빛아카데미','소설처럼 술술 익히는 소프트웨어 공학',0);
insert into book values ('9788970508290','이해하기 쉬운 소프트웨어 공학 에센셜',3,'윤청','생능출판','소프트웨어의 성공적인 개발과 관리 방법을 체계적으로 구성',0);
insert into book values ('9788935305223','새로쓴 소프트웨어 공학',3,'최은만','정익사','소프트웨어 공학의 기초적이고 전반적인 내용을 학습할 수 있도록 구성',0);
insert into book values ('9791165219468','코딩 자율학습 HTML + CSS + 자바스크립트',4,'김기수','길벗','기초부터 반응형 웹까지 초보자를 위한 웹 개발 입문서 (코딩 자율학습)',0);
insert into book values ('9791169212649','처음 시작하는 FastAPI',4,'Bill Lubanovic','한빛미디어','모던 파이썬 개념부터 실전 프로젝트까지, 따라 하며 배우는 웹 백엔드 개발',0);
insert into book values ('9788966263745','프론트엔드 성능 최적화 가이드',4,'유동균','인사이트','웹 개발 스킬을 한 단계 높여 주는 (프로그래밍인사이트)',0);
insert into book values ('9791158394592','문제풀이로 완성하는 알고리즘+자료구조',5,'Yoneda Masataka','위키북스','프로그래밍 경진대회 & 코딩 테스트 대비를 위한 77가지 핵심 기법',0);
insert into book values ('9788970504896','알기 쉬운 알고리즘',5,'양성봉','생능출판','step-by-step으로 알고리즘 완전 이해',0);
insert into book values ('9791156005032','알고리즘 기초',5,'Richard Neapolitan','홍릉','알고리즘의 기초적이고 전반적인 내용을 학습할 수 있도록 구성',0);

drop table if exists category;
create table category(
id int auto_increment primary key,
name varchar(10) not null
);
insert into category values(null,'프로그래밍');
insert into category values(null,'데이터베이스');
insert into category values(null,'소프트웨어공학');
insert into category values(null,'웹개발');
insert into category values(null,'알고리즘');

alter table book
modify column category_id int not null;

alter table book
add constraint FK_category_book foreign key(category_id) references category(id);



select * from book order by category_id;
select * from category;
-- 카테고리별 책리스트 조회
SELECT 
    c.name as 카테고리, b.title as 타이틀, b.writer as 지은이, b.publisher as 출판사
FROM book b
JOIN category c
ON b.category_id = c.id
where c.name like '%프로%';
select * from book;
-- 도서검색
select
	b.title, b.writer, b.publisher, c.name,
    case
    when b.isrent =0 then '대여 가능'
    when b.isrent =1 then '대여 불가능'
    end as '대여 여부'
from book b
join category c
on b.category_id=c.id
where b.title like '%쉬운%' or b.writer like '%%' or b.publisher like '%%'
		or c.name like '%%';
		
    