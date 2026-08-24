import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  void pushNamedAndRemoveUntil(String routeName) {
    Navigator.pushNamedAndRemoveUntil(this, routeName, (route) => false);
  }

  void maybePopN() {
    Navigator.maybePop(this);
  }

  void pushNamed(String routeName, {Object? arguments}) {
    Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  void pushReplacementNamed(String routeName) {
    Navigator.pushReplacementNamed(this, routeName);
  }

  void pop() {
    Navigator.pop(this);
  }
}

extension SizeExtension on BuildContext {
  double width(double ratio) {
    return MediaQuery.sizeOf(this).width * ratio;
  }

  double height(double ratio) {
    return MediaQuery.sizeOf(this).height * ratio;
  }
}
