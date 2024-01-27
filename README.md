# fast_app_base

A new Flutter project.
([ttoss app repo](https://github.com/fastcampus-flutter/part3_chapter2_ttoss))

<br>

## 필기 내용

### 파일 네이밍 규칙(추천 가이드)

- Widget: 위젯
  - w_{name}.dart
- Screen: 전체 디바이스를 덮는 화면
  - s_{name}.dart
- Fragment: Screen 내부에서 일부로 존재하는 큰 화면 Widget
  - f_{name}.dart
- Dialog: Dialog or Bottom Sheet
  - d_{name}.dart
- Value Object: UI에서 사용하는 객체
  - vo_{name}.dart
- DTO: 통신이나 데이터 저장에 사용되는 객체
  - dto_{name}.dart
- 나머지
  - 소문자, 숫자, _(언더바) 조합으로 네이밍

### FlutterNativeSplash

앱 처음 실행시 로그인 인증 과정을 거쳐야 하는 경우 splash 화면에서 진행하는 경우가 대부분  
`s_splash.dart` 파일을 따로 구성후 app.dart 진입 처음에 SplashScreen 위젯을 적용해서  
인증 끝날 때 다음 화면으로 넘기게끔 할 수 있으나 중간에 native splash 화면에서 넘어갈 때 깜빡이는 현상 발생

```dart
void main() async {
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bindings);
  
  //...
}

// s_main.dart
@override
FutureOr<void> afterFirstLayout(BuildContext context) {
  delay(
    () => FlutterNativeSplash.remove(),
    1500.ms,
  );
}
```
splash 화면을 preserve 한 후 메인 스크린에서 remove 처리함으로써 자연스럽게 넘길 수 있음

## 알림 화면 구성

```dart
return Scaffold(
  body: CustomScrollView(
    slivers: [],
  ),
)
```
stack 이라면 가장 위에 있는 영역이 가장 아래에 깔리는  
slivers는 반대라고 생각하면 됨  
밖에 Scaffold로 감싸줘야 함

`DialogWidget` 은 직접 개발하신 내용

```yaml
timeago: ^3.6.0
```
`timeago`라는 library (입력받은 time이 현재 기준 몇 분, 시간 전인지 언어별로 알려주는 라이브러리)
```dart
import 'package:timeago/timeago.dart' as timeago;

void main() {
  //...
  timeago.setLocaleMessages('ko', timeago.KoMessages());
}

// w_notification_item.dart
timeago.format(widget.notification.time,locale: context.locale.languageCode).text
```
bootstrap main 함수에서 설정할 언어를 적용해준다.


그리고 보통 List 안에 반복되는 위젯에 대해서는 class 이름에 Item을 포함한다. 