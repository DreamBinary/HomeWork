import 'package:db_show/time_util.dart';

/// create_time : "Fri, 10 Nov 2023 01:25:57 GMT"
/// description : "买一辆车"
/// goal_money : 100000
/// id : 1
/// name : "买车"
/// saved_money : 0
/// saved_record : []
/// update_time : "Fri, 10 Nov 2023 01:25:57 GMT"

class Goal {
  String _createTime;
  String _description;
  num _goalMoney;
  num _goalId;
  String _name;
  num _savedMoney;
  List<num> _savedRecord;
  String _updateTime;

  Goal(this._createTime, this._description, this._goalMoney, this._goalId,
      this._name, this._savedMoney, this._savedRecord, this._updateTime);

  factory Goal.fromJson(dynamic json) => Goal(
        TimeUtil.formatStringTime(json['create_time'] as String),
        json['description'] as String,
        json['goal_money'] as num,
        json['goal_id'] as num,
        json['name'] as String,
        json['saved_money'] as num,
        json['saved_record'] != null ? json['saved_record'].cast<num>() : [],
        TimeUtil.formatStringTime(json['update_time'] as String),
      );

  String get createTime => _createTime;

  String get description => _description;

  num get goalMoney => _goalMoney;

  num get id => _goalId;

  String get name => _name;

  num get savedMoney => _savedMoney;

  List<num> get savedRecord => _savedRecord;

  String get updateTime => _updateTime;
}
