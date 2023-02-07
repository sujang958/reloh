// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22.0,
                    vertical: 24.0,
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                      ),
                      Center(
                          child: Text(
                        "Chess Clock Presets",
                        style: TextStyle(
                            fontSize: 30.0,
                            fontVariations: [FontVariation("wght", 700)]),
                      )),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 26.0),
                      ),
                      GridView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 1,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 10,
                        ),
                        children: [
                          CupertinoButton(
                              color: Colors.black,
                              padding: EdgeInsets.zero,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("2m + 1s",
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  Text("delay: 15s",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.w500,
                                      ))
                                ],
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, "/clock");
                              })
                        ],
                      ),
                    ],
                  )))),
    );
  }
}

// todo: add a floating Button to add presets