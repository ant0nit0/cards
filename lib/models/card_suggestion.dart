import 'package:app_papa_v2/database/data.dart';

class CardSuggestion {
  final String title;
  final String logoPath;

  CardSuggestion({
    required this.title,
    required this.logoPath,
  });

  /// Static function to check if the [string] passed as argument <br/>
  /// corresponds to a card suggestion present in all of the suggestions
  static bool isCardSuggestion(String string) {
    final allSuggestions = Data.cardSuggestions;
    for (final suggestion in allSuggestions) {
      if (suggestion.title.toLowerCase() == string.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  /// Static function to get the [CardSuggestion] object <br/>
  /// corresponding to the [string] passed as argument
  static CardSuggestion getCardSuggestion(String string) {
    final allSuggestions = Data.cardSuggestions;
    for (final suggestion in allSuggestions) {
      if (suggestion.title.toLowerCase() == string.toLowerCase()) {
        return suggestion;
      }
    }
    throw Exception('No suggestion found for $string');
  }
}
