import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_chords/controllers/song_chords_controller.dart';

import '../models/song_model.dart';

class SongChordsScreen extends StatefulWidget {
  const SongChordsScreen({super.key, required this.camera, required this.song});

  final CameraDescription camera;
  final SongModel song;

  @override
  SongChordsScreenState createState() => SongChordsScreenState();
}

class SongChordsScreenState extends State<SongChordsScreen> {
  final controller = SongChordsController();

  @override
  void initState() {
    super.initState();
    controller.initState(widget.camera, mounted, true);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.song.name),
        ),
        body: FutureBuilder<void>(
          future: controller.initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                controller: controller.scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                    Text(
                      widget.song.content.replaceAll("\\n", '\n'),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
