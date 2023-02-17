// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reloh/types/clock.dart';
import 'package:reloh/utils/store.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<StatefulWidget> createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  Future<List<Clock>> clocks = getList();

  Future<bool> _launchUrl(String url) async {
    return await launchUrlString(url);
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);

              _launchUrl("https://reloh-pp.netlify.app/").then((value) {
                if (value) return;

                _showAlert(context, "Error",
                    "Cannot open the privacy policy website due to the error. Please Visit https://reloh-pp.netlify.app yourself");
              });
            },
            child: const Text('Reloh\'s Privacy Policy'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              showLicensePage(context: context);
            },
            child: const Text('Open Source Licenses'),
          ),
        ],
      ),
    );
  }

  void _showAlert(BuildContext context, String title, String content) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('ok'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/add").then((newClock) {
              if (newClock == null) return;

              setState(() {
                clocks = getList();
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text('Added a new clock')));
              });
            });
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Your Clocks",
                            style: TextStyle(
                                fontSize: 30.0,
                                fontVariations: [FontVariation("wght", 700)]),
                          ),
                          IconButton(
                              enableFeedback: false,
                              onPressed: () {
                                _showActionSheet(context);
                              },
                              icon: Icon(CupertinoIcons.info))
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 26.0),
                      ),
                      FutureBuilder(
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CupertinoActivityIndicator();
                          }

                          final clocks = snapshot.data as List<Clock>;

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
                            children: clocks.isEmpty
                                ? [SizedBox.shrink()]
                                : [
                                    for (final clock in clocks)
                                      Dismissible(
                                          key: Key(clock.id.toString()),
                                          onDismissed:
                                              (DismissDirection direction) {
                                            setState(() {
                                              removeClock(clock.id);
                                              snapshot.data?.removeWhere(
                                                  (element) =>
                                                      element.id == clock.id);
                                            });
                                          },
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, "/clock",
                                                  arguments: clock);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 16.0,
                                                  horizontal: 20.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(clock.type,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontSize: 30.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      )),
                                                  Text(
                                                      "${clock.duration.inMinutes}m${clock.duration.inSeconds - clock.duration.inMinutes * 60 < 1 ? "" : "${clock.duration.inSeconds - clock.duration.inMinutes * 60}s"} + ${clock.increment}s",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ))
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