import 'package:db_show/modules/goal_col.dart';
import 'package:db_show/modules/goal_record_col.dart';
import 'package:db_show/modules/item.dart';
import 'package:db_show/modules/list_show.dart';
import 'package:db_show/modules/record_col.dart';
import 'package:flutter/material.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              child: const MainPage(),
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async => {
      //     await Api.deleteBook(3),
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  num bookId = 1;
  num goalId = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BookCol(
            username: "user1",
            onTapBook: (bookId) => {
              setState(() {
                this.bookId = bookId;
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
            onRefresh: () => {
              setState(() {}),
            },
          ),
        ),
        Expanded(
          child: GoalCol(
            username: "user1",
            onTapGoal: (goalId) => {
              setState(() {
                this.goalId = goalId;
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
            onRefresh: () => {
              setState(() {}),
            },
          ),
        ),
      ],
    );
  }
}
