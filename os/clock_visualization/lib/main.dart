import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int blockNum = 3;
  int askNum = 10;
  late List<int> block;
  late List<int> ask;
  late List<int> vis;
  late List<Color> colors;
  late double sweepAngle;
  late double angle;
  int askIdx = 0;
  int idx = 0;
  double rotateAngle = 0.0;
  int processIdx = 0;
  int processStep = 0; // 0->findPage() 1->findEmptyBlock() 2->while(true)
  List<String> processText = ["查找是否存在页", "查找是否有空白块", "查找替换"];
  bool finish = false;
  double size = 200;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    init();
  }

  init() {
    block = List.filled(blockNum, 0);
    vis = List.filled(blockNum, 0);
    ask = List.filled(askNum, 0);
    for (int i = 0; i < askNum; i++) {
      ask[i] = Random().nextInt(9) + 1;
    }
    colors = List.generate(
      blockNum,
      (index) => Colors.primaries[Random().nextInt(Colors.primaries.length)],
    );
    sweepAngle = 360 / blockNum;
    angle = sweepAngle / 2 * pi / 180.0;
  }

  void changePoint(int i) {
    final finalAngle =
        sweepAngle * i * pi / 180.0 + sweepAngle / 2 * pi / 180.0;
    angle = angle + rotateAngle;
    rotateAngle = (finalAngle - angle + 2 * pi) % (2 * pi);
    _controller.reset();
    _controller.forward(from: 0.0);
  }

  bool findPage(int i) {
    changePoint(i);
    if (block[i] == ask[askIdx]) {
      vis[i] = 1;
      return true;
    }
    return false;
  }

  bool findEmptyBlock(int i) {
    changePoint(i);
    if (block[i] == 0) {
      block[i] = ask[askIdx];
      vis[i] = 1;
      return true;
    }
    return false;
  }

  bool findReplace() {
    changePoint(idx);
    if (vis[idx] == 1) {
      vis[idx] = 0;
      idx = (idx + 1) % blockNum;
    } else {
      block[idx] = ask[askIdx];
      vis[idx] = 1;
      idx = (idx + 1) % blockNum;
      return true;
    }
    return false;
  }

  void process() {
    if (finish) {
      changePoint(idx);
      finish = false;
      processIdx = 0;
      processStep = 0;
      askIdx = (askIdx + 1) % askNum;
    } else {
      switch (processStep) {
        case 0:
          if (findPage(processIdx)) {
            finish = true;
          } else if (processIdx == blockNum - 1) {
            processStep = 1;
            processIdx = 0;
          } else {
            processIdx++;
          }
          break;
        case 1:
          if (findEmptyBlock(processIdx)) {
            finish = true;
          } else if (processIdx == blockNum - 1) {
            processStep = 2;
            processIdx = 0;
          } else {
            processIdx++;
          }
          break;
        case 2:
          if (findReplace()) {
            finish = true;
          }
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          ClockCircle(
            radius: size,
            block: block,
            visBit: vis,
            colors: colors,
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: angle + rotateAngle * _controller.value,
                child: child,
              );
            },
            child: const Icon(Icons.arrow_forward, size: 50.0),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Text("请求序列: $ask"),
                Text("当前请求页号: ${ask[askIdx]}"),
                Text("下一步骤: ${processText[processStep]}"),
                Text("是否完成: ${finish ? '是' : '否'}")
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              width: size * 2,
              child: SettingPart(
                onConfirm: (blockNum, askNum) {
                  this.blockNum = blockNum;
                  this.askNum = askNum;
                  init();
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          process();
          setState(() {});
        },
        child: const Icon(Icons.circle_outlined),
      ),
    );
  }
}

class SettingPart extends StatefulWidget {
  final Function(int, int) onConfirm;

  const SettingPart({required this.onConfirm, super.key});

  @override
  State<SettingPart> createState() => _SettingPartState();
}

class _SettingPartState extends State<SettingPart> {
  final TextEditingController blockCtrl = TextEditingController();
  final TextEditingController askCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("块数: "),
        Expanded(
          child: TextField(
            controller: blockCtrl,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 20.0),
        const Text("请求次数: "),
        Expanded(
          child: TextField(
            controller: askCtrl,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 20.0),
        ElevatedButton(
          onPressed: () {
            widget.onConfirm(
              int.parse(blockCtrl.text),
              int.parse(askCtrl.text),
            );
          },
          child: const Text("confirm"),
        ),
      ],
    );
  }
}

class ClockCircle extends StatelessWidget {
  final double radius;
  final List<int> block;
  final List<int> visBit;
  final List<Color> colors;

  const ClockCircle({
    required this.radius,
    required this.block,
    required this.visBit,
    required this.colors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double sweepAngle = 360 / block.length;
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: Colors.orange[100],
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ...List.generate(
            block.length,
            (index) => CustomPaint(
              painter: SectorPainter(
                radius: radius,
                startAngle: index * sweepAngle,
                sweepAngle: sweepAngle,
                bgColor: colors[index],
                text: "page: ${block[index]}\nvis: ${visBit[index]}",
              ),
            ),
          ),
          Container(
            height: radius,
            width: radius,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

class SectorPainter extends CustomPainter {
  final double radius;
  final double startAngle;
  final double sweepAngle;
  final String text;
  final Color bgColor;

  SectorPainter({
    required this.radius,
    required this.startAngle,
    required this.sweepAngle,
    required this.bgColor,
    this.text = '',
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(color: Colors.black, fontSize: 20.0),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double textX = centerX -
        textPainter.width / 2 +
        radius / 1.5 * cos((startAngle + sweepAngle / 2) * pi / 180.0);
    final double textY = centerY -
        textPainter.height / 2 +
        radius / 1.5 * sin((startAngle + sweepAngle / 2) * pi / 180.0);
    final double startAngleRad = startAngle * pi / 180.0;
    final double sweepAngleRad = sweepAngle * pi / 180.0;

    final Rect rect =
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius);

    canvas.drawArc(rect, startAngleRad, sweepAngleRad, true, fillPaint);
    canvas.drawArc(rect, startAngleRad, sweepAngleRad, true, borderPaint);
    textPainter.paint(canvas, Offset(textX, textY));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
