import 'package:db_show/color.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final String title;
  final ShapeBorder? shape;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final Widget? trailing;

  const Item(
      {Key? key,
      required this.title,
      this.shape,
      this.onTap,
      this.onLongPress,
      this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isTitle = trailing != null;
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(title),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
      ),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      titleAlignment: ListTileTitleAlignment.center,
      onTap: onTap,
      hoverColor: MyColor.hoverColor,
      splashColor: MyColor.splashColor,
      onLongPress: onLongPress,
    );
  }
}
