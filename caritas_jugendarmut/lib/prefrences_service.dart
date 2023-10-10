import 'package:english_words/english_words.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefencesService {
  static const _keyFavoritesList = 'FavoriteList';

  Future<void> saveFavorites(Favorites favorites) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setStringList(
        _keyFavoritesList, favorites.favoriteList.cast<String>());
    print("Save");
  }

  Future<Favorites> retreadeFavorites() async {
    final preferences = await SharedPreferences.getInstance();
    return null;
  }
}

class Favorites {
  final List<WordPair> favoriteList;
  Favorites({required this.favoriteList});
}
