import 'dart:isolate';

class SingletonClass {
  int data = 0;

  static final _instance = SingletonClass._();

  SingletonClass._();

  factory SingletonClass() {
    return _instance;
  }
}

main() {
  final obj1 = SingletonClass();
  final obj2 = SingletonClass();
  print(obj1 == obj2); // true

  Isolate.run(() {
    final isolateObj1 = SingletonClass();
    final isolateObj2 = SingletonClass();
    print(isolateObj1 == isolateObj2); // true
    print(obj1 == isolateObj1); // false
  });
}