import 'package:app_papa_v2/models/my_color.dart';
import 'package:flutter/material.dart';

/// Draw a button with the [text] and the [onTap] function
/// <br/> The button's color is [color]
/// <br/> The button's text color is [Colors.white] if the [color] is dark
/// <br/> The button's text color is [Colors.black] if the [color] is light
class AddCardButton extends StatelessWidget {
  final Color color;
  final String title;
  final Function onTap;
  const AddCardButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, left: 20.0),
      child: GestureDetector(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: color,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: DefaultTextStyle(
              style: TextStyle(
                  color: MyColor.getTextColor(color: MyColor.fromColor(color)),
                  fontFamily: 'Poppins',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500),
              child: Text(title),
            ),
          ),
        ),
        onTap: () => onTap(),
      ),
    );
  }
}
