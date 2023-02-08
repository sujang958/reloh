// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reloh/types/clock.dart';
import 'package:reloh/utils/store.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<StatefulWidget> createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  final Future<List<Clock>> clocks = getList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/add");
          },
          enableFeedback: false,
          backgroundColor: Colors.black,
          child: Icon(CupertinoIcons.add)),
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
                      FutureBuilder(
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CupertinoActivityIndicator();
                          }

                          return GridView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 2 / 1,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                            ),
                            children: [
                              for (final clock in snapshot.data as List<Clock>)
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/clock",
                                        arguments: clock);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        Text(
                                            "${clock.duration.inMinutes}m${clock.duration.inSeconds - clock.duration.inMinutes * 60 < 1 ? "" : "${clock.duration.inSeconds - clock.duration.inMinutes * 60}s"} + ${clock.increment}s",
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
                          );
                        },
                        future: clocks,
                      )
                    ],
                  )))),
    );
  }
}

// todo: add a floating Button to add presets