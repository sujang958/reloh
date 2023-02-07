enum ChessColor {
  white,
  black,
}

class ClockScreenArguments {
  final Duration time;
  final int increment;

  ClockScreenArguments({required this.time, required this.increment});
}
