import 'package:db_show/entity/goal_record.dart';
import 'package:db_show/modules/goal_record_view.dart';
import 'package:db_show/net/api.dart';
import 'package:flutter/material.dart';

import 'item.dart';
import 'list_show.dart';
import 'mydialog.dart';

class GoalRecordCol extends StatelessWidget {
  final num goalId;
  final String goalName;
  final Function onRefresh;

  const GoalRecordCol({
    required this.goalId,
    required this.goalName,
    required this.onRefresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Api.getGoalRecord(goalId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<GoalRecord> data = snapshot.data!;
          return ListContainer(
            title: "($goalName)的存钱记录",
            onTapAdd: () => {
              showDialog(
                context: context,
                builder: (context) => MyDialog(
                  child: GoalRecordAddView(goalId: goalId),
                ),
              )
            },
            children: List.generate(
              data.length,
              (index) => Item(
                title: "${data[index].createTime}  ==>> ${data[index].money}",
                onTap: () async => {
                  await showDialog(
                    context: context,
                    builder: (context) => MyDialog(
                      child: GoalRecordView(
                        record: data[index],
                      ),
                    ),
                  ),
                  onRefresh(),
                },
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
