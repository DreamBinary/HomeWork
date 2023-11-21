import 'dart:collection';

import 'package:partition_visualization/first_fit.dart';

import 'Storage.dart';

LinkedList<Storage> init(int memory) {
  final list = LinkedList<Storage>();
  list.add(Storage(-1, memory, 0, memory - 1, 0));
  // final start = [500, 1000, 2000];
  // final size = [100, 200, 300];
  // for (int i = 0; i < 3; i++) {
  //   allocate(list, start[i], size[i]);
  // }
  return list;
}

void allocate(LinkedList<Storage> list, int start, int size) {
  Storage? storage;
  for (var sto in list) {
    if (sto.status == 0 && sto.start <= start && sto.end >= start + size - 1) {
      storage = sto;
      break;
    }
  }
  if (storage == null) {
    return;
  }

  Storage newSto = Storage(-1, size, start, start + size - 1, 1);

  if (storage.end > newSto.end) {
    Storage nextSto =
        Storage(-1, storage.end - newSto.end, newSto.end + 1, storage.end, 0);
    storage.insertAfter(nextSto);
    storage.end = newSto.start - 1;
    storage.size = storage.end - storage.start + 1;
  } else {
    storage.end = newSto.start - 1;
  }
  storage.insertAfter(newSto);

  if (storage.start == newSto.start) {
    storage.unlink();
  }
}
