from flask import Blueprint

from entity import Type
from views.response import Response

type_bp = Blueprint('type', __name__, url_prefix='/type')


@type_bp.route('/get', methods=['GET'])
def get():
    types = Type.query.all()
    data = []
    for t in types:
        data.append(t.name)
    return Response(data=data).to_json()
