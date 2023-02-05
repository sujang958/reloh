// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_unnecessary_containers

import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:volume_controller/volume_controller.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<StatefulWidget> createState() => ClockPageState();
}

class ClockPageState extends State<ClockPage> {
  @override
  void initState() {
    super.initState();

    // VolumeController().listener((_) => );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  print("White tapped");
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.blue.shade800, width: 12.0),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(47.5),
                          topRight: Radius.circular(47.5))),
                  child: Center(
                      child: Text(
                    "3:00",
                    style:
                        TextStyle(fontSize: 54.0, fontWeight: FontWeight.w700),
                  )),
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  print("White tapped");
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border:
                          Border.all(color: Colors.blue.shade800, width: 12.0),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(47.5),
                          bottomRight: Radius.circular(47.5))),
                  child: Center(
                      child: Text(
                    "3:00",
                    style: TextStyle(
                        fontSize: 54.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )),
                ),
              ),
              flex: 1,
            ),
          ]),
    );
  }
}

// todo: volumne controll to exit