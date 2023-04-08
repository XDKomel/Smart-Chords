import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_chords/models/AvailableSongsList.dart';
import 'package:smart_chords/screens/available_songs_screen.dart';

import 'controllers/available_songs_list_notifier.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final camera = await availableCameras().then((value) => value[1]);
  final songsProvider =
      StateNotifierProvider<AvailableSongsListNotifier, AvailableSongsList>(
          (_) => AvailableSongsListNotifier());

  runApp(
    MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          brightness: Brightness.light,
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
                songsProvider: songsProvider, camera: camera)),
      ),
    ),
  );
}
