import 'package:caritas_jugendarmut/big_card.dart';
import 'package:caritas_jugendarmut/my_app_state.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  final username = 'username';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.onPrimary);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            color: theme.colorScheme.primary,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Settings",
                style: style,
              ),
            ),
          ),
        ),
        ListView(),
      ],
    );
  }
}
