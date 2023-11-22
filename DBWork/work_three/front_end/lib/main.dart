import 'package:db_show/modules/goal_col.dart';
import 'package:db_show/modules/goal_record_col.dart';
import 'package:db_show/modules/enter.dart';
import 'package:db_show/modules/record_col.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'modules/book_col.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: FToastBuilder(),
      home: const Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  var isLogin = false;
  var username = "";

  @override
  Widget build(BuildContext context) {
    return isLogin
        ? MainPage(username: username)
        : EnterView(
            onLogin: (username) {
              setState(() {
                this.username = username;
                isLogin = true;
              });
            },
          );
  }
}

class MainPage extends StatefulWidget {
  final String username;

  const MainPage({required this.username, super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  num bookId = -1;
  num goalId = -1;
  String bookName = "null";
  String goalName = "null";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: LayoutBuilder(
          builder: (context, constraints) {
            var height = constraints.constrainHeight();
            return Padding(
              padding: EdgeInsets.all(height * 0.05),
              child: Row(
                children: [
                  Expanded(
                    child: BookCol(
                      username: widget.username,
                      onTapBook: (bookId, bookName) => {
                        setState(() {
                          this.bookId = bookId;
                          this.bookName = bookName;
                        })
                      },
                      onRefresh: () => {
                        setState(() {}),
                      },
                    ),
                  ),
                  Expanded(
                    child: RecordCol(
                      bookId: bookId,
                      bookName: bookName,
                      onRefresh: () => {
                        setState(() {}),
                      },
                    ),
                  ),
                  Expanded(
                    child: GoalCol(
                      username: widget.username,
                      onTapGoal: (goalId, goalName) => {
                        setState(() {
                          this.goalId = goalId;
                          this.goalName = goalName;
                        })
                      },
                      onRefresh: () => {
                        setState(() {}),
                      },
                    ),
                  ),
                  Expanded(
                    child: GoalRecordCol(
                      goalId: goalId,
                      goalName: goalName,
                      onRefresh: () => {
                        setState(() {}),
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
