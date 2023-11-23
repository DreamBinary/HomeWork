from flask import Blueprint, request

from database import db
from entity import User, Goal
from views.response import Response

goal_bp = Blueprint('goal', __name__, url_prefix='/goal')


# todo check


@goal_bp.route('/get', methods=['GET'])
def get():
    username = request.args.get('username')
    user = User.query.filter_by(username=username).first()
    if user is None:
        return Response(404, "用户不存在").to_json()
    else:
        goal = user.goal
        data = []
        for g in goal:
            data.append({
                "goal_id": g.id,
                "name": g.name,
                "goal_money": g.goal_money,
                "saved_money": g.saved_money,
                "create_time": g.create_time,
                "update_time": g.update_time,
                "description": g.description,
                "saved_record": [r.money for r in g.goal_record]
            })
        return Response(data=data).to_json()


@goal_bp.route('/add', methods=['POST'])
def add():
    name = request.form.get('name')
    goal_money = request.form.get('goal_money')
    description = request.form.get('description')
    username = request.form.get('username')
    user = User.query.filter_by(username=username).first()
    if user is None:
        return Response(404, "用户不存在").to_json()
    else:
        goal = Goal(name=name, goal_money=goal_money, description=description, user_id=user.id)
        db.session.add(goal)
        db.session.commit()
        return Response(data={"id": goal.id}, msg="添加成功").to_json()


@goal_bp.route('/delete', methods=['DELETE'])
def delete():
    goal_id = request.form.get('goal_id')
    goal = Goal.query.filter_by(id=goal_id).first()
    if goal is None:
        return Response(404, "目标不存在").to_json()
    else:
        db.session.delete(goal)
        db.session.commit()
        return Response(msg="删除成功").to_json()


@goal_bp.route('/update', methods=['PUT'])
def update():
    goal_id = request.form.get('goal_id')
    name = request.form.get('name')
    goal_money = request.form.get('goal_money')
    description = request.form.get('description')
    goal = Goal.query.filter_by(id=goal_id).first()
    if goal is None:
        return Response(404, "目标不存在").to_json()
    else:
        goal.name = name
        goal.goal_money = goal_money
        goal.description = description
        db.session.commit()
        return Response(msg="更新成功").to_json()
