import 'package:flutter/material.dart';
import 'package:ta_mdp/pages/splash_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Stocks Exchange Center",
      initialRoute: '/',
      routes: {
        '/': (context) => const Splash(),
      },
    );
  }
}
