import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_chords/models/AvailableSongsList.dart';

import '../internet_related/firebase/firebase_controller.dart';
import 'dart:developer' as dev;

class AvailableSongsListNotifier extends StateNotifier<AvailableSongsList> {
  AvailableSongsListNotifier() : super(const AvailableSongsList(songs: []));

  void updateList() async {
    try {
      final newData = await FirebaseController().getData();
      state = AvailableSongsList(songs: newData);
    } catch (e) {
      dev.log("Couldn't get songs from Firebase");
    }
  }

  AvailableSongsList getModel() {
    return state;
  }
}
