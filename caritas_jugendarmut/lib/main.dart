import 'package:flutter/material.dart';

import 'package:caritas_jugendarmut/FinanceplannerWidget/widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexa',
      home: const FinanzplanerWidget(),
    );
  }
}
