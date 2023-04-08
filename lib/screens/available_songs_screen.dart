import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/song_widget.dart';
import '../models/song_model.dart';

class AvailableSongsScreen extends ConsumerWidget {
  const AvailableSongsScreen(
      {super.key, required this.songsProvider, required this.cameraProvider});

  final Provider<Iterable<Map<String, dynamic>>> songsProvider;
  final Provider<CameraDescription> cameraProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songs = ref.watch(songsProvider);
    if (songs.isEmpty) {
      return const Center(
        child: Text("No internet connection"),
      );
    }
    return ListView(
      children: ListTile.divideTiles(
          context: context,
          tiles: songs.map((e) => SongWidget(
                song: SongModel(
                    author: e["author"],
                    content: e["content"],
                    name: e["name"]),
                cameraProvider: cameraProvider,
              ))).toList(),
    );
  }
}
