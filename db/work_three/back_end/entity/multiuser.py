from dataclasses import dataclass

from database import db


# create table if not exists multiuser
# (
#     id      int not null primary key auto_increment comment "primary key",
#     book_id int not null comment "账本id",
#     user_id int not null comment "用户id",
#     foreign key (user_id) references user (id) on delete cascade,
#     foreign key (book_id) references book (id) on delete cascade
# ) engine = InnoDB
# default charset = utf8mb4 comment '多人账本表';

@dataclass
class Multiuser(db.Model):
    __tablename__ = "multiuser"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True, comment="primary key")
    book_id = db.Column(db.Integer, db.ForeignKey("book.id", ondelete='cascade'))
    user_id = db.Column(db.Integer, db.ForeignKey("user.id", ondelete='cascade'))

    def __repr__(self):
        return f"<Multiuser book_id:{self.book_id} user_id:{self.user_id}>"
