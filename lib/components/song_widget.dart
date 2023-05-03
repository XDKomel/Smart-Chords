import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/song_model.dart';
import '../screens/song_chords_screen.dart';

class SongWidget extends ConsumerWidget {
  const SongWidget({super.key, required this.song});

  final SongModel song;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(
        textAlign: TextAlign.start,
        song.name,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        textAlign: TextAlign.start,
        song.author,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProviderScope(
                    child: SongChordsScreen(
                      song: song,
                    ),
                  )),
        );
      },
    );
  }
}
