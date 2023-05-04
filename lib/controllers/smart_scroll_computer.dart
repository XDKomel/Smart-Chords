import 'package:smart_chords/models/eyes_position.dart';
import 'dart:developer' as dev;

class SmartScrollComputer {
  EyesPosition? _centralPosition;
  static const double defDistance = 15;
  static const double coefficient = 4.2;
  double _prevPosition = 0;
  double _errorDistance = 0;
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
      _recomputeError(currentPosition);
    }
    final position = newScrollPosition == null
        ? _prevPosition + defDistance + _errorDistance
        : newScrollPosition + defDistance + _errorDistance;
    dev.log("Scroll position is $position");
    _prevPosition = position;
    return _prevPosition;
  }

  void _recomputeError(EyesPosition currentPosition) {
    final error = currentPosition - _centralPosition!;
    _errorDistance = coefficient * error / (_feedbackTime);
    dev.log("Error distance is $_errorDistance for error equal $error");
  }
}
