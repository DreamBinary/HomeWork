import 'package:db_show/entity/Goal.dart';
import 'package:db_show/modules/item.dart';
import 'package:db_show/modules/list_show.dart';
import 'package:db_show/modules/mydialog.dart';
import 'package:db_show/net/api.dart';
import 'package:flutter/material.dart';

import 'goal_view.dart';

class GoalCol extends StatelessWidget {
  final String username;
  final Function(num) onTapGoal;
  final Function onRefresh;

  const GoalCol(
      {required this.username,
      required this.onTapGoal,
      required this.onRefresh,
      super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Api.getGoal(username),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Goal> data = snapshot.data!;
            return ListContainer(
              title: "目标记录",
              children: List.generate(
                data.length,
                (index) => Item(
                  title: data[index].name,
                  onLongPress: () => {
                    onTapGoal(data[index].id),
                  },
                  onTap: () async => {
                    await showDialog(
                      context: context,
                      builder: (context) => MyDialog(
                        child: GoalView(
                          goal: data[index],
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
        });
  }
}
