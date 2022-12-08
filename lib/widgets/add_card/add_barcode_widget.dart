import 'package:app_papa_v2/models/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AddBarCodeWidget extends StatelessWidget {
  final Function onBarCodeScanned;
  const AddBarCodeWidget({
    super.key,
    required this.onBarCodeScanned,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(12.0));
    // Return a column with a textfield for enter manually a barCode
    // and a button to scan a barCode
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: (value) {
            onBarCodeScanned(value);
          },
          decoration: InputDecoration(
            labelText: 'Entrer un code barre',
            hintText: '123456789',
            focusedBorder: border,
            border: border,
          ),
        ),
        GestureDetector(
          onTap: () => _openScanner(context),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: color,
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
                'Scanner un code barre',
                style: TextStyle(
                  color: MyColor.getTextColor(
                    color: MyColor.fromColor(color),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Open the scanner and call the callback function with the result
  _openScanner(BuildContext context) async {
    FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Annuler",
      true,
      ScanMode.BARCODE,
    ).then((value) {
      // If the value is not null
      if (value.isNotEmpty) {
        onBarCodeScanned(value);
      }
    });
  }
}
