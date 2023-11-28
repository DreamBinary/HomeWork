from flask import Blueprint, request

from database import db
from entity import Book, User, Multiuser
from .response import Response

book_bp = Blueprint('book', __name__, url_prefix='/book')


@book_bp.route('/get', methods=['GET'])
def get():
    username = request.args.get('username')
    user = User.query.filter_by(username=username).first()
    if user is None:
        return Response(404, msg="用户不存在").to_json()
    else:
        data = {"self": [], "multi": []}
        books = user.book
        for book in books:
            data["self"].append({"id": book.id, "name": book.name, "author": username, "create_time": book.create_time,
                                 "update_time": book.update_time, "description": book.description,
                                 "multiuser": [User.query.filter_by(id=multiuser.user_id).first().username
                                               for multiuser in book.multiuser]})
            multiusers_user = user.multiuser  # multiuser_book about this user ==>> find book
            for multiuser_user in multiusers_user:
                book_id = multiuser_user.book_id
                book = Book.query.filter_by(id=book_id).first()
                a_multiuser_book = {"id": book.id, "name": book.name,
                                    "author": User.query.filter_by(id=book.user_id).first().username,
                                    "create_time": book.create_time, "update_time": book.update_time,
                                    "description": book.description,
                                    "multiuser": [User.query.filter_by(id=multiuser_book.user_id).first().username for
                                                  multiuser_book in
                                                  book.multiuser]}
                data["multi"].append(a_multiuser_book)
            return Response(data=data).to_json()


@book_bp.route('/add', methods=['POST'])
def add():
    name = request.form.get('name')
    author = request.form.get('author')
    description = request.form.get('description')
    user = User.query.filter_by(username=author).first()
    if user is None:
        return Response(404, msg="用户不存在").to_json()
    else:
        book = Book(name=name, user_id=user.id, description=description)
        db.session.add(book)
        db.session.commit()
        return Response(msg="添加成功").to_json()


@book_bp.route('/addMulti', methods=['POST'])
def add_multi():
    name = request.form.get('name')
    author = request.form.get('author')
    description = request.form.get('description')
    user = User.query.filter_by(username=author).first()
    multi = request.form.get('multi').split(',')
    if user is None:
        return Response(404, msg="用户不存在").to_json()
    else:
        book = Book(name=name, user_id=user.id, description=description)
        for m in multi:
            multiuser = Multiuser(user_id=User.query.filter_by(username=m).first().id)
            book.multiuser.append(multiuser)
        db.session.add(book)
        db.session.commit()
        return Response(msg="添加成功").to_json()


@book_bp.route('/delete', methods=['DELETE'])
def delete():
    book_id = request.form.get('book_id')
    book = Book.query.filter_by(id=book_id).first()
    if book is None:
        return Response(404, msg="账本不存在").to_json()
    else:
        db.session.delete(book)
        db.session.commit()
        return Response(msg="删除成功").to_json()


@book_bp.route('/update', methods=['PUT'])
def update():
    book_id = request.form.get('book_id')
    name = request.form.get('name')
    description = request.form.get('description')
    book = Book.query.filter_by(id=book_id).first()
    if book is None:
        return Response(code=404, msg="账本不存在").to_json()
    else:
        if name is not None:
            book.name = name
        if description is not None:
            book.description = description
        db.session.commit()
        return Response(msg="更新成功").to_json()
