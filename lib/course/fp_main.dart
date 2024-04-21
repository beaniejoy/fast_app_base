import 'package:fast_app_base/common/cli_common.dart';
import 'package:fast_app_base/screen/main/tab/home/bank_accounts_dummy.dart';
import 'package:fast_app_base/screen/main/tab/home/vo/vo_bank_account.dart';

void main() async {
  // 절차적 프로그래밍 (명령형 프로그래밍)
  // final accounts = getAccounts();
  // final list = <String>[];
  // for (final account in accounts) {
  //   final user = getUser(account.userId);
  //   list.add(user.name);
  // }
  // print(list);

  // 함수형 프로그래밍 (선언형 프로그래밍)
  // final nameList = getAccounts()
  //     .map((account) => account.userId)
  //     .map((userId) => getUser(userId))
  //     .map((user) => user.name)
  //     .toList();

  // final nameList = await (await getAccounts())
  //     .toStream()
  //     .map((accou nt) => account.userId)
  //     .asyncMap((userId) => getUser(userId))
  //     .map((user) => user.name)
  //     .toList();
}

Future<List<BankAccount>> getAccounts() async {
  await sleepAsync(const Duration(seconds: 3));
  return bankAccounts;
}
