import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'internet_related/firebase/firebase_controller.dart';
import 'models/song_model.dart';

class DI {
  static final cameraProvider =
      StateProvider<CameraDescription?>((ref) => null);

  static final songsProvider = StateProvider<List<SongModel>?>((ref) => null);

  static final centerPositionProvider = StateProvider<bool>((ref) => false);

  static final firestoreInstanceProvider =
      Provider((ref) => FirebaseFirestore.instance);

  static final firebaseControllerProvider = Provider(
      (ref) => FirebaseController(ref.read(firestoreInstanceProvider)));
}
