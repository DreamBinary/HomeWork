import 'dart:math';

import 'package:banker_visualization/process.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'banker_algorithm.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var isInput = true;
  List<Process> processList = [];
  List<int> availableList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isInput
            ? InputPage(onChangePage: (processList, availableList) {
                setState(() {
                  isInput = !isInput;
                  this.processList = processList;
                  this.availableList = availableList;
                });
              })
            : HomePage(
                processList: processList,
                available: availableList,
                onChangePage: () {
                  setState(() {
                    isInput = !isInput;
                  });
                }),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final List<Process> processList;
  final List<int> available;
  final Function onChangePage;

  const HomePage({
    required this.processList,
    required this.available,
    required this.onChangePage,
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late List<Process> processList = List.from(widget.processList);

  late List<int> indexList =
      List.generate(processList.length, (index) => index);

  late List<int> available = List.from(widget.available);

  late final _ctrlList = List.generate(
    processList.length,
    (index) => AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    ),
  );
  late final _scaleCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  final Tween<double> _tween = Tween(begin: 1, end: 1.2);

  @override
  void initState() {
    super.initState();
    _scaleCtrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scaleCtrl.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Expanded(
                flex: processList.length,
                child: AllProcess(
                  processList: processList,
                  ctrlList: _ctrlList,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                flex: 1,
                child: ScaleTransition(
                  scale: _tween.animate(
                    CurvedAnimation(
                      parent: _scaleCtrl,
                      curve: Curves.easeOutSine,
                      reverseCurve: Curves.elasticIn,
                    ),
                  ),
                  child: AvailableBlock(available: available),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              widget.onChangePage();
            },
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
              child: const Icon(Icons.next_plan_outlined),
            ),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            onPressed: () {
              setState(
                () {
                  for (var i = 0; i < indexList.length; i++) {
                    processList[i].lastIndex = indexList.indexOf(i);
                  }
                  if (bankerAlgorithmOneStep(
                      processList, available, indexList)) {
                    for (var i = 0; i < indexList.length; i++) {
                      processList[i].index = indexList.indexOf(i);
                    }
                    for (var ctr in _ctrlList) {
                      ctr.forward(from: 0);
                    }
                  } else {
                    _scaleCtrl.forward();
                  }
                },
              );
            },
            child: const Icon(Icons.next_plan_outlined),
          )
        ],
      ),
    );
  }
}

class AvailableBlock extends StatelessWidget {
  final List<int> available;

  const AvailableBlock({required this.available, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.constrainWidth() * 0.6;
        return SizedBox(
          width: width,
          child: ProcessBlock(
            process: Process(
              id: -1,
              max: available,
              allocation: available,
              need: List.generate(available.length, (index) => 0),
            ),
            color: Colors.pinkAccent[100]!,
          ),
        );
      },
    );
  }
}

class AllProcess extends StatefulWidget {
  final List<Process> processList;
  final List<AnimationController> ctrlList;

  const AllProcess({
    required this.processList,
    required this.ctrlList,
    super.key,
  });

  @override
  State<AllProcess> createState() => _AllProcessState();
}

class _AllProcessState extends State<AllProcess> {
  @override
  Widget build(BuildContext context) {
    var processList = widget.processList;
    var ctrlList = widget.ctrlList;
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.constrainHeight() / processList.length;
        return Stack(
          alignment: Alignment.topCenter,
          children: List.generate(
            processList.length,
            (index) {
              var process = processList[index];
              return AnimatedBuilder(
                animation: ctrlList[index],
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      0,
                      process.lastIndex * height +
                          (process.index - process.lastIndex) *
                              height *
                              ctrlList[index].value,
                    ),
                    child: child,
                  );
                },
                child: SizedBox(
                  width: constraints.constrainWidth() * 0.6,
                  height: height,
                  child: ProcessBlock(
                    process: process,
                    color: Colors.primaries[index],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class ProcessBlock extends StatefulWidget {
  final Process process;
  final Color color;

  const ProcessBlock({required this.process, required this.color, super.key});

  @override
  State<ProcessBlock> createState() => _ProcessBlockState();
}

class _ProcessBlockState extends State<ProcessBlock> {
  @override
  Widget build(BuildContext context) {
    final length = widget.process.max.length;
    return Container(
      margin: const EdgeInsets.all(5),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                widget.process.id >= 0 ? "P ${widget.process.id}" : " A ",
              ),
            ),
          ),
          ...List.generate(
            length,
            (index) => Expanded(
              flex: 10,
              child: ResourceBlock(
                allocation: widget.process.allocation[index],
                need: widget.process.need[index],
                color: widget.color,
                finish: widget.process.finish,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResourceBlock extends StatelessWidget {
  final num allocation;
  final num need;
  final Color color;
  final bool finish;

  const ResourceBlock({
    required this.allocation,
    required this.need,
    required this.color,
    this.finish = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color),
      ),
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.centerLeft,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              if (allocation != 0)
                Expanded(
                  flex: allocation as int,
                  child: Container(
                    height: double.infinity,
                    margin: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: color,
                      border: Border.all(color: Colors.white),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '$allocation',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              if (need != 0)
                Expanded(
                  flex: need as int,
                  child: Container(
                    height: double.infinity,
                    margin: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: finish ? color.withAlpha(100) : Colors.white,
                      border: Border.all(color: Colors.white),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '$need',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class InputPage extends StatefulWidget {
  final Function(List<Process>, List<int>) onChangePage;

  const InputPage({required this.onChangePage, super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  List<List<TextEditingController>> _needCtrlList = [[]];
  List<List<TextEditingController>> _allocateCtrlList = [[]];
  List<List<TextEditingController>> _availableCtrlList = [[]];

  @override
  void initState() {
    super.initState();
    init(5, 3);
  }

  init(int p, int r) {
    _needCtrlList = List.generate(
      p,
      (index) => List.generate(
        r,
        (index) => TextEditingController(
          text: (Random().nextInt(9) + 1).toString(),
        ),
      ),
    );
    _allocateCtrlList = List.generate(
      p,
      (index) => List.generate(
        r,
        (index) => TextEditingController(
          text: (Random().nextInt(9) + 1).toString(),
        ),
      ),
    );
    _availableCtrlList = List.generate(
      1,
      (index) => List.generate(
        r,
        (index) => TextEditingController(
          text: (Random().nextInt(9) + 1).toString(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.constrainWidth();
            return SizedBox(
              width: width * 0.7,
              child: Column(
                children: [
                  PRRow(
                    onConfirm: (p, r) {
                      setState(
                        () {
                          init(p, r);
                        },
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("分配矩阵"),
                  ),
                  InputMatrix(ctrList: _allocateCtrlList),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("需求矩阵"),
                  ),
                  InputMatrix(ctrList: _needCtrlList),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("可用资源"),
                  ),
                  InputMatrix(ctrList: _availableCtrlList),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final l = _allocateCtrlList.length;
          final allocateList = List.generate(
            l,
            (i) => List.generate(
              _allocateCtrlList[i].length,
              (j) => int.parse(_allocateCtrlList[i][j].text),
            ),
          );
          final needList = List.generate(
            l,
            (i) => List.generate(
              _needCtrlList[i].length,
              (j) => int.parse(_needCtrlList[i][j].text),
            ),
          );
          final maxList = List.generate(
            l,
            (i) => List.generate(
              _needCtrlList[i].length,
              (j) => allocateList[i][j] + needList[i][j],
            ),
          );
          List<Process> processList = List.generate(
            l,
            (index) => Process(
              id: index,
              max: maxList[index],
              allocation: allocateList[index],
              need: needList[index],
              lastIndex: index,
              index: index,
            ),
          );
          List<int> availableList = List.generate(
            _availableCtrlList[0].length,
            (index) => int.parse(_availableCtrlList[0][index].text),
          );
          widget.onChangePage(processList, availableList);
        },
        child: const Icon(Icons.next_plan_outlined),
      ),
    );
  }
}

class InputMatrix extends StatelessWidget {
  final List<List<TextEditingController>> ctrList;

  const InputMatrix({required this.ctrList, super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.pink[100]!),
      children: List.generate(
        ctrList.length,
        (p) => TableRow(
          children: List.generate(
            ctrList[p].length,
            (r) => Center(
              child: TextField(
                controller: ctrList[p][r],
                textAlign: TextAlign.center,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PRRow extends StatefulWidget {
  final Function(int, int) onConfirm;

  const PRRow({required this.onConfirm, super.key});

  @override
  State<PRRow> createState() => _PRRowState();
}

class _PRRowState extends State<PRRow> {
  final _pCtrl = TextEditingController();

  final _rCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Text('number of process: '),
          Expanded(
            child: TextField(
              controller: _pCtrl,
              textAlign: TextAlign.center,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          const SizedBox(width: 20),
          const Text('number of resource: '),
          Expanded(
            child: TextField(
              controller: _rCtrl,
              textAlign: TextAlign.center,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly], // num
            ),
          ),
          ElevatedButton(
            onPressed: () {
              widget.onConfirm(int.parse(_pCtrl.text), int.parse(_rCtrl.text));
            },
            child: const Text("init"),
          ),
        ],
      ),
    );
  }
}
