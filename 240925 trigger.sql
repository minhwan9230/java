drop table if exists testtbl;
create table if not exists testtbl (id int, txt varchar(10));
insert into testtbl values(1,'이엑스아이디');
insert into testtbl values(2,'블랙핑크');
insert into testtbl values(3,'에이핑크');

drop trigger if exists testtrg;
delimiter $$
create trigger testtrg
	after delete
	on testtbl
    for each row
begin
	set @msg='가수 그룹이 삭제됨';
end $$
delimiter ;

set @msg='';
insert into testtbl values(4,'여자친구');
select @msg;
update testtbl set txt='레드벨벳' where id=3;
select @msg;
delete from testtbl where id=4;
select @msg;

DROP TABLE buyTBL; -- 구매 테이블은 실습에 필요 없으므로 삭제



CREATE TABLE backup_userTBL
( userID char(8) NOT NULL, 
userName varchar(10) NOT NULL, 
birthYear int NOT NULL, 
addr char(2) NOT NULL, 
mobile1 char(3), 
mobile2 char(8), 
height smallint, 
mDate date, 
modType char(2), -- 변경된 유형(‘수정’ 또는 ‘삭제’) 
modDate date, -- 변경된 날짜
modUser varchar(256), -- 변경한 사용자
grade char(10)
);


drop trigger if exists backusertbl_updatetrg;
delimiter $$
create trigger backusertbl_updatetrg
	after update
	on usertbl
	for each row
begin
	insert into backup_usertbl values(OLD.userid, OLD.userName, OLD.birthYear, 
				OLD.addr, OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate,
				'수정', CURDATE(), CURRENT_USER());
end $$
delimiter ;


drop trigger if exists backusertbl_deletetrg;
delimiter $$
create trigger backusertbl_deletetrg
after delete
on usertbl
for each row
begin
insert into backup_usertbl values(OLD.userID, OLD.userName, OLD.birthYear, 
			OLD.addr, OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate, 
			'삭제', CURDATE(), CURRENT_USER());
end $$
delimiter ;

update usertbl set addr ='제주' where userid = 'KJD';
select * from usertbl;
delete from usertbl where height >=180;


alter table buytbl2 drop constraint fkuserid; --



drop trigger if exists usertbl_inserttrg;
delimiter $$
create trigger usertbl_inserttrg
	after insert
    on usertbl
    for each row
begin
	signal sqlstate '45000'
		set message_text ='데이터의 입력을 시도했습니다. 귀하의 정보가 서버에 기록되었습니다.';
end $$
delimiter ;

insert into usertbl values ('ABC', '에비씨', 1977, '서울', '011', '1111111',181,
							'2019-12-25');


drop database if exists triggerdb;
create database if not exists triggerdb;

use triggerdb;

create table ordertbl
(orderno int auto_increment primary key, -- 구매 일련번호
userid varchar(5),		-- 회원아이디
prodname varchar(5),	-- 구매한물건
orderamount int			-- 구매수량
);
create table prodtbl
(prodname varchar(5), 	-- 물건이름
account int 			-- 물건수량
);
create table delivertbl
(deliverno int auto_increment primary key, 	-- 배송번호
prodname varchar(5),						-- 배송물품명
account int not null						-- 배송수량
);

insert into prodtbl values('사과',100);
insert into prodtbl values('배',100);
insert into prodtbl values('귤',100);

select * from ordertbl;
select * from prodtbl;
select * from delivertbl;

drop trigger if exists ordertrg;
delimiter $$
create trigger ordertrg
after insert
on ordertbl
for each row
begin
    update prodtbl set account= account-new.orderamount
    where prodname=new.prodname;
end $$
delimiter ;


drop trigger if exists prodtrg;
delimiter $$
create trigger prodtrg
after update
on prodtbl
for each row
begin
	declare orderamount int;
    set orderamount= old.account - new.account;
    insert into delivertbl(prodname,account)
    values(new.prodname, orderamount);
end $$
delimiter ;


drop trigger if exists w_ordertrg;
delimiter $$
create trigger w_ordertrg
before insert
on ordertbl
for each row
begin
declare cnt int;
select count(*) into cnt from prodtbl where prodname=new.prodname;
if cnt=0 then
	SIGNAL SQLSTATE '45000'
         SET MESSAGE_TEXT = '없는 물품입니다,';
end if;
end $$
delimiter ;


insert into ordertbl values(null,'john','복숭아',5);

select * from ordertbl;
select * from prodtbl;
select * from delivertbl;

