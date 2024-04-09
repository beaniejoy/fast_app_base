import 'package:fast_app_base/common/common.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveLikeButton extends StatefulWidget {
  final bool isLike;
  final void Function(bool isLike) onTapLike;

  const RiveLikeButton(this.isLike, {Key? key, required this.onTapLike}) : super(key: key);

  @override
  State<RiveLikeButton> createState() => _RiveLikeButtonState();
}

class _RiveLikeButtonState extends State<RiveLikeButton> {
  late StateMachineController controller;
  late SMIBool smiPressed;
  late SMIBool smiHover;

  // 바뀐 isLike 값에 따라 build가 다시 일어나면 바뀐 isLike 값을 감지해야하는데 아래에서 수행
  @override
  void didUpdateWidget(covariant RiveLikeButton oldWidget) {
    // vue에서 watch와 비슷해보임
    if (oldWidget.isLike != widget.isLike) {
      smiPressed.value = widget.isLike;
      smiHover.value = widget.isLike;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: () => widget.onTapLike(!widget.isLike),
      child: RiveAnimation.asset(
        '$baseRivePath/light_like.riv',
        stateMachines: const ['State Machine 1'],
        onInit: (Artboard art) {
          controller = StateMachineController.fromArtboard(art, 'State Machine 1')!;
          controller.isActive = true;
          art.addController(controller);
          smiPressed = controller.findInput<bool>('Pressed') as SMIBool;
          smiHover = controller.findInput<bool>('Hover') as SMIBool;
        },
      ),
    );
  }
}
