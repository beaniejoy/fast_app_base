import 'package:fast_app_base/common/util/app_keyboard_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

_useShowKeyboard(BuildContext context, FocusNode node) {
  useMemoized(() => AppKeyboardUtil.show(context, node));
}

showKeyboard(FocusNode node) {
  final context = useContext();
  _useShowKeyboard(context, node);
}