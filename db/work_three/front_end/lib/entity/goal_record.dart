import '../time_util.dart';

/// create_time : "Fri, 10 Nov 2023 02:11:15 GMT"
/// money : 100
/// record_id : 1

class GoalRecord {
  GoalRecord(this._createTime, this._money, this._recordId);

  factory GoalRecord.fromJson(dynamic json) => GoalRecord(
        TimeUtil.formatStringTime(json['create_time'] as String),
        json['money'] as num,
        json['record_id'] as num,
      );

  String _createTime;
  num _money;
  num _recordId;

  String get createTime => _createTime;

  num get money => _money;

  num get recordId => _recordId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['create_time'] = _createTime;
    map['money'] = _money;
    map['record_id'] = _recordId;
    return map;
  }
}
