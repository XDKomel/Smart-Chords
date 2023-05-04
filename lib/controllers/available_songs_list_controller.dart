import 'package:smart_chords/internet_related/firebase/firebase_controller.dart';
import 'package:smart_chords/models/song_model.dart';

import '../di.dart';
import 'dart:developer' as dev;

class AvailableSongsListController {
  Future<List<SongModel>> updateList(
      FirebaseController firebaseController) async {
    try {
      final newData = await firebaseController.getData();
      return newData
          .map((e) => SongModel(
              author: e["author"],
              content: e["content"].replaceAll("\\n", '\n'),
              name: e["name"]))
          .toList();
    } catch (e) {
      dev.log("Couldn't get songs from Firebase");
    }
    return [];
  }
}
