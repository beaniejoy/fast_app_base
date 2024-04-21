import 'dart:io';

import 'package:fast_app_base/common/cli_common.dart';

void main() async {
  /// List, Iterable
  // final List list = ['blue', 'yellow', 'red'];
  // final iterator = list.iterator;
  // print(iterator.current);
  // while (iterator.moveNext()) {
  //   print(iterator.current);
  // }

  /// sync*로 Iterable 만들기
  for (final message in countIterable(5)) {
    print(message);
  }

  /// async*로 Iterable 만들기

  await for (final message in countStream(5)) {
    print(message);
  }
}

// Generator: Iterable, Stream 아래 두 개 함수를 일컫는 말
Iterable<String> countIterable(int max) sync* {
  for (int i = 1; i <= max; i++) {
    // sleep은 절대로 사용하지 말자
    // sleep(const Duration(seconds: 1));
    yield i.toString();
  }

  yield '안녕하세요~';

  yield* ['1', '2', '3', '4', '5'];
}

Stream<String> countStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    await sleepAsync(const Duration(seconds: 1));
    yield i.toString();
    // print('after yield $i');
  }

  yield '안녕하세요~';
  yield* countStream(max); // Stream 반환만 허용
}

Future sleepAsync(Duration duration) {
  return Future.delayed(duration, () => {});
}
