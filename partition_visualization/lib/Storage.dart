import 'dart:collection';

final class Storage extends LinkedListEntry<Storage> {
  int id; // task id
  int size; // size of memory
  int start; // start address
  int end; // end address
  int status; // 0: not allocated, 1: allocated

  Storage(this.id, this.size, this.start, this.end, this.status);

  @override
  String toString() {
    return 'Storage{id: $id, size: $size, start: $start, end: $end, status: $status}';
  }
}
