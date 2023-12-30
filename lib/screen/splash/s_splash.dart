import 'package:after_layout/after_layout.dart';
import 'package:fast_app_base/common/cli_common.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/s_main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with AfterLayoutMixin {
  @override
  void initState() {
    // initState에는 값만 변경해야지 화면에 영향을 주는 부분에 대해서 에러가 발생할 수 있다.
    // 이 때는 with AfterLayoutMixin 사용하는 것이 좋다.

    super.initState();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    delay(
      () => Nav.clearAllAndPush(const MainScreen()),
      1500.ms,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/image/splash/splash.png",
        width: 192,
        height: 192,
      ),
    );
  }
}
