from dataclasses import dataclass

from database import db


# create table if not exists type
# (
#     id   int         not null primary key auto_increment comment "primary key",
#     name varchar(50) not null comment "类型名称"
# ) engine = InnoDB
# default charset = utf8mb4 comment '记录类型表';

@dataclass
class Type(db.Model):
    __tablename__ = "type"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True, comment="primary key")
    name = db.Column(db.String(50), nullable=False, comment="类型名称")

    def __repr__(self):
        return f"<Type name:{self.name}>"
