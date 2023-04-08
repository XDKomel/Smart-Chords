import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_chords/internet_related/firebase/firebase_controller.dart';
import 'package:smart_chords/screens/available_songs_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final camera = await availableCameras().then((value) => value[1]);
  final songs = await FirebaseController().getData();
  final songsProvider = Provider((_) => songs);
  final cameraProvider = Provider((_) => camera);

  runApp(
    MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          textTheme: const TextTheme(
            displayLarge: TextStyle(
                fontSize: 64.0,
                letterSpacing: -0.03,
                fontWeight: FontWeight.w400),
            titleLarge: TextStyle(
                fontSize: 24.0,
                letterSpacing: -0.01,
                fontWeight: FontWeight.w600),
            bodyMedium: TextStyle(
                fontSize: 16.0,
                letterSpacing: -0.01,
                fontWeight: FontWeight.w500),
          )),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Songs"),
        ),
        body: ProviderScope(
            child: AvailableSongsScreen(
                songsProvider: songsProvider, cameraProvider: cameraProvider)),
      ),
    ),
  );
}
