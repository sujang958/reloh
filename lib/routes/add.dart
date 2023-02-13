// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:ui';

import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reloh/utils/store.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<StatefulWidget> createState() => AddPageState();
}

class AddPageState extends State<AddPage> {
  Duration duration = Duration(minutes: 0);
  Duration increment = Duration(seconds: 0);

  final pageController = PageController();

  void _finish() async {
    final id = await getAvailableId();

    final newClock = await addClock(id, duration, increment.inSeconds);

    Navigator.pop(context, newClock);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                pageSnapping: false,
                children: [
          Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28.0,
                vertical: 36.0,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 26.0),
                    ),
                    Text(
                      "Set clock's Duration",
                      style: TextStyle(
                          fontSize: 32.0, fontWeight: FontWeight.w700),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.0),
                    ),
                    DurationPicker(
                        onChange: (nextDuration) {
                          setState(() {
                            duration = nextDuration;
                          });
                        },
                        snapToMins: 1.0,
                        duration: duration,
                        baseUnit: BaseUnit.minute),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.0),
                    ),
                    CupertinoButton(
                      child: Text("Go to the Next Step"),
                      onPressed: () {
                        pageController.animateToPage(1,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      },
                      color: Colors.blue.shade800,
                    ),
                  ])),
          Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28.0,
                vertical: 36.0,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 26.0),
                    ),
                    Text(
                      "Set clock's Increment",
                      style: TextStyle(
                          fontSize: 32.0, fontWeight: FontWeight.w700),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.0),
                    ),
                    DurationPicker(
                        onChange: (nextDuration) {
                          setState(() {
                            increment = nextDuration;
                          });
                        },
                        snapToMins: 1.0,
                        duration: increment,
                        baseUnit: BaseUnit.second),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.0),
                    ),
                    CupertinoButton(
                      child: Text("Finish"),
                      onPressed: () {
                        _finish();
                      },
                      color: Colors.blue.shade800,
                    ),
                  ]))
        ])));
  }
}

// todo: add a floating Button to add presets