import 'package:app_papa_v2/database/cards_database.dart';
import 'package:app_papa_v2/models/my_card.dart';
import 'package:app_papa_v2/models/my_color.dart';
import 'package:app_papa_v2/screens/add_card_screen.dart';
import 'package:app_papa_v2/widgets/details/detail_main_stack.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class DetailsScreenV2 extends StatefulWidget {
  final Offset? cardPosition;
  final MyCard card;
  const DetailsScreenV2({
    super.key,
    required this.card,
    this.cardPosition,
  });

  @override
  State<DetailsScreenV2> createState() => _DetailsScreenV2State();
}

class _DetailsScreenV2State extends State<DetailsScreenV2> {
  late final MyCard card;

  @override
  void initState() {
    super.initState();
    card = widget.card;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SafeArea(
        child: Column(
          children: [
            _drawTitle(),
            const SizedBox(height: 20),
            DetailCardMainStack(
              card: card,
              position: widget.cardPosition,
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawTitle() {
    final myColor = MyColor()..setColorFromInt(card.color);
    final color = myColor.getColor();
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
            color: MyColor.isDark(color: myColor) ? color : Colors.black,
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
          IconButton(
            onPressed: () => _deleteCard(),
            icon: Icon(
              Icons.delete_outline_rounded,
              color: MyColor.isDark(color: MyColor.fromInt(card.color!))
                  ? MyColor.fromInt(card.color!).getColor()
                  : Colors.black,
            ),
          )
        ],
      ),
    );
  }

  void _deleteCard() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer'),
        content: const Text('Êtes-vous sûr de vouloir supprimer cette carte ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              delete();
              // close the page and go back to the homeScreen
              // Then refresh the homeScreen
              Navigator.of(context)
                  .pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              )
                  .then((value) {
                if (value != null) {
                  value.refresh();
                }
              }, onError: (error) {
                print(error);
              });
            },
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  Future delete() async {
    final res = await CardsDatabase.instance.delete(card.id!);
    print('delete res: $res');
  }
}
