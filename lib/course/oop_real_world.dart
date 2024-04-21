import 'package:flutter/foundation.dart';

class Rectangular {
  double weight;
  double height;

  Rectangular(this.weight, this.height);

  // subType에서 해당 메소드를 overriding 하는 것을 방지한다.
  // LSP (리스코프 치환 법칙)
  @nonVirtual
  double getArea() {
    return weight * height;
  }
}

class Square extends Rectangular {
  Square(double side) : super(side, side);

  @override
  set height(double value) {
    super.height = value;
    super.weight = value;
  }

  @override
  set weight(double value) {
    super.weight = value;
    super.height = value;
  }
}

abstract class AbstractRectangular {
  double get height;

  double get weight;
}

class AdvancedRect extends AbstractRectangular {
  @override
  double height;
  @override
  double weight;

  AdvancedRect(this.height, this.weight);
}

class AdvanceSquare extends AbstractRectangular {
  double side;

  AdvanceSquare(this.side);

  @override
  double get height => side;

  @override
  double get weight => side;
}

main() {
  final Rectangular rectangular = getRectangular();
  rectangular.height = 20;

  // 왜 weight도 바뀌는 거지??
  print(rectangular.weight);

  // advanced
  final AbstractRectangular adRect = getAbstractRect();
  print(adRect.weight);
  print(adRect.height);

  switch (adRect) {
    case AdvancedRect(): adRect.height = 50;
    case AdvanceSquare(): adRect.side = 30;
  }
}

AbstractRectangular getAbstractRect() {
  return AdvanceSquare(20);
}

Rectangular getRectangular() {
  return Square(10);
}
