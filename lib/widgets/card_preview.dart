import 'dart:math';

import 'package:app_papa_v2/models/my_card.dart';
import 'package:app_papa_v2/models/my_color.dart';
import 'package:app_papa_v2/screens/barcode_fullscreen.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class CardPreview extends StatelessWidget {
  final String title;
  final Color color;
  final String barCodeData;
  final String? logoPath;

  const CardPreview({
    super.key,
    this.barCodeData = "",
    this.logoPath,
    required this.title,
    required this.color,
  });

  /// Function to create a card by passing in a [MyCard] object
  /// This is used in the [CardDetail] widget
  factory CardPreview.fromCard({required MyCard card, String? barCodeData}) {
    final myColor = MyColor()..setColorFromInt(card.color);
    final color = myColor.getColor();
    return CardPreview(
      title: card.title,
      color: color,
      barCodeData: barCodeData ?? "",
      logoPath: card.logoPath,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Rotate the image
    final width = MediaQuery.of(context).size.width - 40.0;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
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
        children: [
          // Title :
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MyColor.getTextColor(
                        color: MyColor.fromColor(
                      color,
                    )),
                    fontSize: 26.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // display the logo if it exists
                if (logoPath != null && logoPath!.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: Image.asset(
                        logoPath!,
                        width: 30.0,
                        height: 30.0,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          // Black line :
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            width: width,
            color: MyColor.getTextColor(
              color: MyColor.fromColor(
                color,
              ),
            ),
            height: 50.0,
          ),
          const SizedBox(
            height: 8.0,
          ),
          // Bottom of the card, with the barCode :
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // IconButton to open the barCode in fullScreen
                  barCodeData.isEmpty || barCodeData == "-1"
                      ? const SizedBox(
                          width: 1.0,
                        )
                      : IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BarcodeFullScreen(
                                  barcode: barCodeData,
                                  color: color,
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.fullscreen,
                            color:
                                MyColor.isDark(color: MyColor.fromColor(color))
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                  // Barcode :
                  barCodeData.isNotEmpty
                      ? generateBarCode(barCodeData, width: width * .75)
                      : const SizedBox(
                          width: 1.0,
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Function to generate a barcode with [barCode] as the text
  /// and [width] as the width of the barcode
  ///
  Widget generateBarCode(
    String barCode, {
    double? width,
  }) {
    if (barCode == "-1" || barCode.isEmpty) return const SizedBox(width: 1.0);
    return BarcodeWidget(
      barcode: Barcode.code128(),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      data: barCode,
      errorBuilder: (context, error) => Text(
        'Aucun code barre disponible',
        style: TextStyle(
          color: MyColor.getTextColor(
            color: MyColor.fromColor(
              color,
            ),
          ),
          fontSize: 12.0,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      width: width ?? 200,
      // calculate height based on the width
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      drawText: true,
    );
  }
}
