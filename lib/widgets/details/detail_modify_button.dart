import 'package:app_papa_v2/models/my_color.dart';
import 'package:flutter/material.dart';

class DetailModifyButton extends StatelessWidget {
  final Function onTap;
  final Color color;
  const DetailModifyButton({
    super.key,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * .3,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          Icons.edit,
          color: MyColor.isDark(color: MyColor.fromColor(color))
              ? Colors.white
              : Colors.black,
        ),
      ),
    );
  }
}
