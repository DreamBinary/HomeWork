from dataclasses import dataclass
from datetime import datetime

from database import db


# create table if not exists goal_record
# (
#     id      int    not null primary key auto_increment comment 'primary key',
#     goal_id int    not null comment '目标id',
#     money   double not null comment '存入金额',
#     create_time datetime not null default now() comment '创建时间',
#     foreign key (goal_id) references goal (id) on delete cascade
# ) engine = InnoDB
# default charset = utf8mb4 comment '目标完成记录表';

@dataclass
class GoalRecord(db.Model):
    __tablename__ = "goal_record"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True, comment="primary key")
    goal_id = db.Column(db.Integer, db.ForeignKey("goal.id", ondelete='cascade'))
    money = db.Column(db.Float, nullable=False, comment="存入金额")
    create_time = db.Column(db.DateTime, nullable=False, default=datetime.now(),  comment="创建时间")

    def __repr__(self):
        return f"<GoalRecord goal_id:{self.goal_id} save_money:{self.save_money}>"
