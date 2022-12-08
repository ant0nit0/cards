// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Used to simplify the conversion between card color store as int <br/>
/// and the color used in the app.
class MyColor {
  static const defaultValue = 0;
  int r;
  int g;
  int b;

  MyColor({
    this.r = defaultValue,
    this.g = defaultValue,
    this.b = defaultValue,
  });

  /// Static method to convert an [int] to a [Color]
  static Color intToColor(int color) {
    return Color(color);
  }

  /// Constructor with a [Color] as parameter
  MyColor.fromColor(Color color)
      : r = color.red,
        g = color.green,
        b = color.blue;

  /// Constructor with an [int] as parameter
  MyColor.fromInt(int color)
      : r = (color >> 16) & 0xFF,
        g = (color >> 8) & 0xFF,
        b = color & 0xFF;

  /// Static method to generate a random color
  static Color random() {
    return Color.fromARGB(
      255,
      math.Random().nextInt(255),
      math.Random().nextInt(255),
      math.Random().nextInt(255),
    );
  }

  /// Static method to generate an array of 5 random colors
  static List<Color> random5Colors() {
    return List.generate(5, (index) => random());
  }

  /// Determine if a color is dark or light
  static bool isDark({MyColor? color}) {
    color = color ?? MyColor();
    return (color.r * 0.299 + color.g * 0.587 + color.b * 0.114) / 255 < 0.5;
  }

  /// Return the [Color] black if the color is light <br/>
  /// Return the [Color] white if the color is dark
  /// By default, return the [Color] black
  static Color getTextColor({MyColor? color}) {
    return isDark(color: color) ? Colors.white : Colors.black;
  }

  /// Convert a [Color] to a [MyColor] <br/>
  /// initalize the [r], [g] and [b] values with the [Color]'s values
  setColorfromColor(Color? color) {
    color = color ?? Colors.black;
    r = color.red;
    g = color.green;
    b = color.blue;
  }

  /// Set the value to the color from int in the form of 0xRRGGBB <br/>
  /// If [intColor] is null, the color will be set to [defaultValue] static value.
  void setColorFromInt(int? intColor) {
    if (intColor == null) {
      setColor(red: defaultValue, green: defaultValue, blue: defaultValue);
    } else {
      // Parse int to each value of r, g, b
      r = intColor >> 16 & 0xFF;
      g = intColor >> 8 & 0xFF;
      b = intColor & 0xFF;
    }
  }

  /// Set the colors passed in argument if they are not null and between 0 and 255.
  void setColor({int? red, int? green, int? blue}) {
    r = _checkColorValue(red) ? red! : r;
    g = _checkColorValue(green) ? green! : g;
    b = _checkColorValue(blue) ? blue! : b;
  }

  /// Check the color is between 0 and 255.
  bool _checkColorValue(int? color) {
    if (color == null || color < 0 || color > 255) {
      return false;
    }
    return true;
  }

  /// Convert the val of r, g and b to a Color
  Color getColor() {
    return Color.fromARGB(255, r, g, b);
  }

  /// Convert the value of a [Color] into an [int]
  int getColorAsInt(Color color) {
    return color.value;
  }

  dynamic toJson() {
    return {
      'r': r,
      'g': g,
      'b': b,
    };
  }

  @override
  String toString() {
    return "MyColor{r: $r, g: $g, b: $b}";
  }
}
