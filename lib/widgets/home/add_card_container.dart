import 'package:app_papa_v2/screens/add_card_screen.dart';
import 'package:flutter/material.dart';

class AddCardContainer extends StatelessWidget {
  const AddCardContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // width : 20.0 = Padding of main Container, 30.0 is the spaceEvenly the containers
    final width = (MediaQuery.of(context).size.width - 20.0 - 50.0) / 2;
    // height = size of the top container - 30.0 (padding)
    final height = MediaQuery.of(context).size.height * 0.3 - 30.0;
    return GestureDetector(
      onTap: () => _goToAddCardScreen(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          color: const Color.fromARGB(255, 245, 245, 220),
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ],
        ),
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 12.0, left: 16.0),
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                    fontFamily: 'Poppins',
                  ),
                  child: Text(
                    "Ajouter\nune carte",
                    maxLines: 2,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.2,
              ),
              const Center(
                child: Material(
                  color: Colors.transparent,
                  child: Icon(
                    Icons.add_rounded,
                    size: 40.0,
                    color: Colors.black87,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _goToAddCardScreen(BuildContext context) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => AddOrUpdateCardScreen(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}
