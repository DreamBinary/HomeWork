import 'dart:collection';

import 'Storage.dart';

// free memory of visitBit task
bool deleteStorage(LinkedList<Storage> list, int id) {

  Storage? sto;
  for (var l in list) {
    if (l.id == id) {
      sto = l;
      break;
    }
  }
  if (sto == null) {
    return false;
  }

  sto.id = -1;
  sto.status = 0;

  // merge with the next block

  if (sto.next != null && sto.next!.status == 0) {
    sto.size += sto.next!.size;
    sto.end = sto.next!.end;
    sto.next!.unlink();
  }

  // merge with the previous block
  if (sto.previous != null && sto.previous!.status == 0) {
    sto.size += sto.previous!.size;
    sto.start = sto.previous!.start;
    sto.previous!.unlink();
  }
  return true;
}