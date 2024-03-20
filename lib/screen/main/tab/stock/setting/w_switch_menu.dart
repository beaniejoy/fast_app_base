import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/tab/stock/setting/w_os_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchMenu extends StatelessWidget {
  final String text;
  final bool isOn;
  final ValueChanged<bool> onTap;

  const SwitchMenu(this.text, this.isOn, {super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        text.text.make(),
        emptyExpanded,
        OsSwitch(value: isOn, onTap: onTap), // ios design
      ],
    ).p20();
  }
}
