import 'package:db_show/color.dart';
import 'package:db_show/modules/item.dart';
import 'package:flutter/material.dart';

class ListContainer extends StatefulWidget {
  final List<Widget> children;
  final String title;
  final GestureTapCallback? onTapAdd;

  const ListContainer(
      {required this.title,
      this.children = const <Widget>[],
      this.onTapAdd,
      super.key});

  @override
  State<ListContainer> createState() => _ListContainerState();
}

class _ListContainerState extends State<ListContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 10,
        color: MyColor.bgColor,
        shadowColor: MyColor.bgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: MyColor.bgDeepColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Item(
                  title: widget.title,
                  trailing: const Icon(Icons.add, color: Colors.white70),
                  onTap: widget.onTapAdd),
            ),
            Expanded(
              child: ListView(
                children: widget.children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
