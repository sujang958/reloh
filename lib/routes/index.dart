// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reloh/types/clock.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<StatefulWidget> createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 36.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 26.0),
                      ),
                      Text(
                        "Your Clocks",
                        style: TextStyle(
                            fontSize: 30.0,
                            fontVariations: [FontVariation("wght", 700)]),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 26.0),
                      ),
                      GridView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 2 / 1,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/clock",
                                  arguments: ClockScreenArguments(
                                      increment: 1,
                                      time: Duration(minutes: 1)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Bullet",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 30.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  Text("3m 30s + 1s",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )))),
    );
  }
}

// todo: add a floating Button to add presets