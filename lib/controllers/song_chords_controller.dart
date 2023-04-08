import 'dart:async';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

import '../internet_related/eye_tracker.dart';
import '../internet_related/imgbb.dart';
import '../models/eyes_position.dart';
import 'dart:developer' as dev;

class SongChordsController {
  late CameraController _camera;
  late ScrollController scrollController;
  late Future<void> initializeControllerFuture;
  late Timer _photoTimer;
  final imgbb = IMGBB();
  final tracker = EyeTracker();
  EyesPosition? centralPosition;

  void initState(CameraDescription camera, bool mounted, [bool mock = false]) {
    _camera =
        CameraController(camera, ResolutionPreset.medium, enableAudio: false);
    initializeControllerFuture = _camera.initialize();
    scrollController = ScrollController();
    _photoTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final currentPosition = scrollController.position.pixels;
      double coeff = 0;
      if (centralPosition == null) {
        centralPosition = await processPhoto(mounted, mock);
      } else if (timer.tick % 5 == 0 && timer.tick > 4) {
        final eyes = await processPhoto(mounted, mock);
        if (eyes != null) {
          coeff = eyes - centralPosition!;
        }
      }
      if (scrollController.hasClients) {
        scrollController.animateTo(currentPosition + 10 * exp(coeff / 10),
            duration: const Duration(milliseconds: 1000), curve: Curves.linear);
      }
    });
  }

  Future<EyesPosition?> processPhoto(bool mounted, [bool mock = false]) async {
    if (mock) {
      final position = Random().nextInt(20);
      return EyesPosition(position, position);
    }
    try {
      await initializeControllerFuture;
      final image = await _camera.takePicture();
      if (!mounted) {
        return null;
      }
      final link = await imgbb.getImageLink(image.path, "5");
      if (link != null) {
        return await tracker.getEyesPosition(link);
      }
    } catch (e) {
      dev.log("Error while processing photo in the widget:");
      dev.log("$e");
    }
    return null;
  }

  void dispose() {
    _camera.dispose();
    scrollController.dispose();
    _photoTimer.cancel();
  }
}
