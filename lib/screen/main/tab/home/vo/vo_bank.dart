import 'package:freezed_annotation/freezed_annotation.dart';

// toString, == operator 따로 안 만들어도 알아서 생성해준다.
@freezed
class Bank {
  final String name;
  final String logoImagePath;

  Bank(this.name, this.logoImagePath);

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) {
  //     return true;
  //   }
  //
  //   if (other.runtimeType != runtimeType) {
  //     return false;
  //   }
  //
  //   return other is Bank && other.name == name;
  // }
}
