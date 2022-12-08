import 'package:app_papa_v2/models/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as cp;
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

/// Draw the colors preview with the 5 propositions and a button to restart the preview
class MyColorPicker extends StatefulWidget {
  final Color selectedColor;
  final Function onColorChanged;
  const MyColorPicker({
    super.key,
    required this.onColorChanged,
    required this.selectedColor,
  });

  @override
  State<MyColorPicker> createState() => _MyColorPickerState();
}

class _MyColorPickerState extends State<MyColorPicker> {
  bool isFirstLaunch = true;
  Color currentColor = Colors.black;
  List<Color> _colors = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirstLaunch) {
      resetColorsPreview();
      currentColor = widget.selectedColor;
      _colors[0] = currentColor;
      isFirstLaunch = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Button to open the color picker
        GestureDetector(
          onTap: () => _openColorPicker(context),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12.0),
            decoration: BoxDecoration(
              color: currentColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
              child: Text(
                'Choisir une couleur',
                style: TextStyle(
                    color: MyColor.getTextColor(
                        color: MyColor.fromColor(currentColor))),
              ),
            ),
          ),
        ),
        // The five propositions of color, with the reset button
        Padding(
          padding: const EdgeInsets.only(
            top: 6.0,
            bottom: 12.0,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < 5; i++) _drawColorButton(_colors[i]),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.restart_alt_rounded,
                      color: MyColor.isDark(
                              color: MyColor.fromColor(widget.selectedColor))
                          ? widget.selectedColor
                          : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        resetColorsPreview();
                      });
                      widget.onColorChanged(_colors[0]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Reset the 5 colors propositions for the preview<br/>
  void resetColorsPreview() {
    _colors = MyColor.random5Colors();
    currentColor = _colors[0];
  }

  /// Draw a round button with the [color] <br/>
  /// onTap: change the [_selectedColor] to [color]
  Widget _drawColorButton(Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () {
          currentColor = color;
          widget.onColorChanged(color);
        },
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(18.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          height: 36.0,
          width: 36.0,
        ),
      ),
    );
  }

  /// Open the color picker
  /// <br/> [context] is the context of the current widget
  void _openColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return customColorPicker(context);
      },
    );
  }

  Widget customColorPicker(BuildContext ctx) {
    final initColor = currentColor;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: MediaQuery.of(ctx).size.height * 0.75,
        width: MediaQuery.of(ctx).size.width * 0.75,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Material(
                child: cp.HueRingPicker(
                  portraitOnly: true,
                  hueRingStrokeWidth: 40.0,
                  pickerColor: Colors.black,
                  onColorChanged: (color) {
                    widget.onColorChanged(color);
                    currentColor = color;
                    _colors[0] = currentColor;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      widget.onColorChanged(initColor);
                      currentColor = initColor;
                      _colors[0] = currentColor;
                      return Navigator.of(context).pop();
                    },
                    child: const Text('Annuler'),
                  ),
                  const SizedBox(width: 8.0),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Valider'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
