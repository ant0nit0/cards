// ignore_for_file: todo
import 'package:app_papa_v2/database/cards_database.dart';
import 'package:app_papa_v2/models/card_suggestion.dart';
import 'package:app_papa_v2/models/my_card.dart';
import 'package:app_papa_v2/screens/home_screen.dart';
import 'package:app_papa_v2/widgets/add_card/add_barcode_widget.dart';
import 'package:app_papa_v2/widgets/add_card/add_card_color_picker.dart';
import 'package:app_papa_v2/widgets/add_card/add_card_name_widget.dart';
import 'package:app_papa_v2/widgets/card_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/my_color.dart';

// ignore: must_be_immutable
class AddOrUpdateCardScreen extends StatefulWidget {
  MyCard? updateCard;
  AddOrUpdateCardScreen({super.key, this.updateCard});

  @override
  State<AddOrUpdateCardScreen> createState() => _AddOrUpdateCardScreenState();
}

class _AddOrUpdateCardScreenState extends State<AddOrUpdateCardScreen> {
  static const defaultColor = Color.fromARGB(255, 11, 70, 80);
  static const int nbSteps = 3;
  int _stepIndex = 0;
  Color _selectedColor = Colors.black;
  TextEditingController textController = TextEditingController();
  TextEditingController barCodeController = TextEditingController();
  late String cardTitle, _barCode, logoPath;
  late int intColor;
  late final bool isUpdate;

  @override
  void initState() {
    super.initState();
    if (widget.updateCard != null) {
      cardTitle = widget.updateCard!.title;
      logoPath = widget.updateCard!.logoPath ?? "";
      _barCode = widget.updateCard!.barCode ?? "";
      _selectedColor = widget.updateCard!.color != null
          ? Color(widget.updateCard!.color!)
          : defaultColor;
      intColor = _selectedColor.value;
      textController.text = cardTitle;
      barCodeController.text = _barCode;
      isUpdate = true;
    } else {
      cardTitle = "";
      logoPath = "";
      _barCode = "";
      _selectedColor = defaultColor;
      intColor = _selectedColor.value;
      isUpdate = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      // GestureDetector is used to disable the keyboard when the user tap outside of a textfield
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0, left: 24.0, right: 24.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text field for the card's title
                _drawTitle(),
                const SizedBox(
                  height: 24.0,
                ),
                // Stepper
                SizedBox(
                  height: 300.0,
                  // Modify the current theme
                  child: Theme(
                    data: ThemeData(
                      canvasColor: Colors.transparent,
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                            primary: _selectedColor,
                          ),
                    ),
                    child: Stepper(
                      physics: const ClampingScrollPhysics(),
                      margin: const EdgeInsets.all(0.0),
                      currentStep: _stepIndex,
                      controlsBuilder: (context, details) {
                        // Cancel and Continue buttons
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Retour button
                            if (details.onStepCancel != null && _stepIndex != 0)
                              GestureDetector(
                                onTap: details.onStepCancel,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 10.0),
                                  decoration: BoxDecoration(
                                    color: _selectedColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: DefaultTextStyle(
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: MyColor.getTextColor(
                                                color: MyColor.fromColor(
                                                    _selectedColor))),
                                        child: const Text("Retour")),
                                  ),
                                ),
                              ),
                            // Divider
                            const SizedBox(
                              width: 16.0,
                            ),
                            // Continue button
                            if (details.onStepContinue != null)
                              GestureDetector(
                                onTap: details.onStepContinue,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 10.0),
                                  decoration: BoxDecoration(
                                    color: _selectedColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: DefaultTextStyle(
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: MyColor.getTextColor(
                                              color: MyColor.fromColor(
                                                  _selectedColor))),
                                      child: _stepIndex == nbSteps - 1
                                          ? isUpdate
                                              ? const Text("Enregistrer")
                                              : const Text("Ajouter")
                                          : const Text("Continuer"),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                      // Cancel and Continue functions
                      onStepCancel: () {
                        if (_stepIndex > 0) {
                          setState(() {
                            _stepIndex--;
                          });
                        }
                      },
                      onStepContinue: () {
                        if (_stepIndex < nbSteps - 1) {
                          setState(() {
                            _stepIndex++;
                          });
                        } else {
                          if (isUpdate) {
                            updateCard();
                          } else {
                            createCard();
                          }
                          // close the page and go back to the homeScreen
                          // Then refresh the homeScreen
                          Navigator.of(context)
                              .pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          )
                              .then((value) {
                            if (value != null) {
                              value.refresh();
                            }
                          }, onError: (error) {
                            print(error);
                          });
                        }
                      },
                      onStepTapped: (index) {
                        setState(() {
                          _stepIndex = index;
                        });
                      },
                      elevation: 0.0,
                      type: StepperType.horizontal,
                      // Steps
                      steps: [
                        Step(
                          isActive: _stepIndex >= 0,
                          state: (_stepIndex > 0)
                              ? StepState.complete
                              : StepState.editing,
                          title: const Text("Nom"),
                          content: AddCardNameWidget(
                            onChanged: setCardTitle,
                            setLogo: setLogo,
                            textController: textController,
                          ),
                        ),
                        Step(
                          title: const Text("Coul",
                              overflow: TextOverflow.ellipsis),
                          isActive: (_stepIndex >= 1),
                          state: _stepIndex > 1
                              ? StepState.complete
                              : (_stepIndex == 1
                                  ? StepState.editing
                                  : StepState.indexed),
                          content: MyColorPicker(
                            selectedColor: _selectedColor,
                            onColorChanged: setColor,
                          ),
                        ),
                        Step(
                          title: const Text(
                            "Code",
                            overflow: TextOverflow.ellipsis,
                          ),
                          isActive: (_stepIndex >= 2),
                          state: _stepIndex == 2
                              ? StepState.editing
                              : StepState.indexed,
                          content: AddBarCodeWidget(
                            onBarCodeScanned: setBarCode,
                            barcodeData: _barCode,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 16.0,
                ),
                CardPreview(
                  title: cardTitle,
                  color: _selectedColor,
                  barCodeData: _barCode,
                  logoPath: logoPath,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _drawPreviousIcon() {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      alignment: Alignment.centerLeft,
      icon: Icon(
        Icons.arrow_back_ios,
        // If the color is light, the icon is black
        color: MyColor.isDark(color: MyColor.fromColor(_selectedColor))
            ? _selectedColor
            : Colors.black,
        size: 24.0,
      ),
    );
  }

  /// Write "Ajouter une carte" with <br/> color = [Colors.black] <br/> Font size = 26.0
  /// <br/> Font family = 'Poppins' <br/> Font weight = [FontWeight.bold]
  Widget _drawTitle() {
    return Row(
      children: [
        _drawPreviousIcon(),
        DefaultTextStyle(
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            fontSize: 18.0,
          ),
          child: isUpdate
              ? const Text(
                  "Modifier une carte",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                )
              : const Text(
                  "Ajouter une carte",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ],
    );
  }

  setCardTitle(String title) {
    setState(() {
      cardTitle = title;
    });
  }

  setLogo(String newLogoPath) {
    setState(() {
      logoPath = newLogoPath;
    });
  }

  setBarCode(String code) {
    setState(() {
      _barCode = code;
    });
  }

  setColor(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  Future createCard() async {
    final card = MyCard(
      title: cardTitle,
      color: _selectedColor.value,
      barCode: _barCode,
      logoPath: logoPath,
      isFav: false,
    );

    await CardsDatabase.instance.create(card);
  }

  Future updateCard() async {
    print('update card');
    if (widget.updateCard != null) {
      widget.updateCard!.title = cardTitle;
      widget.updateCard!.color = _selectedColor.value;
      widget.updateCard!.barCode = _barCode;
      widget.updateCard!.logoPath = logoPath;
      await CardsDatabase.instance.update(widget.updateCard!);
    }
  }
}
