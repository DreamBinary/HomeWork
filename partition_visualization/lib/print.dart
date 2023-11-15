import 'dart:collection';
import 'package:partition_visualization/delete.dart';
import 'package:partition_visualization/init.dart';
import 'Storage.dart';
import 'first_fit.dart';

void printStorage(LinkedList<Storage> list) {
  if (list.isEmpty) {
    print("No task!");
    return;
  }
  for (var entry in list) {
    print(entry.toString());
  }
  print("Total: ${list.length}");
}

void add(LinkedList<Storage> list) {
  list.add(Storage(1, 100, 0, 99, 1));
}

void main() {
  int memory = 3000;
  var list = init(memory);
  firstFit(list, 11, 600, memory);
  deleteStorage(list, 11);
  printStorage(list);
}
