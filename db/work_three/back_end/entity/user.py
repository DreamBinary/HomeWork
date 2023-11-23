from dataclasses import dataclass

from database import db


# from app import app

# create table if not exists user
# (
#     id       int         not null primary key auto_increment comment "primary key",
#     username varchar(50) not null,
#     password varchar(50) not null
# ) engine = InnoDB
# default charset = utf8mb4 comment '用户表';
@dataclass
class User(db.Model):
    __tablename__ = "user"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True, comment="primary key")
    username = db.Column(db.String(50), nullable=False, unique=True)
    password = db.Column(db.String(50), nullable=False)

    book = db.relationship("Book", backref="user", passive_deletes=True)
    multiuser = db.relationship("Multiuser", backref="user", passive_deletes=True)
    card = db.relationship("Card", backref="user", passive_deletes=True)
    goal = db.relationship("Goal", backref="user", passive_deletes=True)

    def __repr__(self):
        return f"<User username:{self.username} email:{self.email} is_admin:{self.is_admin}>"
