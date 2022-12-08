import 'package:app_papa_v2/database/data.dart';
import 'package:app_papa_v2/models/card_suggestion.dart';
import 'package:flutter/material.dart';

class TextFieldSuggestions extends StatefulWidget {
  final Function onSelectedItem, onTextChanged;
  final String? initialText;
  const TextFieldSuggestions({
    super.key,
    this.initialText,
    required this.onSelectedItem,
    required this.onTextChanged,
  });

  @override
  State<StatefulWidget> createState() => _TextFieldSuggestionsState();
}

class _TextFieldSuggestionsState extends State<TextFieldSuggestions> {
  final List<CardSuggestion> cardsSuggestions = Data.cardSuggestions;
  bool isFirstLaunch = true;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<CardSuggestion>(
      optionsBuilder: (textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<CardSuggestion>.empty();
        }
        return cardsSuggestions.where((CardSuggestion suggestion) {
          return suggestion.title
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (CardSuggestion selection) {
        widget.onSelectedItem(selection);
      },
      displayStringForOption: (option) => option.title,
      fieldViewBuilder: (context, fieldTextEditingController, fieldFocusNode,
          onFieldSubmitted) {
        if (isFirstLaunch) {
          fieldTextEditingController.text = widget.initialText ?? "";
          isFirstLaunch = false;
        }
        return TextField(
          onChanged: (value) {
            widget.onTextChanged(value);
          },
          onEditingComplete: () {
            if (CardSuggestion.isCardSuggestion(
                fieldTextEditingController.text)) {
              final cardSuggestion = CardSuggestion.getCardSuggestion(
                  fieldTextEditingController.text);
              widget.onSelectedItem(cardSuggestion);
            }
            FocusScope.of(context).unfocus();
            widget.onTextChanged(fieldTextEditingController.text);
          },
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
          style: const TextStyle(fontWeight: FontWeight.bold),
        );
      },
      optionsViewBuilder: (context, onSelected, suggestions) => Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: 4.0,
          child: SizedBox(
            height: 200.0,
            width: 300.0,
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final CardSuggestion suggestion = suggestions.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    // Close the keyboard
                    FocusScope.of(context).unfocus();
                    widget.onSelectedItem(suggestion);
                    onSelected(suggestion);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          suggestion.title,
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500),
                        ),
                        Image.asset(
                          suggestion.logoPath,
                          height: 30,
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
