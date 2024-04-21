import 'package:fast_app_base/common/dart/collection/sort_functions.dart';

void main() {
  /// 람다 표현
  ///
  /// 1. 익명: 이름을 지을 수 없다. (변수에 담을 수 있음)
  /// 2. 함수: Class에 종속되지 않음
  /// 3. 전달: 1급 객체로서 함수 파라미터로 전달, 변수에 저장 가능
  /// 4. 간결성: 익명 클래스처럼 많은 코드를 구현할 필요가 없다.

  /// List Sort 예제
  final list = [5, 2, 3, 4, 1, 10];
  list.sort((a, b) => a == b
      ? 0
      : a > b
          ? 1
          : -1);
  print(list);

  final animalList = [
    Animal2(5, 'b'),
    Animal2(10, 'b'),
    Animal2(7, 'c'),
    Animal2(2, 'a'),
    Animal2(3, 'g')
  ];
  animalList.sort(byIntField<Animal2>((element) => element.age, reverse: true));
  print(animalList);

  final add = (a) => (b) => a + b;
  print(add(2)(3)); // nested lambda function 가능

  // 합성함수도 가능
  final curryMultiply = curry(multiply);

  print(curryMultiply(2));

  example(1, args: [1, 2, 3]);
}

example(a, {Iterable? args}) => print("$a $args");

curry(Function f) => (a, {Iterable? args}) => (args?.length ?? 0) > 1 ? f(a, args) : (b) => f(a, b);
final multiply = (int a, int b) => a * b;

class Animal2 {
  final int age;
  final String name;

  Animal2(this.age, this.name);

  @override
  String toString() {
    return "Animal: $name - $age";
  }
}

class Animal {
  int age = 1;

  void eat() {
    age++; // class field 값에 영향을 줄 수 있음
  } // calling 'method' (class에 종속적으로 속해있음)

  // lambda > 변수 할당 (class와 무관함)
  // class에 영향을 줄 수 없음
  final add = (int a, int b) => a + b;
}
