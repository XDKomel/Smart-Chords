import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/available_songs_list_controller.dart';
import '../components/song_widget.dart';
import '../di.dart';

class AvailableSongsScreen extends ConsumerStatefulWidget {
  const AvailableSongsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      AvailableSongsScreenState();
}

class AvailableSongsScreenState extends ConsumerState<AvailableSongsScreen> {
  final controller = AvailableSongsListController();

  @override
  void initState() {
    super.initState();
    updateList();
  }

  Future<void> updateList() async {
    ref.read(DI.songsProvider.notifier).state = await controller.updateList();
  }

  @override
  Widget build(BuildContext context) {
    final songs = ref.watch(DI.songsProvider);
    if (songs == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (songs.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("No internet connection"),
            ElevatedButton(
                onPressed: () {
                  updateList();
                },
                child: const Text("Refresh"))
          ],
        ),
      );
    }
    return ListView(
        children: ListTile.divideTiles(
                context: context,
                tiles: songs.map((song) => SongWidget(song: song)).toList())
            .toList());
  }
}
