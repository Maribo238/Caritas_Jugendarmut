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
                    "Settings",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary),
                  )),

              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: Card(
              //     color: theme.colorScheme.primary,
              //     child: Padding(
              //       padding: EdgeInsets.all(20),
              //       child: Text(
              //         "Settings",
              //         style: style,
              //       ),
              //     ),
              //   ),
              // ),
              ListView(),
            ],
          ),
        ),
      ],
    );
  }
}
