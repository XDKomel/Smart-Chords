import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../models/song_model.dart';
import '../screens/song_chords_screen.dart';

class SongWidget extends StatelessWidget {
  const SongWidget({super.key, required this.song, required this.camera});

  final SongModel song;
  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        textAlign: TextAlign.start,
        song.name,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        textAlign: TextAlign.start,
        song.author,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SongChordsScreen(
                    camera: camera,
                    song: song,
                  )),
        );
      },
    );
  }
}
