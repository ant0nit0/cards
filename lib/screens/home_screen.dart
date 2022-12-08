import 'package:app_papa_v2/database/cards_database.dart';
import 'package:app_papa_v2/models/my_card.dart';
import 'package:app_papa_v2/widgets/home/card_tile.dart';
import 'package:app_papa_v2/widgets/home/top_container_home.dart';
import 'package:flutter/material.dart';
import 'package:app_papa_v2/database/data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  late List<MyCard> cards;
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0.0;
  bool ifFirstLaunch = true; // Used to set the size only once
  late final Size size;
  bool onlyFav = false;

  @override
  void initState() {
    super.initState();
    // Initialize the list of cards
    // cards = Data.list;
    // cards = [];
    refreshCards();

    // Add a listener to the controller to detect the scroll
    controller.addListener(() {
      double value = controller.offset / 150;
      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 75;
      });
    });
  }

  /// Function to refresh the list of cards
  Future refreshCards() async {
    setState(() {
      isLoading = true;
    });
    cards = await CardsDatabase.instance.readAllCards();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ifFirstLaunch) {
      size = MediaQuery.of(context).size;
      ifFirstLaunch = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SafeArea(
        child: Column(
          children: [
            _drawTitle(),
            _drawTopContainer(),
            isLoading ? CircularProgressIndicator() : _drawCards(),
          ],
        ),
      ),
    );
  }

  _drawTopContainer() {
    return AnimatedOpacity(
      opacity: closeTopContainer ? 0 : 1,
      duration: const Duration(milliseconds: 600),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        width: size.width,
        alignment: Alignment.topCenter,
        height: closeTopContainer ? 0 : size.height * .3,
        child: TopContainer(
            height: size.height * .3, onFavTap: onFavTap, isFav: onlyFav),
      ),
    );
  }

  _drawCards() {
    if (cards.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 60.0),
          child: Text('Aucune carte enregistrée'),
        ),
      );
    }
    return Expanded(
      child: ReorderableListView.builder(
        footer: Container(
          height: 100,
          color: Colors.transparent,
        ),
        onReorder: (oldIndex, newIndex) {
          setState(() {
            // ignore: todo
            // TODO: Store the changment in the database
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final MyCard item = cards.removeAt(oldIndex);
            cards.insert(newIndex, item);
          });
        },
        scrollController: controller,
        itemBuilder: (context, index) {
          double scale = 1.0;
          if (topContainer > 0.5) {
            scale = index + 0.5 - topContainer;
            if (scale < 0) {
              scale = 0;
            } else if (scale > 1) {
              scale = 1;
            }
          }
          return Opacity(
              key: ValueKey(cards[index]),
              opacity: scale,
              child: Transform(
                transform: Matrix4.identity()..scale(scale, scale),
                alignment: Alignment.bottomCenter,
                child: Align(
                  heightFactor: .7,
                  alignment: Alignment.topCenter,
                  child: CardTile(card: cards[index]),
                ),
              ));
        },
        itemCount: cards.length,
      ),
    );
  }

  Widget _drawTitle() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          DefaultTextStyle(
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              fontSize: 26.0,
            ),
            child: Text(
              "Mes cartes",
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }

  onFavTap() {
    setState(() {
      isLoading = true;
    });
    onlyFav = !onlyFav;
    if (onlyFav) {
      final List<MyCard> favCards = cards.where((card) => card.isFav).toList();
      cards = favCards;
    } else {
      refreshCards();
    }
    setState(() {
      isLoading = false;
    });
  }
}
