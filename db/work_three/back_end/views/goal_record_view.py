from flask import Blueprint, request

from database import db
from entity import Goal, GoalRecord
from views.response import Response

goal_record_bp = Blueprint('goal_record', __name__, url_prefix='/goal_record')


@goal_record_bp.route('/get', methods=['GET'])
def get():
    goal_id = request.args.get('goal_id')
    goal = Goal.query.filter_by(id=goal_id).first()
    data = []
    if goal is None:
        return Response(404, msg="目标不存在").to_json()
    goal_record = goal.goal_record

    for r in goal_record:
        data.append({
            "record_id": r.id,
            "money": r.money,
            "create_time": r.create_time
        })
    return Response(data=data).to_json()


@goal_record_bp.route('/add', methods=['POST'])
def add():
    goal_id = request.form.get('goal_id')
    money = request.form.get('money')
    goal = Goal.query.filter_by(id=goal_id).first()
    if goal is None:
        return Response(404, "目标不存在").to_json()
    else:
        goal_record = GoalRecord(money=money, goal_id=goal_id)
        db.session.add(goal_record)
        db.session.commit()
        return Response(data={"id": goal_record.id}, msg="添加成功").to_json()


@goal_record_bp.route('/delete', methods=['DELETE'])
def delete():
    record_id = request.form.get('goal_record_id')
    record = GoalRecord.query.filter_by(id=record_id).first()
    if record is None:
        return Response(404, "记录不存在").to_json()
    else:
        db.session.delete(record)
        db.session.commit()
        return Response(msg="删除成功").to_json()


@goal_record_bp.route('/update', methods=['PUT'])
def update():
    record_id = request.form.get('goal_record_id')
    money = request.form.get('money')
    record = GoalRecord.query.filter_by(id=record_id).first()
    if record is None:
        return Response(404, "记录不存在").to_json()
    else:
        if money is not None:
            record.money = money
        db.session.commit()
        return Response(msg="修改成功").to_json()
