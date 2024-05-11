import 'package:easy_localization/easy_localization.dart';
import 'package:fast_app_base/data/memory/app_block/app_bloc_observer.dart';
import 'package:fast_app_base/data/memory/app_block/app_event_transformer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'common/data/preference/app_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await AppPreferences.init();

  // 이벤트 관찰 가능
  Bloc.observer = AppBlocObserver();
  // 이벤트 변환도 가능
  // Bloc.transformer = appEventTransformer;

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ko')],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
      useOnlyLangCode: true,
      child: const App()));
}
