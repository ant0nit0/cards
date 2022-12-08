import 'package:flutter/material.dart';

/// Write the [title] with <br/>color = [Colors.black] <br/> Font size = 20.0
/// <br/> Font family = 'Poppins' <br/> Font weight = FontWeight.w600
class UnderTitle extends StatelessWidget {
  final String title;
  const UnderTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      ),
      child: Text(title),
    );
  }
}
