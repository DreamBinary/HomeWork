create database if not exists account default character set UTF8MB4;

show databases;
use account;
show tables;

create table if not exists user
(
    id       int         not null primary key auto_increment comment "primary key",
    username varchar(50) not null,
    password varchar(50) not null,
    email    varchar(50) not null,
    is_admin int         not null default 0 comment "0:普通用户 1:管理员"
);

create table if not exists book
(
    id          int          not null primary key auto_increment comment "primary key",
    name        varchar(50)  not null comment "账本名称",
    author      int          not null comment "创建人",
    create_time datetime     not null default now() comment "创建时间",
    update_time datetime     not null default now() comment "更新时间",
    description varchar(200) not null,
    foreign key (author) references user (id)
);

create table if not exists record
(
    id          int      not null primary key auto_increment comment "primary key",
    book_id     int      not null,
    price       double   not null comment "金额",
    create_time datetime not null default now() comment "创建时间",
    isIn        boolean  not null default 0 comment "0:支出 1:收入",
    foreign key (book_id) references book (id)
);

create table if not exists multiuser
(
    book_id int not null primary key comment "账本id",
    user_id int not null,
    foreign key (user_id) references user (id),
    foreign key (book_id) references book (id)
);

describe user;

alter table user
    add column phone varchar(11);

describe user;

show index from user;

alter table user
    add unique index (username);

show index from user;

drop index username on user;

show index from user;

# insert into record (book_id, price, isIn)
# values (1, 100, 0);

insert into user (username, password, email)
values ("user", "123456", "123@gmail.com"),
       ("user1", "123456", "1234@gmail.com"),
       ("user2", "123456", "12345@gmai.com"),
       ("user3", "123456", "123456@gmai.com");

insert into account.book (name, author, description)
values ("book", 1, "this is a book"),
       ("book1", 2, "this is a book1"),
       ("book2", 3, "this is a book2"),
       ("book3", 4, "this is a book3");

insert into account.record (book_id, price, isIn)
values (1, 100, 0),
       (2, 200, 1),
       (1, 300, 0),
       (2, 400, 1);

update account.user t
set t.password = 'abcdef'
WHERE t.username = "user";

set foreign_key_checks = 0;

delete
from user
where username = "user3";

set foreign_key_checks = 1;



select *
from user
where username = "user";

select u.username, b.name
from user as u
         inner join book as b on u.id = b.author
order by u.id;

select count(*)
from user;

select name, count(*)
from record,
     book
where record.book_id = book.id
group by book_id;

select *
from record
where book_id in (select author
                  from book
                  where book.name = "book");


create view record_view as
select r.price, r.isIn
from record as r;

select *
from record_view
where isIn = true;


# drop database account;



