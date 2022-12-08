import 'package:app_papa_v2/models/my_color.dart';
import 'package:flutter/material.dart';

class DetailFavouriteButton extends StatelessWidget {
  final Function onTap;
  final Color color;
  final bool isFav;
  const DetailFavouriteButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.isFav,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * .3,
        decoration: BoxDecoration(
          color: isFav ? color : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: IconButton(
          padding: const EdgeInsets.all(0),
          onPressed: () => onTap(),
          alignment: Alignment.center,
          icon: Icon(
            isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: isFav ? Colors.white : color,
            size: 30,
          ),
        ),
      ),
    );
  }
}
