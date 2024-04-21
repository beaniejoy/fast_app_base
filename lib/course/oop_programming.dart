main() {
  /// OOP

  /// 1. 추상화 (abstraction)
  /// - Abstract Class (extends - only 1)
  final bird = Bird(0);
  bird.fly();

  /// - Abstract mixin Class (with - n*)
  /// - Abstract Interface Class (implements - n*)
}

abstract class Animal {
  int age;

  Animal(this.age);

  void eat() {
    print('기본 eat');
  }
}

class Dog extends Animal {
  Dog(super.age);

  @override
  void eat() {
    print('촵촵');
  }
}

class Bird extends Animal with CanFly, CanRun implements CanSee {
  Bird(super.age);

  @override
  void eat() {
    print('콕콕');
  }

  @override
  String get eyes => "eyes";

  @override
  int see(String eye) {
    print(eye);
    return 1;
  }
}

abstract mixin class CanFly {
  String wings = "wings";

  void fly() {
    print('훨훨');
  }
}

abstract mixin class CanRun {
  String legs = "legs";

  void run() {
    print('방방');
  }
}

// 무조건 overriding 해야 함
abstract interface class CanSee {
  String get eyes;
  // set legs(String value);

  int see(String eye);
}
