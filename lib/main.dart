import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_chords/screens/available_songs_screen.dart';

Future<void> main() async {
  runApp(
    MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          useMaterial3: true,
          brightness: Brightness.light),
      darkTheme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          useMaterial3: true,
          brightness: Brightness.dark),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Songs"),
        ),
        body: const ProviderScope(child: AvailableSongsScreen()),
      ),
    ),
  );
}
