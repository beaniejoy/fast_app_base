import 'dart:async';

import 'package:fast_app_base/screen/main/tab/home/bank_accounts_dummy.dart';
import 'package:fast_app_base/screen/main/tab/home/vo/vo_bank_account.dart';

void main() async {
  // Future 기본 개념
  /// Future == 미래
  /// 시간이 걸리는 Computation 작업 또는 유저의 응답을 기다려야되는 상

  // Future 생성 및 수행
  print('Start');
  getBankAccounts().then((value) => print(value.toString()));
  final accounts = await getBankAccounts();
  print(accounts.toString());
  print('End');

  // Future Timeout
  print('Start');
  final result = await getBankAccounts()
      .timeout(const Duration(seconds: 1))
      .onError((error, stackTrace) => []);
  print(result.toString());
  print('End');

  // Future Error handling
  print('Start');
  try {
    final result = await getBankAccounts().timeout(const Duration(seconds: 1));
    print(result);
  } catch (e) {
    print(e);
  }
  print('End');
  // FutureOr
}

Future<List<BankAccount>> getBankAccounts() async {
  await sleepAsync(const Duration(seconds: 3));
  return bankAccounts;
}

Future sleepAsync(Duration duration) {
  return Future.delayed(duration, () => {});
}

abstract class DoWorkInterface {
  // async, sync 상황에 따라 둘 다 사용 가능
  FutureOr<String> doWork();
}

class SyncWork extends DoWorkInterface {
  @override
  String doWork() {
    return "";
  }
}

class AsyncWork extends DoWorkInterface {
  @override
  Future<String> doWork() async {
    return "";
  }
}