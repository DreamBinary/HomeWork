import 'package:db_show/entity/book_record.dart';
import 'package:db_show/modules/text_row.dart';
import 'package:db_show/net/api.dart';
import 'package:flutter/material.dart';

class RecordView extends StatelessWidget {
  final BookRecord record;

  const RecordView({required this.record, super.key});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController(text: record.name);
    final price = TextEditingController(text: record.price.toString());
    final type = TextEditingController(text: record.typeName);
    final isIn = TextEditingController(text: record.isIn.toString());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const Text("账本记录", style: TextStyle(fontSize: 20)),
          TextRow(title: "记录名 : ", controller: name),
          TextRow(title: "金额 : ", controller: price, isNum: true),
          TextRow(title: "类型 : ", controller: type),
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
                    type.text,
                    num.parse(price.text),
                    bool.parse(isIn.text),
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
