import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/song_model.dart';

class DI {
  static final cameraProvider =
      StateProvider<CameraDescription?>((ref) => null);

  static final songsProvider = StateProvider<List<SongModel>?>((ref) => null);

  static final centerPositionProvider = StateProvider<bool>((ref) => false);
}
