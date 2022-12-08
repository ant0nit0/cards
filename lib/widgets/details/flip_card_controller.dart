import 'package:app_papa_v2/widgets/details/detail_main_stack.dart';
import 'package:app_papa_v2/widgets/details/flip_card_widget.dart';
import 'package:flutter/material.dart';

class FlipCardController {
  FlipCardWidgetState? _state;

  void attach(FlipCardWidgetState state) {
    _state = state;
  }

  Future flipCard() async {
    print("--- Flip controller called");
    if (_state != null) {
      await _state!.flipCard();
    }
  }
}
