import 'package:db_show/entity/goal_record.dart';
import 'package:db_show/modules/text_row.dart';
import 'package:db_show/net/api.dart';
import 'package:flutter/material.dart';

class GoalRecordView extends StatelessWidget {
  final GoalRecord record;

  const GoalRecordView({required this.record, super.key});

  @override
  Widget build(BuildContext context) {
    final money = TextEditingController(text: record.money.toString());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const Text("存钱记录", style: TextStyle(fontSize: 20)),
          TextRow(title: "存钱金额 : ", controller: money, isNum: true),
          TextRow(
              title: "创建时间 : ",
              readOnly: true,
              controller:
                  TextEditingController(text: record.createTime.toString())),
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => {
                  Api.deleteGoalRecord(record.recordId),
                  Navigator.pop(context),
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text("删除"),
                ),
              ),
              ElevatedButton(
                onPressed: () => {
                  Api.updateGoalRecord(
                    record.recordId,
                    num.parse(money.text),
                  ),
                  Navigator.pop(context),
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text("修改"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GoalRecordAddView extends StatelessWidget {
  final num goalId;

  const GoalRecordAddView({required this.goalId, super.key});

  @override
  Widget build(BuildContext context) {
    final money = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const Text("存钱记录", style: TextStyle(fontSize: 20)),
          TextRow(title: "存钱金额 : ", controller: money, isNum: true),
          const Expanded(child: SizedBox()),
          ElevatedButton(
            onPressed: () => {
              Api.addGoalRecord(goalId, num.parse(money.text)),
              Navigator.pop(context),
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text("添加"),
            ),
          ),
        ],
      ),
    );
  }
}
