from dataclasses import dataclass
from datetime import datetime

from database import db


@dataclass
class Record(db.Model):
    __tablename__ = "record"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True, comment="primary key")
    book_id = db.Column(db.Integer, db.ForeignKey("book.id", ondelete='cascade'))
    type_id = db.Column(db.Integer, db.ForeignKey("type.id", ondelete='set null'))
    name = db.Column(db.String(50), nullable=False, comment="名称")
    price = db.Column(db.Double, nullable=False, comment="金额")
    is_in = db.Column(db.Boolean, nullable=False, default=0, comment="0:支出 1:收入")
    create_time = db.Column(db.DateTime, nullable=False, default=datetime.now(), comment="创建时间")
    update_time = db.Column(db.DateTime, nullable=False, default=datetime.now(), comment="更新时间")

    def __repr__(self):
        return f"<Record book_id:{self.book_id} type_id:{self.type_id} price:{self.price} isIn:{self.isIn}>"
