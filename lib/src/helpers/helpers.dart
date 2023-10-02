abstract class MathHelpers {
  /// Author Frankline Sable
  /// Co-Author Author Bostoen Louie
  /// :Link [https://math.stackexchange.com/a/754156]
  /// Clamp range function, whereby, Given two numbers, minimum and maximum value,
  /// and find X which is between the two numbers, while given its percentage value,
  static double clampRange(
      {required double percentage, required double min, required double max}) {
    final decimalPercentage = percentage / 100;
    //finding x
    final x = (decimalPercentage * (max - min)) + min;
    return x;
  }
}
