import 'package:app_papa_v2/widgets/home/add_card_container.dart';
import 'package:app_papa_v2/widgets/home/mes_favoris_container.dart';
import 'package:flutter/material.dart';

class TopContainer extends StatelessWidget {
  final Function onFavTap;
  final double height;
  final bool isFav;
  const TopContainer({
    super.key,
    required this.height,
    required this.onFavTap,
    required this.isFav,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AddCardContainer(),
          MesFavorisContainer(onFavTap: onFavTap, isFavorite: isFav),
        ],
      ),
    );
  }
}
