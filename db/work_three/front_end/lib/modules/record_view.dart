import 'package:db_show/entity/book_record.dart';
import 'package:db_show/modules/text_row.dart';
import 'package:db_show/modules/type_row.dart';
import 'package:db_show/net/api.dart';
import 'package:flutter/material.dart';

class RecordView extends StatelessWidget {
  final List<String> typeList;
  final BookRecord record;

  const RecordView({required this.record, required this.typeList, super.key});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController(text: record.name);
    final price = TextEditingController(text: record.price.toString());
    num type = record.typeId;
    final isIn = TextEditingController(text: record.isIn.toString());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const Text("账本记录", style: TextStyle(fontSize: 20)),
          TextRow(title: "记录名 : ", controller: name),
          TextRow(title: "金额 : ", controller: price, isNum: true),
          TypeRow(
            defaultValue: type,
            title: "类型 : ",
            items: typeList,
            onChanged: (value) => type = value,
          ),
          TextRow(
            title: "是否为收入 : ",
            readOnly: true,
            controller: isIn,
            onTap: () => {isIn.text = (isIn.text == "false").toString()},
          ),
          TextRow(
              title: "创建时间 : ",
              readOnly: true,
              controller:
                  TextEditingController(text: record.createTime.toString())),
          TextRow(
              title: "更新时间 : ",
              readOnly: true,
              controller:
                  TextEditingController(text: record.updateTime.toString())),
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => {
                  Api.deleteRecord(record.id),
                  Navigator.pop(context),
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text("删除"),
                ),
              ),
              ElevatedButton(
                onPressed: () => {
                  Api.updateRecord(
                    record.id,
                    name.text,
                    type,
                    num.parse(price.text),
                    bool.parse(isIn.text),
                  ),
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

class RecordAddView extends StatelessWidget {
  final List<String> typeList;
  final num bookId;

  const RecordAddView({
    required this.bookId,
    required this.typeList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final price = TextEditingController();
    num type = 0;
    final isIn = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const Text("账本记录", style: TextStyle(fontSize: 20)),
          TextRow(title: "记录名 : ", controller: name),
          TextRow(title: "金额 : ", controller: price, isNum: true),
          TypeRow(
            defaultValue: 0,
            title: "类型 : ",
            items: typeList,
            onChanged: (value) => type = value,
          ),
          TextRow(
            title: "是否为收入 : ",
            readOnly: true,
            controller: isIn,
            onTap: () => {isIn.text = (isIn.text == "false").toString()},
          ),
          const Expanded(child: SizedBox()),
          ElevatedButton(
            onPressed: () => {
              Api.addRecord(
                bookId,
                name.text,
                type,
                num.parse(price.text),
                bool.parse(isIn.text),
              ),
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
