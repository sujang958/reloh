import 'package:flutter/material.dart';
import 'package:reloh/routes/clock.dart';
import 'package:reloh/routes/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reloh',
      theme: ThemeData(fontFamily: "Pretendard"),
      routes: {
        "/": (context) => IndexPage(),
        "/clock": (context) => ClockPage(),
      },
      initialRoute: "/",
    );
  }
}
