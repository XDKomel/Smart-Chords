import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_chords/models/AvailableSongsList.dart';

import '../controllers/available_songs_list_notifier.dart';
import '../components/song_widget.dart';
import '../models/song_model.dart';

class AvailableSongsScreen extends ConsumerStatefulWidget {
  const AvailableSongsScreen(
      {super.key, required this.songsProvider, required this.camera});

  final StateNotifierProvider<AvailableSongsListNotifier, AvailableSongsList>
      songsProvider;
  final CameraDescription camera;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      AvailableSongsScreenState();
}

class AvailableSongsScreenState extends ConsumerState<AvailableSongsScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(widget.songsProvider.notifier).updateList();
  }

  @override
  Widget build(BuildContext context) {
    final songs = ref.watch(widget.songsProvider);
    if (songs.songs.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("No internet connection"),
            ElevatedButton(
                onPressed: () {
                  ref.read(widget.songsProvider.notifier).updateList();
                },
                child: const Text("Refresh"))
          ],
        ),
      );
    }
    return ListView(
      children: ListTile.divideTiles(
          context: context,
          tiles: songs.songs.map((e) => SongWidget(
                song: SongModel(
                    author: e["author"],
                    content: e["content"],
                    name: e["name"]),
                camera: widget.camera,
              ))).toList(),
    );
  }
}
