import 'package:db_show/entity/book.dart';
import 'package:db_show/modules/text_row.dart';
import 'package:db_show/net/api.dart';
import 'package:flutter/material.dart';

class BookView extends StatelessWidget {
  final Book book;

  const BookView({required this.book, super.key});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController(text: book.name);
    final description = TextEditingController(text: book.description);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const Text("账本", style: TextStyle(fontSize: 20)),
          TextRow(title: "账本名 : ", controller: name),
          TextRow(
              title: "创建者 : ",
              readOnly: true,
              controller: TextEditingController(text: book.author)),
          TextRow(
              title: "其他参与者 : ",
              readOnly: true,
              controller: TextEditingController(
                  text: book.multiuser
                      .toString()
                      .substring(1, book.multiuser.toString().length - 1))),
          TextRow(title: "介绍 : ", controller: description),
          TextRow(
              title: "创建时间 : ",
              readOnly: true,
              controller:
                  TextEditingController(text: book.createTime.toString())),
          TextRow(
              title: "更新时间 : ",
              readOnly: true,
              controller:
                  TextEditingController(text: book.updateTime.toString())),
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async => {
                  await Api.deleteBook(book.id),
                  Navigator.pop(context),
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text("删除"),
                ),
              ),
              ElevatedButton(
                onPressed: () async => {
                  await Api.updateBook(book.id, name.text, description.text),
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

class BookAddView extends StatelessWidget {
  final String author;

  const BookAddView({required this.author, super.key});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final description = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const Text("账本", style: TextStyle(fontSize: 20)),
          TextRow(title: "账本名 : ", controller: name),
          TextRow(title: "介绍 : ", controller: description),
          const Expanded(child: SizedBox()),
          ElevatedButton(
            onPressed: () async => {
              await Api.addBook(name.text, author, description.text),
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


class MultiBookAddView extends StatelessWidget {
  final String author;

  const MultiBookAddView({required this.author, super.key});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final description = TextEditingController();
    final multi = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const Text("账本", style: TextStyle(fontSize: 20)),
          TextRow(title: "账本名 : ", controller: name),
          TextRow(title: "介绍 : ", controller: description),
          TextRow(title: "其他参与者 : ", controller: multi),
          const Expanded(child: SizedBox()),
          ElevatedButton(
            onPressed: () async => {
              await Api.addMultiBook(name.text, author, description.text, multi.text),
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
