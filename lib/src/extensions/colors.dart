import 'dart:core';
import 'nums.dart';
import 'package:flutter/material.dart';

extension HexColor on Color {
// Tint or shade the color depending on the 'darken' flag
  Color tintOrShade(double value, {bool darken = true}) {
    // Convert the color to HSL format
    final HSLColor hsl = HSLColor.fromColor(this);

    // Calculate the lightness value for tint or shade
    double lightness = hsl.lightness +
        (darken ? -1 : 1) * value.clampRange(min: 0.0, max: 1.0);
    lightness = lightness.clamp(0.0, 1.0);

    // Return the tinted or shaded color in RGB format
    return hsl.withLightness(lightness).toColor();
  }
}
