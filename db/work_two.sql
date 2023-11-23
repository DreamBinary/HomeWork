select user
from mysql.user;

# create user 'username'@'host' identified by 'password';
create user 'fiv'@'%' identified by 'fivvvv';

select user
from mysql.user;

drop user 'fiv'@'%';

select user
from mysql.user;


create user 'fiv'@'%' identified by 'fivvvv';

# grant privileges on databasename.tablename to 'username'@'host'
# grant all privileges on *.* to 'fiv'@'%';
grant select, insert on *.* to 'fiv'@'%';

flush privileges; # 刷新权限

show grants for 'fiv'@'%';

revoke select on *.* from 'fiv'@'%';

show grants for 'fiv'@'%';

select *
from account.user;


drop procedure if exists select_user;

delimiter $
create procedure select_user(in username varchar(20))
begin
    select * from user where user.username = username;
end $

call select_user('user1');


# CREATE trigger trigger_name BEFORE|AFTER trigger_EVENT
# ON TABLE_NAME FOR EACH ROW trigger_STMT

drop trigger if exists trig_insert_record;

create trigger trig_insert_record
    after insert
    on account.record
    for each row
begin
    update account.book set update_time = now() where id = new.book_id;
end;

select *
from book;

insert into account.record (name, book_id, price, type_id)
values ('吃饭', 1, 100, 1);

select *
from book;


# mysqldump -u root -p database_name > file_name.sql

# mysqldump -u root -p account > account.sql

drop database account;

create database account;

# mysql -u root -p account < account.sql

show variables like '%timeout%'