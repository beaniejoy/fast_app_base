import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/context_extension.dart';
import 'package:fast_app_base/common/widget/w_height_and_width.dart';
import 'package:fast_app_base/screen/notification/s_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TtossAppBar extends StatefulWidget {
  static const double appBarHeight = 60;

  const TtossAppBar({super.key});

  @override
  State<TtossAppBar> createState() => _TtossAppBarState();
}

class _TtossAppBarState extends State<TtossAppBar> {
  bool _showRedDot = false;
  int _tappingCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: TtossAppBar.appBarHeight,
      color: context.appColors.appBarBackground,
      child: Row(
        children: [
          width10,
          AnimatedContainer(
            duration: 1000.ms,
            curve: Curves.easeIn,
            height: _tappingCount > 2 ? 60 : 30, // 여러 속성들이 있는데 시작점과 끝지점을 정하면 알아서 애니메이션 처리
            child: Image.asset(
              "$basePath/icon/toss.png",
              // height: 30, // 앞에 컨테이너로 감싸져있으면 내부 이미지 height가 먹히지 않는다.
            ),
          ),
          // AnimatedCrossFade를 통해 두 개의 위젯을 대상으로 변화하는 애니메이션도 가능
          // AnimatedCrossFade(
          //   firstChild: firstChild,
          //   secondChild: secondChild,
          //   crossFadeState: crossFadeState,
          //   duration: duration,
          // ),
          emptyExpanded,
          Tap(
            onTap: () => setState(() {
              _tappingCount++;
            }),
            child: Image.asset(
              "$basePath/icon/map_point.png",
              height: 30,
            ),
          ),
          width10,
          Tap(
            onTap: () {
              Nav.push(const NotificationScreen());
            },
            child: Stack(
              children: [
                Image.asset(
                  "$basePath/icon/notification.png",
                  height: 30,
                ),
                if (_showRedDot)
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  )
              ],
            )
                .animate(onPlay: (controller) => controller.repeat())
                .shake(duration: 2000.ms, hz: 3)
                .then()
                .fadeOut(duration: 1000.ms),
          ),
          width10
        ],
      ),
    );
  }
}
