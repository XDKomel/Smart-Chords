import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/song_model.dart';
import '../screens/song_chords_screen.dart';

class SongWidget extends ConsumerWidget {
  const SongWidget(
      {super.key, required this.song, required this.cameraProvider});

  final SongModel song;
  final Provider<CameraDescription> cameraProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final camera = ref.watch(cameraProvider);
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
