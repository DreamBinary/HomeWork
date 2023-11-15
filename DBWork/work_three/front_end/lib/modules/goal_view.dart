import 'package:db_show/entity/Goal.dart';
import 'package:db_show/modules/text_row.dart';
import 'package:db_show/entity/book.dart';
import 'package:db_show/net/api.dart';
import 'package:flutter/material.dart';

class GoalView extends StatelessWidget {
  final Goal goal;

  const GoalView({required this.goal, super.key});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController(text: goal.name);
    final description = TextEditingController(text: goal.description);
    final goalMoney = TextEditingController(text: goal.goalMoney.toString());

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const Text("目标", style: TextStyle(fontSize: 20)),
          TextRow(title: "目标名 : ", controller: name),
          TextRow(title: "目标金额 : ", controller: goalMoney, isNum: true),
          TextRow(
              title: "已存金额 : ",
              readOnly: true,
              controller:
                  TextEditingController(text: goal.savedMoney.toString())),
          TextRow(title: "介绍 : ", controller: description),
          TextRow(
              title: "创建时间 : ",
              readOnly: true,
              controller:
                  TextEditingController(text: goal.createTime.toString())),
          TextRow(
              title: "更新时间 : ",
              readOnly: true,
              controller:
                  TextEditingController(text: goal.updateTime.toString())),
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async => {
                  await Api.deleteGoal(goal.id),
                  Navigator.pop(context),
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text("删除"),
                ),
              ),
              ElevatedButton(
                onPressed: () async => {
                  await Api.updateGoal(goal.id, name.text, description.text,
                      num.parse(goalMoney.text)),
                  Navigator.pop(context),
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text("更新"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
