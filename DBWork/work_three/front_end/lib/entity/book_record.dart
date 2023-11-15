class BookRecord {
  String _name;
  String _createTime;
  String _typeName;
  num _recordId;
  bool _isIn;
  num _price;
  String _updateTime;

  BookRecord(this._name, this._createTime, this._recordId, this._isIn,
      this._price, this._typeName, this._updateTime);


  factory BookRecord.fromJson(dynamic json) => BookRecord(
        json['name'] as String,
        json['create_time'] as String,
        json['record_id'] as num,
        json['is_in'] as bool,
        json['price'] as num,
        json['type_name'] as String,
        json['update_time'] as String,
      );

  String get typeName => _typeName;

  String get name => _name;

  String get createTime => _createTime;

  num get id => _recordId;

  bool get isIn => _isIn;

  num get price => _price;

  String get updateTime => _updateTime;
}
