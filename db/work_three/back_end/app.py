from flask import Flask
from flask_cors import CORS

from config.config import *
from database import db

app = Flask(__name__)
CORS(app)
app.config['SQLALCHEMY_DATABASE_URI'] = \
    f"mysql+pymysql://{USERNAME}:{PASSWORD}@{HOSTNAME}:{PORT}/{DATABASE}?charset=utf8mb4"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['JSON_AS_ASCII'] = False
db.init_app(app)


def create_app():
    # with app.app_context():
    #     db.drop_all()
    #     db.create_all()
    from views import user_bp, record_bp, book_bp, goal_bp, goal_record_bp
    app.register_blueprint(user_bp)
    app.register_blueprint(record_bp)
    app.register_blueprint(book_bp)
    app.register_blueprint(goal_bp)
    app.register_blueprint(goal_record_bp)
    app.run()


if __name__ == '__main__':
    create_app()
