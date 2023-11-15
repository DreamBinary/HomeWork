drop database if exists account;
create database if not exists account default character set UTF8MB4;

show databases;
use account;
show tables;

create table if not exists user
(
    id       int         not null primary key auto_increment comment 'primary key',
    username varchar(50) not null unique comment '用户名',
    password varchar(50) not null,
    email    varchar(50) not null
) engine = InnoDB
  default charset = utf8mb4 comment '用户表';

create table if not exists book
(
    id          int         not null primary key auto_increment comment 'primary key',
    name        varchar(50) not null unique comment '账本名称',
    user_id     int         not null comment '用户id',
    create_time datetime    not null default now() comment '创建时间',
    update_time datetime    not null default now() comment '更新时间',
    description varchar(200),
    foreign key (user_id) references user (id) on delete cascade
) engine = InnoDB
  default charset = utf8mb4 comment '账本表';

create table if not exists type
(
    id   int         not null primary key auto_increment comment 'primary key',
    name varchar(50) not null comment '类型名称'
) engine = InnoDB
  default charset = utf8mb4 comment '记录类型表';

create table if not exists record
(
    id          int         not null primary key auto_increment comment 'primary key',
    book_id     int         not null comment '账本id',
    type_id     int         not null comment '类型id',
    name        varchar(50) not null comment '记录名称',
    price       double      not null comment '金额',
    is_in       boolean     not null default 0 comment '0:支出 1:收入',
    create_time datetime    not null default now() comment '创建时间',
    update_time datetime    not null default now() comment '更新时间',
    foreign key (book_id) references book (id) on delete cascade,
    foreign key (type_id) references type (id) on delete cascade
) engine = InnoDB
  default charset = utf8mb4 comment '记录表';

create table if not exists multiuser
(
    id      int not null primary key auto_increment comment 'primary key',
    book_id int not null comment '账本id',
    user_id int not null comment '用户id',
    foreign key (user_id) references user (id) on delete cascade,
    foreign key (book_id) references book (id) on delete cascade
) engine = InnoDB
  default charset = utf8mb4 comment '多人账本表';

create table if not exists goal
(
    id          int         not null primary key auto_increment comment 'primary key',
    user_id     int         not null comment '用户id',
    name        varchar(50) not null comment '目标名称',
    goal_money  double      not null comment '目标金额',
    saved_money double      not null default 0 comment '已存金额',
    create_time datetime    not null default now() comment '创建时间',
    update_time datetime    not null default now() comment '更新时间',
    description varchar(200),
    foreign key (user_id) references user (id) on delete cascade
) engine = InnoDB
  default charset = utf8mb4 comment '目标表';

create table if not exists goal_record
(
    id          int      not null primary key auto_increment comment 'primary key',
    goal_id     int      not null comment '目标id',
    money       double   not null comment '存入金额',
    create_time datetime not null default now() comment '创建时间',
    foreign key (goal_id) references goal (id) on delete cascade
) engine = InnoDB
  default charset = utf8mb4 comment '目标完成记录表';

create trigger update_book_time
    before update
    on book
    for each row
begin
    set new.update_time = now();
end;

create trigger update_record_time
    before update
    on record
    for each row
begin
    set new.update_time = now();
end;

create trigger update_goal_time
    before update
    on goal
    for each row
begin
    set new.update_time = now();
end;

create trigger insert_goal_record
    after insert
    on goal_record
    for each row
begin
    update goal
    set saved_money = saved_money + new.money
    where id = new.goal_id;
end;


insert into type (name)
values ('餐饮'),
       ('交通'),
       ('购物'),
       ('娱乐'),
       ('服饰'),
       ('日用'),
       ('通讯'),
       ('住房'),
       ('运动'),
       ('旅行'),
       ('医疗'),
       ('书籍'),
       ('学习'),
       ('数码'),
       ('汽车'),
       ('人情'),
       ('其他');

insert into user (username, password, email)
values ('user1', '123456', '123@gmail.com'),
       ('user2', '123456', '1234@gmail.com'),
       ('user3', '123456', '12345@gmai.com'),
       ('user4', '123456', '123456@gmai.com');

insert into account.book (name, user_id, description)
values ('book1', 1, 'this is a book'),
       ('book2', 2, 'this is a book1'),
       ('book3', 3, 'this is a book2'),
       ('book4', 4, 'this is a book3');

insert into account.record (book_id, type_id, name, price, is_in)
values (1, 1, '吃饭', 100, 0),
       (2, 1, '家教', 200, 1),
       (1, 1, '吃饭', 300, 0),
       (2, 1, '家教', 400, 1);

insert into account.multiuser (book_id, user_id)
values (1, 2),
       (1, 3),
       (1, 4),
       (2, 1),
       (2, 4);

insert into account.goal (user_id, name, goal_money, saved_money, description)
values (1, '买车', 100000, 0, '买一辆车'),
       (1, '买房', 1000000, 0, '买一套房'),
       (3, '买手机', 10000, 0, '买一部手机'),
       (4, '买电脑', 10000, 0, '买一台电脑');


insert into account.goal_record (goal_id, money)
values (1, 100),
       (1, 200),
       (1, 300),
       (1, 400),
       (2, 100),
       (2, 200),
       (2, 300),
       (2, 400),
       (3, 100),
       (3, 200),
       (3, 300),
       (3, 400),
       (4, 100),
       (4, 200),
       (4, 300),
       (4, 400);







