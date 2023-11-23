import 'package:db_show/modules/list_show.dart';
import 'package:db_show/modules/record_view.dart';
import 'package:db_show/net/api.dart';
import 'package:flutter/material.dart';

import '../entity/book_record.dart';
import 'item.dart';
import 'mydialog.dart';

class RecordCol extends StatelessWidget {
  final num bookId;
  final String bookName;
  final Function onRefresh;

  const RecordCol({
    required this.bookId,
    required this.bookName,
    required this.onRefresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Api.getRecord(bookId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<BookRecord> data = snapshot.data!;
          return ListContainer(
            title: "($bookName)的账单记录",
            onTapAdd: () async {
              await showDialog(
                context: context,
                builder: (context) => MyDialog(
                  child: RecordAddView(bookId: bookId),
                ),
              );
              onRefresh();
            },
            children: List.generate(
              data.length,
              (index) => Item(
                title:
                    "${data[index].name}${data[index].isIn ? '  +' : '  -'}${data[index].price}",
                onTap: () async => {
                  await showDialog(
                    context: context,
                    builder: (context) => MyDialog(
                      child: RecordView(
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
