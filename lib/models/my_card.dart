import 'package:app_papa_v2/models/my_color.dart';
import 'package:flutter/material.dart';

final String tableCards = 'cards';

class CardFields {
  static final List<String> values = [
    id,
    title,
    logoPath,
    color,
    barCode,
    isFav
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String logoPath = 'logoPath';
  static const String color = 'color';
  static const String barCode = 'barCode';
  static const String isFav = 'isFav';
}

class MyCard {
  final int? id;
  String title;
  String? logoPath;
  int? color;
  String? barCode;
  bool isFav;

  MyCard({
    required this.title,
    required this.logoPath,
    this.id,
    this.color,
    this.barCode,
    this.isFav = false,
  });

  /// Function to return the color of the card
  /// in the type of [Color]
  Color getColor() {
    if (color == null) {
      return Colors.black;
    }
    return Color(color!.toInt());
  }

  @override
  String toString() {
    return "MyCard{_id: $id, title: $title, logoPath: $logoPath, color: $color, barCode: $barCode, isFav: $isFav}";
  }

  /// Function to convert the object into a json
  /// to be stored in the database
  Map<String, Object?> toJson() => {
        CardFields.id: id,
        CardFields.title: title,
        CardFields.logoPath: logoPath,
        CardFields.color: color ?? 0x000000,
        CardFields.barCode: barCode,
        CardFields.isFav: isFav ? 1 : 0,
      };

  MyCard copy({
    int? id,
    String? title,
    String? logoPath,
    int? color,
    String? barCode,
    bool? isFav,
  }) =>
      MyCard(
        id: id ?? this.id,
        title: title ?? this.title,
        logoPath: logoPath ?? this.logoPath,
        color: color ?? this.color,
        barCode: barCode ?? this.barCode,
        isFav: isFav ?? this.isFav,
      );

  /// Function to convert the json into an object
  static MyCard fromJson(Map<String, Object?> json) => MyCard(
        id: json[CardFields.id] as int,
        title: json[CardFields.title] as String,
        logoPath: json[CardFields.logoPath] as String?,
        color: json[CardFields.color] as int?,
        barCode: json[CardFields.barCode] as String?,
        isFav: json[CardFields.isFav] == 1,
      );
}
