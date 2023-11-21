import 'dart:io';
import 'dart:math';

const int N = 1000;
List<int> block = List<int>.filled(N, 0);
List<int> ask = List<int>.filled(N, 0);
List<int> vis = List<int>.filled(N, 0);
int blockNum = 0, askNum = 0;
int idx = 0;

void init() {
  stdout.write("Please input the number of physical blocks: ");
  blockNum = int.parse(stdin.readLineSync()!);

  stdout.write("Please input the number of pages: ");
  askNum = int.parse(stdin.readLineSync()!);

  for (int i = 0; i < askNum; i++) {
    ask[i] = Random().nextInt(9) + 1; // generate random number in [1, 9]
    stdout.write('${ask[i]} ');
  }

  print('\n  Current page  |');

  for (int i = 0; i < blockNum; i++) {
    stdout.write('  block$i  visit bit  |');
  }

  print('  if page fault  |');
  print('  out page  |');
  print('  page of pointer  ');
}

void show(int i, int out, bool flag) {
  stdout.write('       ${ask[i]}        |');

  for (int j = 0; j < blockNum; j++) {
    if (block[j] == 0) {
      stdout.write('  empty              |');
    } else {
      stdout.write('    ${block[j]}         ${vis[j]}      |');
    }
  }

  if (flag) {
    stdout.write('  no page fault  |');
  } else {
    stdout.write('    page fault   |');
  }

  if (out == -1) {
    stdout.write('     --     |');
  } else {
    stdout.write('      ${ask[out]}     |');
  }

  stdout.write('    ${block[idx % blockNum]}');
  print(
      '\n----------------------------------------------------------------------------------------------------------------------------------');
}

void main() {
  init();

  for (int i = 0; i < askNum; i++) {
    int curPage = ask[i];

    bool havCurPage = false;

    for (int j = 0; j < blockNum; j++) {
      if (block[j] == curPage) {
        havCurPage = true;
        vis[j] = 1;
        break;
      }
    }

    if (havCurPage) {
      show(i, -1, true);
      continue;
    }

    bool havEmptyBlock = false;

    for (int j = 0; j < blockNum; j++) {
      if (block[j] == 0) {
        block[j] = curPage;
        vis[j] = 1;
        havEmptyBlock = true;
        break;
      }
    }

    if (havEmptyBlock) {
      show(i, -1, false);
      continue;
    }

    int outIdx = -1;

    while (true) {
      if (vis[idx] == 1) {
        vis[idx] = 0;
        idx = (idx + 1) % blockNum;
      } else {
        outIdx = idx;
        block[idx] = curPage;
        vis[idx] = 1;
        idx = (idx + 1) % blockNum;
        break;
      }
    }
    show(i, outIdx, false);
  }
}
