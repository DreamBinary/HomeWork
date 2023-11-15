from dataclasses import dataclass

from database import db


# create table if not exists card
# (
#     id          int         not null primary key auto_increment comment "primary key",
#     user_id     int         not null comment "用户id",
#     name        varchar(50) not null comment "银行卡名称",
#     money       double      not null comment "金额",
#     description varchar(200),
#     foreign key (user_id) references user (id) on delete cascade
# ) engine = InnoDB
# default charset = utf8mb4 comment '银行卡表';
@dataclass
class Card(db.Model):
    __tablename__ = "card"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True, comment="primary key")
    user_id = db.Column(db.Integer, db.ForeignKey("user.id", ondelete='cascade'))
    name = db.Column(db.String(50), nullable=False, comment="银行卡名称")
    money = db.Column(db.Float, nullable=False, comment="金额")
    description = db.Column(db.String(200))

    def __repr__(self):
        return f"<Card name:{self.name} money:{self.money} description:{self.description}>"
