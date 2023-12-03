import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextRow extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final bool readOnly;
  final bool isNum;
  final GestureTapCallback? onTap;

  const TextRow({
    required this.title,
    this.readOnly = false,
    this.isNum = false,
    this.controller,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          const Expanded(child: SizedBox()),
          Expanded(
            flex: 2,
            child: Text(title,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 16)),
          ),
          Expanded(
            flex: 4,
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              onTap: onTap,
              inputFormatters:
                  isNum ? [FilteringTextInputFormatter.digitsOnly] : null,
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
