create database madang;
drop database if exists madangdb;
create database madangdb;
use madangdb;
create table book
(bookid int auto_increment not null primary key,
bookname char(25) not null,
publisher char(8) not null,
price int not null);
INSERT INTO book VALUES (null,'축구의 역사','굿스포츠',7000);
INSERT INTO book VALUES (null,'축구아는 여자','나무수',13000);
INSERT INTO book VALUES (null,'축구의 이혜','대한미디어',22000);
INSERT INTO book VALUES (null,'골프 바이블','대한미디어',35000);
INSERT INTO book VALUES (null,'피겨 교본','굿스포츠',8000);
INSERT INTO book VALUES (null,'역도 단계별기술','굿스포츠',6000);
INSERT INTO book VALUES (null,'야구의 추억','이상미디어',20000);
INSERT INTO book VALUES (null,'야구를 부탁해','이상미디어',13000);
INSERT INTO book VALUES (null,'올림픽 이야기','삼성당',7500);
INSERT INTO book VALUES (null,'Olympic Champions','Pearson',13000);

select * from book;

drop table if exists orders;

create table customer
(custid int auto_increment not null primary key,
name char(8) not null,
addr char(20) not null,
phone char(20));
INSERT INTO customer VALUES (null,'박지성','영국 맨체스터','000-5000-0001');
INSERT INTO customer VALUES (null,'김연아','대한민국 서울','000-6000-0001');
INSERT INTO customer VALUES (null,'장미란','대한민국 강원도','000-07000-0001');
INSERT INTO customer VALUES (null,'추신수','미국 클리블랜드','000-8000-0001');
INSERT INTO customer VALUES (null,'박세리','대한민국 대전',null);

select * from customer;



create table orders
(orderid int auto_increment primary key,
custid int ,
bookid int ,
saleprice int not null,
orderdate date not null,
foreign key (custid) references customer(custid),
foreign key (bookid) references book(bookid));
insert INTO orders VALUES (null,1,1,6000,'2014-07-01');
INSERT INTO orders VALUES (null,1,3,21000,'2014-07-03');
INSERT INTO orders VALUES (null,2,5,8000,'2014-07-03');
INSERT INTO orders VALUES (null,3,6,6000,'2017-07-04');
INSERT INTO orders VALUES (null,4,7,20000,'2014-07-05');
INSERT INTO orders VALUES (null,1,2,12000,'2014-07-07');
INSERT INTO orders VALUES (null,4,8,13000,'2014-07-07');
INSERT INTO orders VALUES (null,3,10,12000,'2014-07-08');
INSERT INTO orders VALUES (null,2,10,7000,'2014-07-09');
INSERT INTO orders VALUES (null,3,8,13000,'2014-07-10');


select * from orders;
