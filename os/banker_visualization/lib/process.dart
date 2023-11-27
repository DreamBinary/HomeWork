// banker algorithm
class Process {
  int id;
  List<int> max;
  List<int> allocation;
  List<int> need;
  bool finish;
  int lastIndex;
  int index;

  Process(
      {required this.id,
      required this.max,
      required this.allocation,
      required this.need,
      this.finish = false,
      this.lastIndex = 0,
      this.index = 0});

  @override
  String toString() {
    return 'Process{id: $id, max: $max, allocation: $allocation, need: $need, finish: $finish}';
  }
}
