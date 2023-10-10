//import 'dart:html';
//import 'dart:js_util';
//Shared_Prefrences: flutter pub add shared_prefrences

import 'package:caritas_jugendarmut/pages/favorites_page.dart';
import 'package:caritas_jugendarmut/pages/generator_page.dart';
import 'package:caritas_jugendarmut/my_app_state.dart';
import 'package:caritas_jugendarmut/pages/new_page.dart';
import 'package:caritas_jugendarmut/pages/setting_page.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 34, 174, 255)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  Widget page = GeneratorPage();

  void selectPage() {
    switch (selectedIndex) {
      case 1:
        page = GeneratorPage();
      case 0:
        page = FavoritesPage();
      case 2:
        page = NewPage();
      default:
        throw UnimplementedError('No Widget for $selectedIndex');
    }
  }

  @override
  Widget build(BuildContext context) {
    selectPage();
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Column(children: [
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),
          ),
          SafeArea(
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: "Favorites",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Settings",
                ),
              ],
              currentIndex: selectedIndex,
              onTap: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
          //Falls über Laptop: Navigations Rail sinnvoll!
        ]),
      );
    });
  }
}
