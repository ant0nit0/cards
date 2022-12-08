import 'package:app_papa_v2/database/cards_database.dart';
import 'package:app_papa_v2/models/my_card.dart';
import 'package:app_papa_v2/models/my_color.dart';
import 'package:app_papa_v2/screens/add_card_screen.dart';
import 'package:app_papa_v2/widgets/card_preview.dart';
import 'package:app_papa_v2/widgets/details/detail_favourite_button.dart';
import 'package:app_papa_v2/widgets/details/detail_modify_button.dart';
import 'package:app_papa_v2/widgets/details/flip_card_controller.dart';
import 'package:app_papa_v2/widgets/details/flip_card_widget.dart';
import 'package:flutter/material.dart';

class DetailCardMainStack extends StatefulWidget {
  final Offset? position;
  final MyCard card;
  const DetailCardMainStack({
    super.key,
    this.position,
    required this.card,
  });

  @override
  State<DetailCardMainStack> createState() => _DetailCardMainStackState();
}

class _DetailCardMainStackState extends State<DetailCardMainStack>
    with SingleTickerProviderStateMixin {
  bool isInit = false;
  // bool isInUpdatePos = false;
  final FlipCardController flipController = FlipCardController();
  late final MyCard card;
  late final Color color;
  double topPosition = 0.0;

  @override
  void initState() {
    super.initState();
    card = widget.card;
    if (widget.position != null) {
      topPosition = widget.position!.dy;
    }
    // Launch the animation to translate the card
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isInit = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final myColor = MyColor()..setColorFromInt(card.color);
    final color = myColor.getColor();
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            top: isInit ? 0 : topPosition - 110,
            child: FlipCardWidget(
              controller: flipController,
              front:
                  CardPreview.fromCard(card: card, barCodeData: card.barCode),
              back: Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            top: isInit ? 250 : topPosition + 250,
            left: isInit ? 50 : -550,
            child: DetailModifyButton(onTap: _goToEditCard, color: color),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            top: isInit ? 250 : topPosition + 250,
            // : !isInUpdatePos
            //     ? topPosition + 250
            //     : 400,
            right: isInit ? 50 : -550,
            child: DetailFavouriteButton(
                onTap: _toggleFavourite, isFav: card.isFav, color: color),
          ),
        ],
      ),
    );
  }

  void _goToEditCard() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddOrUpdateCardScreen(
          updateCard: card,
        ),
      ),
    );
  }

  // void toggleIsInUpdatePos() {
  //   setState(() {
  //     isInUpdatePos = !isInUpdatePos;
  //   });
  // }

  void _toggleFavourite() async {
    setState(() {
      card.isFav = !card.isFav;
    });
    await updateFav();
  }

  Future updateFav() async {
    await CardsDatabase.instance.update(widget.card);
  }
}
