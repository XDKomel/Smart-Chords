import 'dart:async';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_chords/controllers/smart_scroll_computer.dart';

import '../internet_related/eye_tracker.dart';
import '../internet_related/imgbb.dart';
import '../models/eyes_position.dart';
import 'dart:developer' as dev;

class SongChordsController {
  CameraController? _camera;
  late final ScrollController _scrollController;
  Future<void>? initializeControllerFuture;
  late Timer _photoTimer;
  final _imgbb = IMGBB();
  final _tracker = EyeTracker();
  EyesPosition? centralPosition;
  final bool mock;
  final SmartScrollComputer _smartScrollComputer = SmartScrollComputer(5);

  SongChordsController(this._scrollController, {this.mock = false});

  void initState(StateController<bool> centralPositionState) async {
    _photoTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_scrollController.hasClients) {
        EyesPosition? currentPosition;
        if (centralPosition == null && timer.tick % 3 == 0 && timer.tick > 1) {
          centralPosition = await processPhoto();
          dev.log(
              "Central position ${centralPosition?.left}|${centralPosition?.right}");
          if (centralPosition != null) {
            _smartScrollComputer.provideCentralPosition(centralPosition!);
            centralPositionState.state = true;
          }
        } else if (centralPosition != null &&
            timer.tick % 5 == 0 &&
            timer.tick > 4) {
          currentPosition = await processPhoto();
        }
        double position = _smartScrollComputer.nextScrollPosition(
            currentPosition, _scrollController.position.pixels);
        _scrollController.animateTo(position,
            duration: const Duration(milliseconds: 1000), curve: Curves.linear);
      }
    });
  }

  void provideCamera(CameraDescription? camera) async {
    if (camera != null) {
      _camera =
          CameraController(camera, ResolutionPreset.low, enableAudio: false);
      _camera!.setFlashMode(FlashMode.off);
      initializeControllerFuture = _camera!.initialize();
    }
  }

  Future<EyesPosition?> processPhoto() async {
    if (mock) {
      final position = Random().nextInt(20);
      return EyesPosition(position, position);
    } else if (_camera == null) {
      return null;
    }
    try {
      await initializeControllerFuture;
      final image = await _camera!.takePicture();
      final link = await _imgbb.getImageLink(image.path, "60");
      if (link != null) {
        final position = await _tracker.getEyesPosition(link);
        dev.log("Eyes position ${position!.left}|${position.right}");
        return position;
      }
    } catch (e) {
      dev.log("Error while processing photo");
    }
    return null;
  }

  void dispose() {
    _camera?.dispose();
    _scrollController.dispose();
    _photoTimer.cancel();
  }
}
