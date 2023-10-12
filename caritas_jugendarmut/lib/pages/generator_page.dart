import 'package:caritas_jugendarmut/big_card.dart';
import 'package:caritas_jugendarmut/my_app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    final theme = Theme.of(context);
    final double height = MediaQuery.of(context).size.height;

    IconData likeIcon = appState.favorites.contains(pair)
        ? Icons.favorite
        : Icons.favorite_border;

    return Column(
      children: [
        Container(
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
            ),
            color: theme.colorScheme.primary,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 15,
                left: 0,
                child: Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 20,
                child: Text(
                  "Home",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.05,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BigCard(pair: pair),
              SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                      onPressed: () {
                        appState.addFavorite();
                      },
                      icon: Icon(likeIcon),
                      label: Text("Like")),
                  SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () {
                        appState.getNext();
                      },
                      child: Text('Change Text')),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
