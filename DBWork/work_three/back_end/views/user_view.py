from flask import Blueprint
from flask import request

from database import db
from entity import User

user_bp = Blueprint('user', __name__, url_prefix='/user')


# todo check

@user_bp.route('/login', methods=['POST'])
def login():
    username = request.form.get('username')
    password = request.form.get('password')
    user = User.query.filter_by(username=username).first()
    if user is None:
        return '用户名不存在'
    elif user.password != password:
        return '密码错误'
    else:
        return '登录成功'


@user_bp.route('/register', methods=['POST'])
def register():
    username = request.form.get('username')
    password = request.form.get('password')
    email = request.form.get('email')
    user = User.query.filter_by(username=username).first()
    if user is not None:
        return '用户名已存在'
    else:
        user = User(username=username, password=password, email=email)
        user.save()
        return '注册成功'


@user_bp.route('/delete', methods=['DELETE'])
def delete():
    username = request.form.get('username')
    user = User.query.filter_by(username=username).first()
    if user is None:
        return '用户名不存在'
    else:
        db.session.delete(user)
        db.session.commit()
        return '删除成功'


@user_bp.route('/update', methods=['PUT'])
def update():
    username = request.form.get('username')
    password = request.form.get('password')
    email = request.form.get('email')
    user = User.query.filter_by(username=username).first()
    if user is None:
        return '用户名不存在'
    else:
        user.password = password
        user.email = email
        db.session.commit()
        return '修改成功'
