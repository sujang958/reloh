import 'package:flutter/material.dart';
import 'package:reloh/routes/clock.dart';
import 'package:reloh/routes/index.dart';
import 'package:reloh/types/clock.dart';

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
      onGenerateRoute: (RouteSettings settings) {
        final routes = <String, WidgetBuilder>{
          "/": (context) => const IndexPage(),
          "/clock": (context) =>
              ClockPage(arguments: settings.arguments as ClockScreenArguments),
        };

        WidgetBuilder builder =
            routes[settings.name] as WidgetBuilder; // todo: create 404 page

        return MaterialPageRoute(builder: (context) => builder(context));
      },
      initialRoute: "/",
    );
  }
}
