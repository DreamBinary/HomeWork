import 'dart:math';

import 'package:banker_visualization/process.dart';

// banker algorithm one step

bool compare(List<num> a, List<num> b) {
  for (int i = 0; i < a.length; i++) {
    if (a[i] > b[i]) return false;
  }
  return true;
}

bool bankerAlgorithmOneStep(
    List<Process> processes, List<int> available, List<int> indexList) {
  for (int i in indexList) {
    if (processes[i].finish) continue;
    if (compare(processes[i].need, available)) {
      for (int j = 0; j < available.length; j++) {
        available[j] += processes[i].allocation[j];
      }
      available = available;
      processes[i].finish = true;
      indexList.remove(i);
      indexList.add(i);
      print(available);
      return true;
    }
  }
  return false;
}
