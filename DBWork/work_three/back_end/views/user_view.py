from flask import Blueprint
from flask import request

from database import db
from entity import User
from views.response import Response

user_bp = Blueprint('user', __name__, url_prefix='/user')


# todo check

@user_bp.route('/login', methods=['POST'])
def login():
    username = request.form.get('username')
    password = request.form.get('password')
    user = User.query.filter_by(username=username).first()
    if user is None:
        return Response(data=False, msg="用户名不存在").to_json()
    elif user.password != password:
        return Response(data=False, msg="密码错误").to_json()
    else:
        return Response(data=True, msg="登录成功").to_json()


@user_bp.route('/register', methods=['POST'])
def register():
    username = request.form.get('username')
    password = request.form.get('password')
    user = User.query.filter_by(username=username).first()
    if user is not None:
        return Response(data=False, msg="用户名已存在").to_json()
    else:
        user = User(username=username, password=password)
        db.session.add(user)
        db.session.commit()
        return Response(data=True, msg="注册成功").to_json()


@user_bp.route('/delete', methods=['DELETE'])
def delete():
    username = request.form.get('username')
    password = request.form.get('password')
    user = User.query.filter_by(username=username).first()
    if user is None:
        return Response(data=False, msg="用户名不存在").to_json()
    else:
        if user.password != password:
            return Response(data=False, msg="密码错误").to_json()
        db.session.delete(user)
        db.session.commit()
        return Response(data=True, msg="删除成功").to_json()


@user_bp.route('/update', methods=['PUT'])
def update():
    username = request.form.get('username')
    old_password = request.form.get('old_password')
    new_password = request.form.get('new_password')
    print(username, old_password, new_password)
    user = User.query.filter_by(username=username).first()
    if user is None:
        return Response(data=False, msg="用户名不存在").to_json()
    else:
        if user.password != old_password:
            return Response(data=False, msg="密码错误").to_json()
        user.password = new_password
        db.session.commit()
        return Response(data=True, msg="修改成功").to_json()
