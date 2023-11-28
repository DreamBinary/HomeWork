import 'package:db_show/entity/book.dart';
import 'package:db_show/modules/list_show.dart';
import 'package:db_show/net/api.dart';
import 'package:flutter/material.dart';

import 'book_view.dart';
import 'item.dart';
import 'mydialog.dart';

class BookCol extends StatelessWidget {
  final String username;
  final Function(num, String) onTapBook;
  final Function onRefresh;

  const BookCol(
      {required this.username,
      required this.onTapBook,
      required this.onRefresh,
      super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Api.getBook(username),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            List<Book>? selfBook = data?["self"];
            List<Book>? multiBook = data?["multi"];
            return Column(
              children: [
                Expanded(
                  child: ListContainer(
                    title: "创建账本",
                    onTapAdd: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => MyDialog(
                          child: BookAddView(author: username),
                        ),
                      );
                      onRefresh();
                    },
                    children: List.generate(
                      selfBook!.length,
                      (index) => Item(
                        title: selfBook[index].name,
                        onLongPress: () => {
                          onTapBook(selfBook[index].id, selfBook[index].name),
                        },
                        onTap: () async => {
                          await showDialog(
                            context: context,
                            builder: (context) => MyDialog(
                              child: BookView(
                                book: selfBook[index],
                              ),
                            ),
                          ),
                          onRefresh(),
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListContainer(
                    title: "多人账本",
                    onTapAdd: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => MyDialog(
                          child: MultiBookAddView(author: username),
                        ),
                      );
                      onRefresh();
                    },
                    children: List.generate(
                      multiBook!.length,
                      (index) => Item(
                        title: multiBook[index].name,
                        onLongPress: () => {
                          onTapBook(multiBook[index].id, multiBook[index].name),
                        },
                        onTap: () async => {
                          await showDialog(
                            context: context,
                            builder: (context) => MyDialog(
                              child: BookView(
                                book: multiBook[index],
                              ),
                            ),
                          ),
                          onRefresh(),
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
