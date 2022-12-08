import 'package:flutter/material.dart';

class MesFavorisContainer extends StatefulWidget {
  final Function onFavTap;
  final bool isFavorite;
  const MesFavorisContainer({
    super.key,
    required this.onFavTap,
    required this.isFavorite,
  });

  @override
  State<MesFavorisContainer> createState() => _MesFavorisContainerState();
}

class _MesFavorisContainerState extends State<MesFavorisContainer> {
  bool isFav = false;
  Color _color = const Color.fromARGB(255, 90, 160, 119);

  @override
  Widget build(BuildContext context) {
    // width : 20.0 = Padding of main Container, 30.0 is the spaceEvenly the containers
    final width = (MediaQuery.of(context).size.width - 20.0 - 50.0) / 2;
    // height = size of the top container - 30.0 (padding)
    final height = MediaQuery.of(context).size.height * .3 - 30.0;
    return GestureDetector(
      onTap: () {
        widget.onFavTap();
        isFav = !isFav;
        setState(() {
          _color = isFav
              ? Colors.blue.shade100
              : const Color.fromARGB(255, 90, 160, 119);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          color: _color,
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
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 16.0),
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: isFav ? Colors.black87 : Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                    fontFamily: 'Poppins',
                  ),
                  child: Text(
                    "Voir mes\n${isFav ? "Cartes" : "Favoris"}",
                    // !isFav ? "Voir mes\nFavoris" : "Voir mes\nCartes",
                    maxLines: 2,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.2,
              ),
              Center(
                child: Material(
                  color: Colors.transparent,
                  child: Icon(
                    isFav
                        ? Icons.credit_card_rounded
                        : Icons.favorite_border_rounded,
                    size: 40.0,
                    color: isFav ? Colors.black87 : Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
