SET GLOBAL log_bin_trust_function_creators = 1;

use cookdb;

drop function if exists userfunc;
delimiter $$
create function userfunc(value1 int,value2 int)
returns int
begin
	return value1+value2;
end $$


drop function if exists getagef
delimiter $$
create function getagef(byear int)
	returns int
begin
	declare age int;
    set age=year(curdate())-byear;
    return age;
end $$
delimiter ;

select getagef(1992);

