import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:caritas_jugendarmut/FinanceplannerWidget/widget.dart';

final ReceivePort port = ReceivePort();

void main() {
  runApp(const MyApp());
  HomeWidget.setAppGroupId('group.com.example.caritasJugendarmut');
  HomeWidget.registerInteractivityCallback(interactiveCallback);

  IsolateNameServer.registerPortWithName(
      port.sendPort, 'finanzplaner_widget_port');

  // Hören Sie auf Nachrichten vom anderen Isolat
  port.listen((message) {
    FinanzplanerWidgetNotifier().decrease(message);
  });
}

@pragma('vm:entry-point')
void interactiveCallback(Uri? uri) {
  final SendPort sendPort =
      IsolateNameServer.lookupPortByName('finanzplaner_widget_port')!;
  String uriString = uri?.toString() ?? '';
  RegExp regExp = RegExp(r'homewidgetcounter:\/\/(\d+)');
  Match? match = regExp.firstMatch(uriString);
  if (match != null) {
    String groupValue = match.group(1)!;
    sendPort.send(double.parse(groupValue));
  }
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
