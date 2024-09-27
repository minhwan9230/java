use madangdb;

drop procedure if exists avgprice;
delimiter $$
create procedure avgprice(out avgval int)
begin
	select avg(price) into avgval from book;
end $$
delimiter ;

call avgprice(@avgval);
select @avgval;


-- groupname 을 입력하여 그 group에 해당하는 제품의 총 판매량을 구하는 프로시저 
use cookdb;

drop procedure if exists totprice;
delimiter $$
create procedure totprice(in group_name varchar(5),out total_price int)
begin
	declare cnt int;
	declare exit handler for not found    
    begin
		show warnings;
        select '오류가 있어서 프로시저를 종료합니다.' as 메시지;
        rollback;
	end;
    select count(*) into cnt from buytbl where groupname=group_name;
		if cnt!=0 then
    select sum(price*amount) into total_price from buytbl 
				where groupname=group_name;
		else
			select '입력된 그룹명은 없습니다.' as 메시지;
		end if;
end $$
delimiter ;

call totprice('악기',@totprice);
select @totprice;



use cookdb;

drop procedure if exists totprice;
delimiter $$
create procedure totprice(in group_name varchar(5),out total_price int)
begin
	select sum(price*amount) into @tmp from buytbl 
				where groupname=group_name;
end $$
delimiter ;

call totprice('전자',@totprice);
select @tmp;


use madangdb;

drop procedure if exists b_info;
delimiter $$
create procedure b_info(
in b_name varchar(10),
in b_publisher varchar(10),
in b_price int)
begin
	declare cnt int;
	declare exit handler for not found
		begin
			show warnings;
			select '오류가 있어서 프로시저를 종료합니다.' as 메시지;
			rollback;
		end;
	select count(*) into cnt from book where bookname=b_name;
    
    if(cnt=0)then
		insert into book values(null,b_name,b_publisher,b_price);
    else
		update book set publisher=b_publisher, price=b_price 
			where bookname=b_name;
    end if;
        
end $$
delimiter ;

call b_info('어렵네잉;;','조민환',10);
select * from book;