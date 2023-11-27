import 'package:db_show/time_util.dart';

class BookRecord {
  String _name;
  String _createTime;
  num _typeId;
  num _recordId;
  bool _isIn;
  num _price;
  String _updateTime;

  BookRecord(this._name, this._createTime, this._recordId, this._isIn,
      this._price, this._typeId, this._updateTime) {
    _typeId = typeId - 1;
  }

  @override
  String toString() {
    return 'BookRecord{_name: $_name, _createTime: $_createTime, _typeId: $_typeId, _recordId: $_recordId, _isIn: $_isIn, _price: $_price, _updateTime: $_updateTime}';
  }

  factory BookRecord.fromJson(dynamic json) => BookRecord(
        json['name'] as String,
        TimeUtil.formatStringTime(json['create_time'] as String),
        json['record_id'] as num,
        json['is_in'] as bool,
        json['price'] as num,
        json['type_id'] as num,
        TimeUtil.formatStringTime(json['update_time'] as String),
      );

  num get typeId => _typeId;

  String get name => _name;

  String get createTime => _createTime;

  num get id => _recordId;

  bool get isIn => _isIn;

  num get price => _price;

  String get updateTime => _updateTime;
}
