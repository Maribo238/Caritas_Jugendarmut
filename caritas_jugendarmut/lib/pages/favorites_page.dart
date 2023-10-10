import 'package:caritas_jugendarmut/my_app_state.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var favorites = appState.favorites;

    if (favorites.isEmpty) {
      return Center(
        child: Text('No Favorites yet'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text('You have ${favorites.length} Favorites'),
        ),
        for (WordPair element in favorites)
          ListTile(
            leading: IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  appState.removeFavorite(element);
                }),
            title: Text(element.asString),
          ),
      ],
    );
  }
}
