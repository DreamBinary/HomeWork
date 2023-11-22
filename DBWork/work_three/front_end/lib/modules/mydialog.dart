import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  final Widget? child;

  const MyDialog({this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var width = constraints.constrainWidth();
        var height = constraints.constrainHeight();
        return Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: width * 0.25,
            vertical: height * 0.15,
          ),
          child: child,
        );
      },
    );
  }
}
