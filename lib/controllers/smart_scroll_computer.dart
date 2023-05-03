import 'package:smart_chords/models/eyes_position.dart';
import 'dart:developer' as dev;

class SmartScrollComputer {
  EyesPosition? _centralPosition;
  static const double defDistance = 15;
  static const double coefficient = 4.2;
  double prevPosition = 0;
  double errorDistance = 0;
  final int _feedbackTime;

  SmartScrollComputer(this._feedbackTime);

  void provideCentralPosition(EyesPosition centralPosition) {
    _centralPosition = centralPosition;
    dev.log(
        "Provided central position ${_centralPosition!.left}|${_centralPosition!.right}");
  }

  double nextScrollPosition(EyesPosition? currentPosition,
      [double? newScrollPosition]) {
    if (_centralPosition != null && currentPosition != null) {
      recomputeError(currentPosition);
    }
    final position = newScrollPosition == null
        ? prevPosition + defDistance + errorDistance
        : newScrollPosition + defDistance + errorDistance;
    dev.log("Scroll position is $position");
    prevPosition = position;
    return prevPosition;
  }

  void recomputeError(EyesPosition currentPosition) {
    final error = currentPosition - _centralPosition!;
    errorDistance = coefficient * error / (_feedbackTime);
    dev.log("Error distance is $errorDistance for error equal $error");
  }
}
