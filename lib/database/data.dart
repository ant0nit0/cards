import 'package:app_papa_v2/models/card_suggestion.dart';
import 'package:app_papa_v2/models/my_card.dart';

abstract class Data {
  static List<MyCard> list = [
    MyCard(
      id: 1,
      title: "Auchan",
      color: 0xCC2131,
      logoPath: "assets/images/auchan.png",
    ),
    MyCard(
      id: 2,
      title: "Carrefour",
      color: 0x003F8A,
      logoPath: "assets/images/carrefour.png",
    ),
    MyCard(
      id: 3,
      title: "Leclerc",
      color: 0xB70B6,
      logoPath: "assets/images/leclerc.png",
    ),
    MyCard(
      id: 4,
      title: "Casino",
      color: 0x1C7553,
      logoPath: "assets/images/casino.png",
    ),
    MyCard(
      id: 5,
      title: "Intermarché",
      color: 0xBB0413,
      logoPath: "assets/images/intermarche.png",
    ),
    MyCard(
      id: 6,
      title: "Lidl",
      color: 0x1B2F91,
      logoPath: "assets/images/lidl.png",
    ),
    MyCard(
      id: 7,
      title: "Auchan 2",
      logoPath: "assets/images/auchan.png",
    ),
    MyCard(
      id: 8,
      title: "Carrefour 2",
      color: 0x003F8A,
      logoPath: "assets/images/carrefour.png",
    ),
    MyCard(
      id: 9,
      title: "Leclerc 2",
      color: 0xB70B6,
      logoPath: "assets/images/leclerc.png",
    ),
    MyCard(
      id: 10,
      title: "Casino 2",
      color: 0x1C7553,
      logoPath: "assets/images/casino.png",
    ),
    MyCard(
      id: 11,
      title: "Intermarché 2",
      color: 0xBB0413,
      logoPath: "assets/images/intermarche.png",
    ),
    MyCard(
      id: 12,
      title: "Lidl 2",
      color: 0x1B2F91,
      // const Color.fromRGBO(27, 47, 145, 1),
      logoPath: "assets/images/lidl.png",
    ),
  ];

  static List<MyCard> bigList = [
    MyCard(
      id: 1,
      title: "Auchan",
      color: 0xCC2131,
      logoPath: "assets/images/auchan.png",
    ),
    MyCard(
      id: 2,
      title: "Carrefour",
      color: 0x003F8A,
      logoPath: "assets/images/carrefour.png",
    ),
    MyCard(
      id: 3,
      title: "Leclerc",
      color: 0xB70B6,
      logoPath: "assets/images/leclerc.png",
    ),
    MyCard(
      id: 4,
      title: "Casino",
      color: 0x1C7553,
      logoPath: "assets/images/casino.png",
    ),
    MyCard(
      id: 5,
      title: "Intermarché",
      color: 0xBB0413,
      logoPath: "assets/images/intermarche.png",
    ),
    MyCard(
      id: 6,
      title: "Lidl",
      color: 0x1B2F91,
      logoPath: "assets/images/lidl.png",
    ),
    MyCard(
      id: 7,
      title: "Auchan 2",
      logoPath: "assets/images/auchan.png",
    ),
    MyCard(
      id: 8,
      title: "Carrefour 2",
      color: 0x003F8A,
      logoPath: "assets/images/carrefour.png",
    ),
    MyCard(
      id: 9,
      title: "Leclerc 2",
      color: 0xB70B6,
      logoPath: "assets/images/leclerc.png",
    ),
    MyCard(
      id: 10,
      title: "Casino 2",
      color: 0x1C7553,
      logoPath: "assets/images/casino.png",
    ),
    MyCard(
      id: 11,
      title: "Intermarché 2",
      color: 0xBB0413,
      logoPath: "assets/images/intermarche.png",
    ),
    MyCard(
      id: 12,
      title: "Lidl 2",
      color: 0x1B2F91,
      logoPath: "assets/images/lidl.png",
    ),
    MyCard(
      id: 13,
      title: "Auchan 3",
      color: 0xCC2131,
      logoPath: "assets/images/auchan.png",
    ),
    MyCard(
      id: 14,
      title: "Carrefour 3",
      color: 0x003F8A,
      logoPath: "assets/images/carrefour.png",
    ),
    MyCard(
      id: 15,
      title: "Leclerc 3",
      color: 0xB70B6,
      logoPath: "assets/images/leclerc.png",
    ),
    MyCard(
      id: 16,
      title: "Casino 3",
      color: 0x1C7553,
      logoPath: "assets/images/casino.png",
    ),
    MyCard(
      id: 17,
      title: "Intermarché 3",
      color: 0xBB0413,
      logoPath: "assets/images/intermarche.png",
    ),
    MyCard(
      id: 18,
      title: "Lidl 3",
      color: 0x1B2F91,
      logoPath: "assets/images/lidl.png",
    ),
    MyCard(
      id: 19,
      title: "Auchan 4",
      logoPath: "assets/images/auchan.png",
    ),
    MyCard(
      id: 20,
      title: "Carrefour 4",
      color: 0x003F8A,
      logoPath: "assets/images/carrefour.png",
    ),
    MyCard(
      id: 21,
      title: "Leclerc 4",
      color: 0xB70B6,
      logoPath: "assets/images/leclerc.png",
    ),
    MyCard(
      id: 22,
      title: "Casino 4",
      color: 0x1C7553,
      logoPath: "assets/images/casino.png",
    ),
    MyCard(
      id: 23,
      title: "Intermarché 4",
      color: 0xBB0413,
      logoPath: "assets/images/intermarche.png",
    ),
    MyCard(
      id: 24,
      title: "Lidl 4",
      color: 0x1B2F91,
      // const Color.fromRGBO(27, 47, 145, 1),
      logoPath: "assets/images/lidl.png",
    ),
  ];

  /// Returns the list of predefined cards in the form of a List of CardSuggestion
  static List<CardSuggestion> cardSuggestions = [
    CardSuggestion(title: "Auchan", logoPath: "assets/images/auchan.png"),
    CardSuggestion(title: "Carrefour", logoPath: "assets/images/carrefour.png"),
    CardSuggestion(title: "Leclerc", logoPath: "assets/images/leclerc.png"),
    CardSuggestion(title: "Casino", logoPath: "assets/images/casino.png"),
    CardSuggestion(
        title: "Intermarché", logoPath: "assets/images/intermarche.png"),
    CardSuggestion(title: "Lidl", logoPath: "assets/images/lidl.png"),
  ];
}
