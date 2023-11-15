import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:partition_visualization/best_fit.dart';
import 'package:partition_visualization/first_fit.dart';
import 'package:partition_visualization/init.dart';
import 'package:partition_visualization/worst_fit.dart';

import 'Storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Partition Visualization'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int memory = 3000;
  double height = 150;
  double width = 900;
  late LinkedList<Storage> list = init(memory);
  int selected = 0;

  final TextEditingController idCtrl = TextEditingController();
  final TextEditingController sizeCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            const Expanded(child: SizedBox()),
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
                color: Colors.white38,
              ),
              child: Stack(
                children: List.generate(
                  list.length,
                  (index) => Block(
                      storage: list.elementAt(index), scale: width / memory),
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            SizedBox(
              width: width,
              child: InputPart(
                idCtrl: idCtrl,
                sizeCtrl: sizeCtrl,
                onChanged: (val) {
                  selected = val!;
                },
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int id = int.parse(idCtrl.text);
          int size = int.parse(sizeCtrl.text);
          if (selected == 0) {
            firstFit(list, id, size, memory);
          } else if (selected == 1) {
            bestFit(list, id, size, memory);
          } else if (selected == 2) {
            worstFit(list, id, size, memory);
          }
          setState(() {});
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Block extends StatefulWidget {
  final double scale;
  final Storage storage;

  const Block({required this.storage, this.scale = 1.0, super.key});

  @override
  State<Block> createState() => _BlockState();
}

class _BlockState extends State<Block> {
  @override
  Widget build(BuildContext context) {
    var start = widget.storage.start * widget.scale;
    var end = widget.storage.end * widget.scale;
    var width = (end - start).floorToDouble();
    return Container(
      margin: EdgeInsets.only(left: start),
      width: width,
      color: widget.storage.status == 0
          ? Colors.white
          : (widget.storage.id == -1
              ? Theme.of(context).colorScheme.primary
              : Color((Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(0.5)),
      alignment: Alignment.center,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: width / 2,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  widget.storage.size.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              widget.storage.start.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InputPart extends StatefulWidget {
  final TextEditingController? idCtrl;
  final TextEditingController? sizeCtrl;
  final ValueChanged<int?>? onChanged;

  const InputPart({this.idCtrl, this.sizeCtrl, this.onChanged, super.key});

  @override
  State<InputPart> createState() => _InputPartState();
}

class _InputPartState extends State<InputPart> {
  var groupValue = 0;

  @override
  Widget build(BuildContext context) {
    List<String> method = ["first_fit", "best_fit", "worst_fit"];
    return Column(
      children: [
        Row(
          children: List.generate(
            3,
            (index) => Expanded(
              child: RadioListTile<int>(
                value: index,
                groupValue: groupValue,
                title: Text(method[index]),
                onChanged: (val) {
                  setState(() {
                    groupValue = val!;
                    widget.onChanged!(val);
                  });
                },
              ),
            ),
          ),
        ),
        Row(
          children: [
            const Text("id : ", style: TextStyle(fontSize: 20)),
            Expanded(
              child: TextField(
                controller: widget.idCtrl,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            const SizedBox(width: 10),
            const Text("size : ", style: TextStyle(fontSize: 20)),
            Expanded(
              child: TextField(
                controller: widget.sizeCtrl,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
          ],
        )
      ],
    );
  }
}
