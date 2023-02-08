// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_unnecessary_containers

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reloh/types/clock.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class ClockPage extends StatefulWidget {
  final Clock arguments;

  const ClockPage({super.key, required this.arguments});

  @override
  State<StatefulWidget> createState() => ClockPageState();
}

class ClockPageState extends State<ClockPage> {
  final ended = ValueNotifier(false);

  late final whiteClock = ValueNotifier(widget.arguments.duration);
  late final blackClock = ValueNotifier(widget.arguments.duration);
  late final Timer timer;

  ChessColor turn = ChessColor.white;
  ChessColor? winner;

  @override
  void initState() {
    super.initState();

    whiteClock.addListener(() {
      _checkTimeout(whiteClock.value, ChessColor.black);
    });
    blackClock.addListener(() {
      _checkTimeout(blackClock.value, ChessColor.white);
    });

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final subtractedDuration =
          (turn == ChessColor.white ? whiteClock : blackClock).value.inSeconds -
              1;
      final duration = (subtractedDuration < 0 ? 0 : subtractedDuration);

      setState(() {
        if (turn == ChessColor.white) {
          whiteClock.value = Duration(seconds: duration);
        } else {
          blackClock.value = Duration(seconds: duration);
        }
      });
    });
  }

  void _checkTimeout(Duration clock, ChessColor winner) {
    if (clock.inMilliseconds > 0) return;

    _endClock(winner);
  }

  void _endClock(ChessColor winner) {
    ended.value = true;
    this.winner = winner;
    timer.cancel();

    showCupertinoDialog(
        context: context,
        builder: (context) => Container(
            color: Colors.black54,
            child: DefaultTextStyle(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${winner.toString().split(".").last.capitalize()} Won",
                      style: TextStyle(
                          fontSize: 42.0, fontWeight: FontWeight.w700)),
                  Text("by timeout",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w500)),
                  Padding(padding: EdgeInsets.symmetric(vertical: 24.0)),
                  CupertinoButton(
                      color: Colors.blue.shade700,
                      child: Text("Back to the list"),
                      onPressed: () {
                        Navigator.pushNamed(context, "/");
                      })
                ],
              ),
              style: TextStyle(
                  fontFamily: "Pretendard",
                  color: Colors.white,
                  decoration: TextDecoration.none),
            )));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClockArea(
              active: turn == ChessColor.white,
              color: Colors.white,
              time: whiteClock,
              onTap: () {
                setState(() {
                  turn = ChessColor.black;
                  whiteClock.value = Duration(
                      seconds: whiteClock.value.inSeconds +
                          widget.arguments.increment);
                });
              },
            ),
            ClockArea(
              active: turn == ChessColor.black,
              color: Colors.black,
              textColor: Colors.white,
              time: blackClock,
              onTap: () {
                setState(() {
                  turn = ChessColor.white;
                  blackClock.value = Duration(
                      seconds: blackClock.value.inSeconds +
                          widget.arguments.increment);
                });
              },
            ),
          ]),
    );
  }
}

class ClockArea extends StatefulWidget {
  final Color color;
  final Color textColor;
  final bool active;
  final ValueNotifier<Duration> time;
  final VoidCallback onTap;

  const ClockArea({
    super.key,
    required this.color,
    required this.active,
    required this.time,
    required this.onTap,
    this.textColor = Colors.black,
  });

  @override
  State<StatefulWidget> createState() => ClockAreaState();
}

class ClockAreaState extends State<ClockArea> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onTap();
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
          decoration: BoxDecoration(
            color: widget.color,
            border: Border.all(
                color:
                    widget.active ? Colors.blue.shade800 : Colors.transparent,
                width: 10.0),
          ),
          child: Center(
              //"${widget.time.value.inMinutes < 10 ? "0${widget.time.value.inMinutes}" : "${widget.time.value.inMinutes}"}:${widget.time.value.inSeconds - widget.time.value.inMinutes * 60 < 10 ? "0${widget.time.value.inSeconds - widget.time.value.inMinutes * 60}" : "${widget.time.value.inSeconds - widget.time.value.inMinutes * 60}"}"
              child: Text(
            widget.time.value.toString().split(".")[0],
            style: TextStyle(
                fontSize: 54.0,
                fontWeight: FontWeight.w700,
                color: widget.textColor),
          )),
        ),
      ),
      flex: 1,
    );
  }
}
