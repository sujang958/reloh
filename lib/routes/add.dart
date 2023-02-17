// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

// todo: add vibration when almost timeout

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
                      "Set your clock's Duration",
                      style: TextStyle(
                          fontSize: 36.0, fontWeight: FontWeight.w700),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 80.0),
                    ),
                    Expanded(
                      flex: 1,
                      child: DurationPicker(
                          onChange: (nextDuration) {
                            setState(() {
                              duration = nextDuration;
                            });
                          },
                          snapToMins: 1.0,
                          duration: duration,
                          baseUnit: BaseUnit.minute),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.0),
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        height: 62.0,
                        child: CupertinoButton(
                          onPressed: () {
                            pageController.animateToPage(1,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          },
                          color: Colors.blue.shade800,
                          child: const Text(
                            "Go to the Next Step",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ))
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
                      "Set your clock's Increment",
                      style: TextStyle(
                          fontSize: 36.0, fontWeight: FontWeight.w700),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 80.0),
                    ),
                    Expanded(
                      flex: 1,
                      child: DurationPicker(
                          onChange: (nextDuration) {
                            setState(() {
                              increment = nextDuration;
                            });
                          },
                          snapToMins: 1.0,
                          duration: increment,
                          baseUnit: BaseUnit.second),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.0),
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        height: 62.0,
                        child: CupertinoButton(
                          onPressed: () {
                            _finish();
                          },
                          color: Colors.blue.shade800,
                          child: Text(
                            "Finish",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ))
                  ]))
        ])));
  }
}

// todo: add a floating Button to add presets