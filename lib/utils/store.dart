import 'dart:math';

import 'package:reloh/types/clock.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:msgpack_dart/msgpack_dart.dart" as msgpack;

// ignore: constant_identifier_names
const CLOCKS_KEY = "clocks";

Future<SharedPreferences> getInstance() async {
  return await SharedPreferences.getInstance();
}

Future<List<Clock>> getList() async {
  final instance = await getInstance();

  final clocks = instance
      .getStringList(CLOCKS_KEY)
      ?.map((e) => Clock.fromMsgPack(e))
      .toList();

  return clocks ?? [];
}

Future<Clock> addClock(double id, Duration duration, int increment) async {
  final instance = await getInstance();
  final clock = Clock(id: id, duration: duration, increment: increment);

  instance.setStringList(CLOCKS_KEY,
      [...(instance.getStringList(CLOCKS_KEY) ?? []), clock.toMsgPack()]);

  return clock;
}

/// If it successfully removed a clock, returns "true".
Future<bool> removeClock(double id) async {
  final instance = await getInstance();
  final clocks = await getList();

  if (clocks.isEmpty) return false;

  clocks.removeWhere((clock) => clock.id == id);

  instance.setStringList(CLOCKS_KEY, clocks.map((e) => e.toMsgPack()).toList());

  return true;
}

Future<bool> checkDuplicated(double id) async {
  final clocks = await getList();

  if (clocks.where((clock) => clock.id == id).isEmpty) {
    return false;
  } else {
    return true;
  }
}

Future<double> getAvailableId() async {
  double id = Random().nextDouble();
  while (true) {
    if (!(await checkDuplicated(id))) break;
    id = Random().nextDouble();
  }

  return id;
}
