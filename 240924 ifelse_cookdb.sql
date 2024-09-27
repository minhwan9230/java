drop table emrptbl;
create table emptbl(emp char(3), manager char(3), emptel varchar(8));
insert into emptbl values('나사장',null,'0000');
insert into emptbl values('김재무','나사장','2222');
insert into emptbl values('김부장','김재무','2222-1');
insert into emptbl values('이부장','김재무','2222-2');
insert into emptbl values('우대리','이부장','2222-2-1');
insert into emptbl values('지사원','이부장','2222-2-2');
insert into emptbl values('이영업','나사장','1111');
insert into emptbl values('한과장','이영업','1111-1');
insert into emptbl values('최정보','나사장','3333');
insert into emptbl values('윤차장','최정보','3333-1');
insert into emptbl values('이주임','윤차장','3333-1-1');

select a.emp as'부하직원', b.emp as'직속상관', b.emptel as '직속상관연락처'
from  empTBL A 
INNER JOIN empTBL B 
ON A.manager = B.emp
WHERE A.emp = '우대리';

drop procedure if exists ifproc;
delimiter $$
create procedure ifproc()
begin
declare var1 int;
set var1 = 100;

if var1 = 100 then
select '100입니다.';
else
select '100이 아닙니다.';
end if;
end $$
delimiter ;
call ifproc();

drop procedure if exists ifproc2;
use employees;
delimiter $$
create procedure ifproc2()
begin
declare hiredate date;
declare curdate date;
declare days int;

select hire_date into hiredate
from employees.employees
where emp_no = 10035;

set curdate = '1990-01-01';
set days = datediff(curdate,hiredate);

if(days/365) >= 5 then
select concat('입사한지 ',days,'일이나 지났습니다. 축하합니다!') as '메시지';
else
select concat('입사한지 ',days,'일밖에 안되었네요. 열심히 일하세요.') as '메시지' ;
end if;
end $$
delimiter ;
call ifproc2();


drop procedure if exists ifproc3;
delimiter $$
create procedure ifproc3()
begin
declare point int;
declare credit char(1);
set point = 58;

if point >=90 then
set credit = 'A';
elseif point >=80 then
set credit = 'B';
elseif point >=70 then
set credit = 'C';
elseif point >=60 then
set credit = 'D';
else
set credit = 'F';
end if;
select concat('취득점수==>',point) as 취득점수, concat('학점==>',credit) as 학점;
end $$
delimiter ;
call ifproc3();

drop procedure if exists caseproc;
delimiter $$
create procedure caseproc()
begin
declare point int;
declare credit char(1);
set point=87;

case
when point>= 90 then
set credit='A';
when point>= 80 then
set credit='B';
when point>= 70 then
set credit='C';
when point>= 60 then
set credit='D';
else
set credit='F';
end case;
select point as 취득점수, credit as 학점;
end $$
delimiter ;
call caseproc();


drop procedure if exists whileproc;
delimiter $$
create procedure whileproc()
begin
declare i int;
declare hap int;
set i= 1;
set hap=0;

while(i <=57)do
set hap=hap+i;
set i=i+1;
end while;

select hap;
end $$
delimiter ;
call whileproc;

drop procedure if exists whileproc2;
delimiter $$
create procedure whileproc2()
begin
declare i int;
declare hap int;
set i =1;
set hap=0;

myw: while(i<=100)do 
if(i%7 =0) then
set i=i+1;
iterate myw;
end if;

set hap=hap+i;
-- if (hap>1000) then
-- leave myw;
-- end if;
set i =i+1;
end while;

select hap;
end $$
delimiter ;
call whileproc2();

select * from testtest;


DROP PROCEDURE IF EXISTS errorProc;
DELIMITER $$ 
CREATE PROCEDURE errorProc() 
BEGIN 
DECLARE CONTINUE HANDLER FOR 1157 SELECT '테이블이 없어요ㅠㅠ' AS '메시지';
SELECT * FROM noTable;
SELECT * FROM departments;
show errors;
END $$ 
DELIMITER ;
CALL errorProc();

use cookdb;

drop procedure if exists errorproc2;
delimiter $$
create procedure errorproc2()
begin
declare continue handler for sqlexception
begin
show errors;
select '오류가 발생했네요. 작업을 취소시켰습니다.' as '메시지';
rollback;
end;
insert into usertbl values('YJS','윤정수',1988,'서울',null,null,170,current_date());
select * from usertbl;
end $$
delimiter ;
call errorproc2;


prepare myquery from 'select * from usertbl where userid = "NHS"';
execute myquery;
deallocate prepare myquery;


drop table if exists mytbl;
create table mytbl(id int auto_increment primary key, mdate datetime);

set @curdate= current_timestamp();

prepare myq from 'insert into mytbl values(null,?)';
execute myq using @curdate;
deallocate prepare myq;

select * from mytbl;

drop procedure if exists userproc1;
delimiter $$
create procedure userproc1(in uname varchar(10))
begin
select*from usertbl where username=uname;
end $$
delimiter ;
call userproc1('유재석');

drop procedure if exists userproc2;
delimiter $$
create procedure userproc2(
in userbirth int, in userheight int)
begin
select * from usertbl where birthyear>userbirth and height>userheight;
end $$
delimiter ;
call userproc2(1971,170);


drop procedure if exists userproc3;
delimiter $$
create procedure userproc3(
in txtvalue char(10), out outvalue int)
begin
insert into testtbl values(null,txtvalue);
select max(id) into outvalue from testtbl;
end $$
delimiter ;

create table if not exists testtbl(id int auto_increment primary key,
txt char(10));

call userproc3('테스트값',@myvalue);
select concat ('입력값',@myvalue);

drop procedure if exists ifelseproc;
delimiter $$
create procedure ifelseproc(in uname varchar(10))
	begin
		declare byear int;
        select birthyear into byear from usertbl where username=uname;
        if (byear >=1970) then
			select '아직 젊군요..';
		else
			select '나이가 지극하네요..';
		end if;
	end $$
delimiter ;

call ifelseproc('유재석');


drop procedure if exists caseproc;
delimiter $$
create procedure caseproc (in uname varchar(10))
	begin
		declare byear int;
        declare tti char(3);
        select birthyear into byear from usertbl where username=uname;
        case
			when (byear%12=0) then set tti = '원숭이';
            when (byear%12=1) then set tti = '닭';
            when (byear%12=2) then set tti = '개';
            when (byear%12=3) then set tti = '돼지';
            when (byear%12=4) then set tti = '쥐';
            when (byear%12=5) then set tti = '소';
            when (byear%12=6) then set tti = '호랑이';
            when (byear%12=7) then set tti = '토끼';
            when (byear%12=8) then set tti = '용';
            when (byear%12=9) then set tti = '뱀';
            when (byear%12=10) then set tti = '말';
		else set tti='양';
		end case;
        select concat(uname,'의 띠 ==>',tti) as 띠;
	end $$
    delimiter ;
    
call caseproc('유재석');
	
    
    
drop table if exists gugutbl;
create table gugutbl(txt varchar(100));

drop procedure if exists whileproc;
delimiter $$
create procedure whileproc()
	begin
		declare str varchar(100);
        declare i int;
        declare k int;
        set i=2;
        
        while(i<=9) do
			set str='';
            set k=1;
				while(k<=9)do
					set str=concat(str,'|',i,'x',k,'=',i*k);
                    set k=k+1;
				end while;
                set i= i+1;
                insert into gugutbl values(str);
		end while;
	end $$
delimiter ;
call whileproc();
select * from gugutbl;



drop procedure if exists errorproc;
delimiter $$
create procedure errorproc()
begin
	declare i int;
    declare hap int;
    declare savehap int;
    
    declare exit handler for 1264
		begin
        select concat('INT 오버플로 직전의 합계 -->',savehap);
        select concat('1+2+3+4+...+',i,'=오버플로');
        end;
	set i =1;
    set hap=0;
    
    while(true) do
		set savehap = hap;
        set hap= hap+i;
        set i= i+1;
	end while;
end $$
delimiter ;

call errorproc();


drop procedure if exists nameproc;
delimiter $$
create procedure nameproc(in tblname varchar(20))
begin
	set @sqlquery=concat('select * from ',tblname);
    prepare myquery from @sqlquery;
    execute myquery;
    deallocate prepare myquery;
end $$
delimiter ;
call nameproc('usertbl');
select @sqlquery;
