from flask import jsonify


class Response:
    def __init__(self, code=200, data=None, msg=None):
        self.code = code
        self.data = data
        self.msg = msg

    def to_json(self):
        return jsonify({
            "code": self.code,
            "data": self.data,
            "msg": self.msg
        })
