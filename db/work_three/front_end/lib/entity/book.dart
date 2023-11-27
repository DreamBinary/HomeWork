import 'package:db_show/time_util.dart';

/// author : "user"
/// create_time : "Wed, 08 Nov 2023 15:46:03 GMT"
/// description : "this is a book"
/// id : 1
/// multiuser : ["user1","user2","user3"]
/// name : "book"
/// update_time : "Wed, 08 Nov 2023 15:46:03 GMT"

class Book {
  String _author;
  String _createTime;
  String _description;
  num _id;
  List<String> _multiuser;
  String _name;
  String _updateTime;

  Book(this._author, this._createTime, this._description, this._id,
      this._multiuser, this._name, this._updateTime);

  factory Book.fromJson(dynamic json) => Book(
        json['author'] as String,
        TimeUtil.formatStringTime(json['create_time'] as String),
        json['description'] as String,
        json['id'] as num,
        json['multiuser'] != null ? json['multiuser'].cast<String>() : [],
        json['name'] as String,
        TimeUtil.formatStringTime(json['update_time'] as String),
      );

  @override
  String toString() {
    return '{ ${this._author}, ${this._createTime}, ${this._description}, ${this._id}, ${this._multiuser}, ${this._name}, ${this._updateTime} }';
  }

  String get author => _author;

  String get createTime => _createTime;

  String get description => _description;

  num get id => _id;

  List<String> get multiuser => _multiuser;

  String get name => _name;

  String get updateTime => _updateTime;
}
