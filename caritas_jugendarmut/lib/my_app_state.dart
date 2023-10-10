import 'package:english_words/english_words.dart';
import 'package:flutter/foundation.dart';

class MyAppState extends ChangeNotifier {
  var favorites = <WordPair>[];
  var current = WordPair.random();

  List getFavoritesList() {
    return favorites;
  }

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void removeFavorite(WordPair current) {
    favorites.remove(current);
    notifyListeners();
  }

  void addFavorite() async {
    favorites.contains(current)
        ? removeFavorite(current)
        : favorites.add(current);
  }

  String getText() {
    return current.asString;
  }
}
