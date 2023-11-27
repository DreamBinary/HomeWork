123from flask import Blueprint, request

from database import db
from entity import Record, Type
from views.response import Response

record_bp = Blueprint('record', __name__, url_prefix='/record')


@record_bp.route('/get', methods=['GET'])
def get():
    book_id = request.args.get('book_id')
    records = Record.query.filter_by(book_id=book_id).all()
    data = []
    for record in records:
        data.append({
            "record_id": record.id,
            "name": record.name,
            "type_id": record.type_id,
            "price": record.price,
            "is_in": record.is_in,
            "create_time": record.create_time,
            "update_time": record.update_time
        })
    print(data)
    return Response(data=data).to_json()


@record_bp.route('/add', methods=['POST'])
def add():
    book_id = request.form.get('book_id')
    type_id = request.form.get('type_id')
    name = request.form.get('name')
    price = request.form.get('price')
    is_in = request.form.get('is_in')
    is_in = True if is_in == "true" else False
    record = Record(book_id=book_id, type_id=type_id, name=name, price=price, is_in=is_in)
    db.session.add(record)
    db.session.commit()
    return Response(data={"id": record.id}, msg="添加成功").to_json()


@record_bp.route('/delete', methods=['DELETE'])
def delete():
    record_id = request.form.get('record_id')
    record = Record.query.filter_by(id=record_id).first()
    if record is None:
        return Response(404, "记录不存在").to_json()
    else:
        db.session.delete(record)
        db.session.commit()
        return Response(msg="删除成功").to_json()


@record_bp.route('/update', methods=['PUT'])
def update():
    record_id = request.form.get('record_id')
    name = request.form.get('name')
    type_id = request.form.get('type_id')
    price = request.form.get('price')
    is_in = request.form.get('is_in')
    record = Record.query.filter_by(id=record_id).first()
    is_in = True if is_in == "true" else False
    if record is None:
        return Response(404, "记录不存在").to_json()
    else:
        record.type_id = type_id if type_id is not None else record.type_id
        record.name = name if name is not None else record.name
        record.price = price if price is not None else record.price
        record.is_in = is_in if is_in is not None else record.is_in
        db.session.commit()
        return Response(msg="更新成功").to_json()
