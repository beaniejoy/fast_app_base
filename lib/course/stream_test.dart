import 'dart:async';

void main() {
  /// Stream 기본 개념
  /// Future - 1번의 데이터를 가져옴(1번 받으면 끝)
  /// Stream - 여러 번의 데이터를 받을 수 있음(보내주는 주체가 계속 Stream 데이터를 보내줌)

  /// Stream 생성과 수행
  /// 1. async*
  /// 2. streamController

  /// Stream 데이터 관찰
  // countStream(4).listen((event) => print(event));
  // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].forEach((element) => print(element)); // 별 차이 없어 보임
  // final controller = StreamController<int>();
  // final stream = controller.stream;

  // stream.listen((event) {
  //   print(event);
  // });
  // addDataToTheSink(controller);

  /// Stream 데이터 변환
  /// transform 도 있는데 utf8 형식등으로 List를 String으로 변환해주는 역할(잘 안사용함)
  // countStream(4)
  //     .map((event) => '$event 초가 지났습니다.')
  //     .listen((event) => print(event));

  // Stream 데이터 관찰2 - BroadcastStream
  // final broadCastStream = countStream(4).asBroadcastStream();
  // broadCastStream.listen((event) {
  //   print(event);
  // });

  // 2초 뒤에 진행
  // Future.delayed(const Duration(seconds: 2), () {
  //   broadCastStream.listen((event) {
  //     print('방송 2초 후: $event');
  //   });
  // });

  // Stream Error Handling
  // 1. handleError, 2. onError 두 가지 방식이 존재
  countStream(5).listen((event) {
    print(event);
  }, cancelOnError: false).onError((e, trace) {
    print(e.toString());
  });
}

void addDataToTheSink(StreamController<int> controller) async {
  for (int i = 1; i <= 4; i++) {
    await sleepAsync(const Duration(seconds: 1));
    print('before add sink $i');
    controller.sink.add(i);
    print('after add sink $i');
  }
}

Stream<int> countStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    // print('before yield $i');
    if (i == 2) {
      // throw Exception('에러');
      yield* Stream.error(Exception('에러')); // cancelOnError: false와 같이 사용(예외 발생해도 계속 진행)
    } else {
      yield i;
    }
    await sleepAsync(const Duration(seconds: 1));
    // print('after yield $i');
  }
}

Future sleepAsync(Duration duration) {
  return Future.delayed(duration, () => {});
}
