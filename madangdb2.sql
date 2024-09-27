create database madang;
drop database if exists madang;
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
select * from orders;

select count(*) from orders order by bookid;

alter table orders 
add column b_amount int DEFAULT 1;

select * from book;
alter table book 
add column b_amount int DEFAULT 100;

select * from customer;

alter table customer
add grade varchar(25) default 'bronze';

drop table if exists c_grade; 

create table c_grade
(num int auto_increment primary key ,
custid varchar(10) not null,
cdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
pregrade varchar(25),
newgrade varchar(25));

select * from c_grade;



DROP PROCEDURE IF EXISTS gradeproc;
DELIMITER $$

CREATE PROCEDURE gradeproc()
BEGIN
    UPDATE customer c
    JOIN (
        SELECT o.custid, SUM(o.saleprice) AS 총구매액
        FROM orders o
        GROUP BY o.custid
    ) AS o
    ON c.custid = o.custid
    SET c.grade = CASE
        WHEN o.총구매액 >= 30000 THEN 'vip'
        WHEN o.총구매액 >= 20000 THEN 'gold'
        WHEN o.총구매액 >= 10000 THEN 'silver'
        ELSE 'bronze'
    END;
END $$
		
    CALL gradeproc();
    
    select * from customer;
    
DROP TRIGGER IF EXISTS c_grade_updatetrg;
DELIMITER $$

CREATE TRIGGER c_grade_updatetrg
AFTER UPDATE
ON customer
FOR EACH ROW
BEGIN
    IF OLD.grade != NEW.grade THEN 
        INSERT INTO c_grade (custid, cdate, pregrade, newgrade)
        VALUES (OLD.custid, CURRENT_TIMESTAMP, OLD.grade, NEW.grade);
    END IF;
END $$

DELIMITER ;

DROP TRIGGER IF EXISTS c_grade_deletetrg;
DELIMITER $$

CREATE TRIGGER c_grade_deletetrg
AFTER DELETE
ON customer
FOR EACH ROW
BEGIN
    INSERT INTO c_grade (custid, cdate, pregrade, newgrade)
    VALUES (OLD.custid, CURRENT_TIMESTAMP, OLD.grade, NULL);
END $$

DELIMITER ;

select * from c_grade;
select * from customer;

update customer set grade ='silver' where name = '김연아';

DROP TRIGGER IF EXISTS reducetrigger;
DELIMITER $$

CREATE TRIGGER reducetrigger
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE book
    SET b_amount = b_amount - 1
    WHERE bookid = NEW.bookid;
END $$

DELIMITER ;


DROP TRIGGER IF EXISTS update_custgrade;
DELIMITER $$

CREATE TRIGGER update_custgrade
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    DECLARE tot_price INT;

    SELECT SUM(saleprice) INTO tot_price
    FROM orders
    WHERE custid = NEW.custid;

    UPDATE customer
    SET grade = CASE
        WHEN tot_price >= 30000 THEN 'VIP'
        WHEN tot_price >= 20000 THEN 'Gold'
        WHEN tot_price >= 10000 THEN 'Silver'
        ELSE 'Bronze'
    END
    WHERE custid = NEW.custid;
END $$

DELIMITER ;
desc orders;
INSERT INTO orders VALUES (null,1, 2, 12000, '2014-11-09');