from dataclasses import dataclass
from datetime import datetime

from database import db


# create table if not exists goal
# (
#     id          int         not null primary key auto_increment comment 'primary key',
#     user_id     int         not null comment '用户id',
#     name        varchar(50) not null comment '目标名称',
#     goal_money  double      not null comment '目标金额',
#     saved_money double      not null comment '已存金额',
#     create_time datetime    not null default now() comment '创建时间',
#     update_time datetime    not null default now() comment '更新时间',
#     description varchar(200),
#     foreign key (user_id) references user (id) on delete cascade
# ) engine = InnoDB
# default charset = utf8mb4 comment '目标表';


@dataclass
class Goal(db.Model):
    __tablename__ = "goal"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True, comment="primary key")
    user_id = db.Column(db.Integer, db.ForeignKey("user.id", ondelete='cascade'))
    name = db.Column(db.String(50), nullable=False, comment="目标名称")
    goal_money = db.Column(db.Float, nullable=False, comment="目标金额")
    saved_money = db.Column(db.Float, nullable=False, default=0, comment="已存金额")
    create_time = db.Column(db.DateTime, nullable=False, default=datetime.now(), comment="创建时间")
    update_time = db.Column(db.DateTime, nullable=False, default=datetime.now(), comment="更新时间")
    description = db.Column(db.String(200))

    goal_record = db.relationship("GoalRecord", backref="goal", passive_deletes=True)

    def __repr__(self):
        return f"<Goal name:{self.name} money:{self.money} description:{self.description}>"
