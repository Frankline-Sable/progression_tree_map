import 'dart:core';

extension DoubleExtensions on double {
  double clampRange({required double min, required double max}) {
    final decimalPercentage = this / 100;
    final x = (decimalPercentage * (max - min)) + min;
    return x;
  }
}
