import 'package:fast_app_base/common/dart/extension/collection_extension.dart';
import 'package:fast_app_base/screen/main/tab/home/banks_dummy.dart';
import 'package:fast_app_base/screen/main/tab/home/vo/vo_bank_account.dart';

final bankAccountShinhan1 = BankAccount(bankShinhan, 3000000, accountTypeName: "신한 주거래 우대통장(저축예금)");
final bankAccountShinhan2 = BankAccount(bankShinhan, 3000000, accountTypeName: "신한 주거래 우대통장(저축예금)");
final bankAccountShinhan3 = BankAccount(bankShinhan, 3000000, accountTypeName: "신한 주거래 우대통장(저축예금)");
final bankAccountShinhan4 = BankAccount(bankShinhan, 3000000, accountTypeName: "신한 주거래 우대통장(저축예금)");
final bankAccountShinhan5 = BankAccount(bankShinhan, 3000000, accountTypeName: "신한 주거래 우대통장(저축예금)");
final bankAccountShinhan6 = BankAccount(bankShinhan, 3000000, accountTypeName: "신한 주거래 우대통장(저축예금)");
final bankAccountShinhan7 = BankAccount(bankShinhan, 3000000, accountTypeName: "신한 주거래 우대통장(저축예금)");
final bankAccountShinhan8 = BankAccount(bankShinhan, 30000000, accountTypeName: "저축예금");
final bankAccountShinhan9 = BankAccount(bankShinhan, 300000000, accountTypeName: "저축예금");
final bankAccountToss = BankAccount(bankTtoss, 500000000);
final bankAccountKakao = BankAccount(bankKakao, 700000000, accountTypeName: "입출금통장");
final bankAccountKakao2 = BankAccount(bankKakao, 102312341, accountTypeName: "입출금통장");

final List<BankAccount> bankAccounts = [
  bankAccountShinhan1,
  bankAccountShinhan2,
  bankAccountShinhan3,
  bankAccountShinhan4,
  bankAccountShinhan5,
  bankAccountShinhan6,
  bankAccountShinhan7,
  bankAccountShinhan8,
  bankAccountShinhan9,
  bankAccountToss,
  bankAccountKakao,
];

main() {
  bankAccounts.insert(1, bankAccountKakao2);

  bankAccounts.swap(0, 5);

  for (final account in bankAccounts) {
    print(account.toString());
  }

  // class generic
  final result = doTheWork();

  // Dog 타입으로 return 하도록 강제
  // 아래와 같이 하지 않으면 Cat으로 generic 지정해도 compile 에러 발생 X
  final result3 = doTheWork3<int, Dog>(123, () => Dog());
  result3.eat();
}

abstract class Animal {
  void eat();
}

class Cat extends Animal {
  @override
  void eat() {
    print('cat eating');
  }
}

class Dog extends Animal {
  @override
  void eat() {
    print('dog eating');
  }
}

class Result<T> {
  final T data;

  Result(this.data);
}

class ResultString {
  final String data;

  ResultString(this.data);
}

class ResultDouble {
  final double data;

  ResultDouble(this.data);
}

Result<String> doTheWork() {
  return Result("중요한 데이터");
}

Result<double> doTheWork2() {
  return Result(0.2);
}

R doTheWork3<T, R extends Animal> (T data, R Function() animalCreator) {
  return animalCreator();
}