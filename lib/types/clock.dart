import "dart:typed_data";

import "package:msgpack_dart/msgpack_dart.dart" as msgpack;
import "package:reloh/utils/duration.dart";

enum ChessColor {
  white,
  black,
}

// ignore: constant_identifier_names
const DIVIDER = "\u0000";

class Clock {
  final Duration duration;
  final int increment;
  final double id;

  Clock({required this.duration, required this.increment, required this.id});

  factory Clock.fromMsgPack(String msgPackString) {
    final clock = msgpack.deserialize(Uint8List.fromList(
        msgPackString.split(DIVIDER).map((e) => int.parse(e)).toList()));

    return Clock(
        id: clock["id"],
        duration: parseDuration(clock["duration"]),
        increment: clock["increment"]);
  }

  String toMsgPack() {
    return msgpack.serialize({
      "duration": duration.toString(),
      "increment": increment,
      "id": id
    }).join(DIVIDER);
  }

  String get type {
    final minutes = duration.inMinutes;

    if (minutes < 3) {
      return "Bullet";
    } else if (minutes < 10) {
      return "Blitz";
    } else {
      return "Rapid";
    }
  }
}
