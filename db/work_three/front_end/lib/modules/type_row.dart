import 'package:flutter/material.dart';

class TypeRow extends StatefulWidget {
  final String title;
  final num defaultValue;
  final List<String> items;
  final Function(int)? onChanged;

  const TypeRow({
    required this.title,
    required this.items,
    required this.defaultValue,
    this.onChanged,
    super.key,
  });

  @override
  State<TypeRow> createState() => _TypeRowState();
}

class _TypeRowState extends State<TypeRow> {
  late num value;

  @override
  void initState() {
    super.initState();
    value = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          const Expanded(child: SizedBox()),
          Expanded(
            flex: 2,
            child: Text(
              widget.title,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            flex: 4,
            child: DropdownButton(
              value: value,
              items: List.generate(widget.items.length, (index) => index)
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Center(child: Text(widget.items[e])),
                      ))
                  .toList(),
              onChanged: (value) {
                widget.onChanged?.call(value as int);
                setState(() {
                  this.value = value as int;
                });
              },
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
