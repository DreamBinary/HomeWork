// allocate memory for visitBit task with worst fit
// allocate memory for visitBit task with first fit
import 'dart:collection';

import 'package:partition_visualization/Storage.dart';

bool worstFit(LinkedList<Storage> list, int id, int size, int memory) {
  Storage? sto;
  int max = -1;
  for (var l in list) {
    if (l.status == 0 && l.size >= size && l.size > max) {
      sto = l;
      max = l.size;
    }
  }
  if (sto == null) {
    return false;
  }
  final oldSize = sto.size;
  sto.id = id;
  sto.size = size;
  sto.end = sto.start + size - 1;
  sto.status = 1;

  if (sto.end >= memory - 1) {
    return true;
  }
  final newSize = oldSize - size;
  if (newSize == 0) {
    return true;
  }
  final start = sto.end + 1;
  final end = start + newSize - 1;
  Storage newStorage = Storage(-1, newSize, start, end, 0);
  sto.insertAfter(newStorage);
  return true;
}
