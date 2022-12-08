import 'package:app_papa_v2/models/card_suggestion.dart';
import 'package:app_papa_v2/widgets/add_card/text_field_suggestions.dart';
import 'package:flutter/material.dart';

class AddCardNameWidget extends StatefulWidget {
  final Function onChanged;
  final Function? setLogo;
  final TextEditingController textController;
  const AddCardNameWidget({
    super.key,
    this.setLogo,
    required this.onChanged,
    required this.textController,
  });

  @override
  State<AddCardNameWidget> createState() => _AddCardNameWidgetState();
}

class _AddCardNameWidgetState extends State<AddCardNameWidget> {
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(12.0));
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12.0,
      ),
      child: TextFieldSuggestions(
        initialText: widget.textController.text,
        onTextChanged: widget.onChanged,
        onSelectedItem: (CardSuggestion suggestion) {
          widget.textController.text = suggestion.title;
          widget.onChanged(suggestion.title);
          if (widget.setLogo != null) {
            widget.setLogo!(suggestion.logoPath);
          }
        },
      ),
      // child: TextField(
      //   controller: widget.textController,
      //   maxLines: 1,
      //   onChanged: (value) => widget.onChanged(value),
      //   // Disable focus when keyboard is closed
      //   onEditingComplete: () => FocusScope.of(context).unfocus(),
      //   decoration: InputDecoration(
      //     hintText: 'Ex: Carrefour',
      //     focusedBorder: border,
      //     border: border,
      //   ),
      // ),
    );
  }
}
