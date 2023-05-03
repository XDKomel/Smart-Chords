import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_chords/controllers/song_chords_controller.dart';

import '../di.dart';
import '../models/song_model.dart';

class SongChordsScreen extends ConsumerStatefulWidget {
  const SongChordsScreen({super.key, required this.song});

  final SongModel song;

  @override
  SongChordsScreenState createState() => SongChordsScreenState();
}

class SongChordsScreenState extends ConsumerState<SongChordsScreen> {
  late final SongChordsController controller;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = SongChordsController(scrollController);
    initCamera();
    controller.initState(ref.read(DI.centerPositionProvider.notifier));
  }

  void initCamera() async {
    final camera = await availableCameras().then((value) => value[1]);
    ref.read(DI.cameraProvider.notifier).state = camera;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final initialFreeSpace = MediaQuery.of(context).size.height / 3;
    final screenWidth = MediaQuery.of(context).size.width;
    final camera = ref.watch(DI.cameraProvider);
    controller.provideCamera(camera);
    return Stack(children: [
      Scaffold(
          appBar: AppBar(
            title: Text(widget.song.name),
          ),
          body: FutureBuilder<void>(
            future: controller.initializeControllerFuture,
            builder: (context, snapshot) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: initialFreeSpace,
                      ),
                      Text(
                        widget.song.content,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
      AnimatedOpacity(
        opacity:
            camera != null && !ref.watch(DI.centerPositionProvider) ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: Column(
          children: [
            SizedBox(height: initialFreeSpace),
            Container(
              width: screenWidth,
              height: 4,
              color: Colors.redAccent,
            )
          ],
        ),
      )
    ]);
  }
}
