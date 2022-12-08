import 'package:app_papa_v2/database/cards_database.dart';
import 'package:app_papa_v2/models/my_card.dart';
import 'package:app_papa_v2/models/my_color.dart';
import 'package:app_papa_v2/screens/details_screen.dart';
import 'package:flutter/material.dart';

class CardTile extends StatefulWidget {
  final MyCard card;
  const CardTile({
    super.key,
    required this.card,
  });

  @override
  State<CardTile> createState() => _CardTileState();
}

class _CardTileState extends State<CardTile> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 40.0;
    final MyColor myColor =
        MyColor.fromInt(widget.card.color ?? MyColor.defaultValue);
    final Color color = myColor.getColor();
    final textColor = MyColor.getTextColor(color: myColor);
    return GestureDetector(
      onTap: () {
        final position = _getCardPosition(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreenV2(
              card: widget.card,
              cardPosition: position,
            ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        width: width,
        height: 220.0,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
          color: color,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Title :
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 12.0,
                right: 12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.card.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 26.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ClipRRect(
                    child: Container(
                      height: width * .15,
                      width: width * .15,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(
                          width * .15 * .5,
                        ),
                      ),
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          setState(() {
                            widget.card.isFav = !widget.card.isFav;
                            updateFav();
                          });
                        },
                        alignment: Alignment.center,
                        icon: Icon(
                          widget.card.isFav
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: Colors.white,
                          size: width * .1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            // Bottom of the card, with the image :
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _drawLogo(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Return the logo of the [widget.card] if it exists.
  Widget _drawLogo() {
    if (widget.card.logoPath != null && widget.card.logoPath!.isNotEmpty) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        height: 80.0,
        width: 80.0,
        child: Image.asset(widget.card.logoPath!, fit: BoxFit.fitWidth),
      );
    } else {
      return const SizedBox(height: 1.0);
    }
  }

  /// Return the position of the card on the screen.
  Offset _getCardPosition(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    return position;
  }

  /// Update the favorite status of the card.
  Future updateFav() async {
    await CardsDatabase.instance.update(widget.card);
  }
}
