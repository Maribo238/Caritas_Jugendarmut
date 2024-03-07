import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:caritas_jugendarmut/FinanceplannerWidget/widget.dart';

void main() async {
  runApp(const MyApp());

  await HomeWidget.setAppGroupId('group.com.example.caritasJugendarmut');
  await HomeWidget.registerInteractivityCallback(interactiveCallback);
}

@pragma('vm:entry-point')
Future<void> interactiveCallback(Uri? uri) async {
  print('Received Uri: $uri');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexa',
      home: FinanzplanerWidget(),
    );
  }
}
