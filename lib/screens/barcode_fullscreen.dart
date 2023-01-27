import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

import 'dart:math';

class BarcodeFullScreen extends StatefulWidget {
  final String barcode;
  final Color color;
  const BarcodeFullScreen({
    super.key,
    required this.barcode,
    required this.color,
  });

  @override
  State<BarcodeFullScreen> createState() => _BarcodeFullScreenState();
}

class _BarcodeFullScreenState extends State<BarcodeFullScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: ThemeData.light().iconTheme.copyWith(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: widget.barcode.isEmpty || widget.barcode == "-1"
          ? const Center(
              child: Text("Aucun code-barre"),
            )
          : Container(
              color: widget.color.withOpacity(.4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Transform.rotate(
                      angle: pi * .5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        width: MediaQuery.of(context).size.height,
                        height: MediaQuery.of(context).size.width * 0.65,
                        padding: const EdgeInsets.all(30.0),
                        child: BarcodeWidget(
                          barcode: Barcode.code128(),
                          data: widget.barcode,
                          drawText: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
