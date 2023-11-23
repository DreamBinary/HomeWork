from dataclasses import dataclass
from datetime import datetime

from database import db


# create table if not exists book
# (
#     id          int          not null primary key auto_increment comment "primary key",
#     name        varchar(50)  not null comment "账本名称",
#     user_id     int         not null comment "用户id",
#     create_time datetime     not null default now() comment "创建时间",
#     update_time datetime     not null default now() comment "更新时间",
#     description varchar(200) ,
#     foreign key (author) references user (id)
# ) engine = InnoDB
# default charset = utf8mb4 comment '账本表';

@dataclass
class Book(db.Model):
    __tablename__ = "book"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True, comment="primary key")
    name = db.Column(db.String(50), nullable=False, comment="账本名称", unique=True)
    user_id = db.Column(db.Integer, db.ForeignKey("user.id", ondelete='cascade'))
    create_time = db.Column(db.DateTime, nullable=False, default=datetime.now(), comment="创建时间")
    update_time = db.Column(db.DateTime, nullable=False, default=datetime.now(), comment="更新时间")
    description = db.Column(db.String(200), nullable=True)

    multiuser = db.relationship("Multiuser", backref="book", passive_deletes=True)
    record = db.relationship("Record", backref="book", passive_deletes=True)
