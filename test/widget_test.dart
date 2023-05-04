// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_chords/components/song_widget.dart';
import 'package:smart_chords/controllers/available_songs_list_controller.dart';
import 'package:smart_chords/controllers/smart_scroll_computer.dart';
import 'package:smart_chords/di.dart';
import 'package:smart_chords/internet_related/firebase/firebase_controller.dart';
import 'package:smart_chords/models/eyes_position.dart';
import 'package:smart_chords/models/song_model.dart';

import 'package:smart_chords/screens/main_screen.dart';
import 'package:smart_chords/screens/song_chords_screen.dart';

void main() {
  test(
      'Unit test of the updateList function in the AvailableSongsListController',
      () async {
    // Create the UNIT to test
    final controller = AvailableSongsListController();

    // Create a fake instance of the firebase firestore
    final instance = FakeFirebaseFirestore();

    // Fake the data
    const name = 'Вахтёрам';
    const author = 'Бумбокс';
    const content = 'Тебе не нравится дым';

    await instance
        .collection("songs")
        .add({'author': author, 'content': content, 'name': name});

    final songs = await controller.updateList(FirebaseController(instance));

    // The model we are gonna expect
    final song = SongModel(author: author, name: name, content: content);

    expect(song, songs.first);
  });

  test('Unit test of the SmartScrollComputer', () async {
    EyesPosition generateEyesPosition() {
      final random = Random();
      final leftEye = random.nextInt(20) + 90;
      final rightEye = random.nextInt(20) + 90;
      return EyesPosition(leftEye, rightEye);
    }

    // Create the UNIT to test
    final computer = SmartScrollComputer(5);
    computer.provideCentralPosition(generateEyesPosition());

    // We will check if the positions are generated correctly
    final List<double> positions = [];
    for (int i = 0; i < 20; i++) {
      double position = -1;
      if (i % 5 == 0 && i != 00) {
        if (i % 10 == 0) {
          position = computer.nextScrollPosition(generateEyesPosition(), 500);
        } else {
          position = computer.nextScrollPosition(generateEyesPosition());
        }
      } else {
        position = computer.nextScrollPosition(null);
      }
      positions.add(position);
    }

    // Check if the values were linearly generated before we provide the eyes data
    expect(positions[4], SmartScrollComputer.defDistance * 5);

    // Check if the value is not linear when the eyes are provided
    expect(positions[5], isNot(95.0));

    // Check if the scroll has moved when we provided our own value
    expect(positions[10], greaterThan(500));
  });

  // testWidgets('UI test of the full user flow including firebase',
  //     (WidgetTester tester) async {
  //   final instance = FakeFirebaseFirestore();
  //   await instance.collection("songs").add({
  //     'author': 'Бумбокс',
  //     'content': 'Тебе не нравится дым и чёрт с ним',
  //     'name': 'Вахтёрам'
  //   });
  //
  //   // Build our app with the fake provider
  //   await tester.pumpWidget(MaterialApp(
  //     home: ProviderScope(overrides: [
  //       DI.firebaseControllerProvider
  //           .overrideWith((_) => FirebaseController(instance))
  //     ], child: const MainScreen()),
  //   ));
  //
  //   // Expect to find the only song
  //   expect(find.text("Вахтёрам", skipOffstage: false), findsOneWidget);
  //   expect(find.text("Бумбокс", skipOffstage: false), findsOneWidget);
  //
  //   // Expect not to find some other songs
  //   expect(find.text("Егор Крид", skipOffstage: false), findsNothing);
  //
  //   // Open the song
  //   await tester.tap(find.text("Вахтёрам"));
  //   await tester.pump();
  //
  //   // Verify the lyrics is okay
  //   expect(find.text('Тебе не нравится дым и чёрт с ним'), findsOneWidget);
  // });

  testWidgets('UI test of a song widget', (tester) async {
    const name = 'Вахтёрам';
    const author = 'Бумбокс';
    const content = 'Тебе не нравится дым';

    final song = SongModel(author: author, name: name, content: content);

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: SongWidget(
          song: song,
        ),
      ),
    ));

    // Expect to find only the name and author on a widget, but not the lyrics
    expect(find.text(name), findsOneWidget);
    expect(find.text(author), findsOneWidget);
    expect(find.text(content), findsNothing);
  });

  testWidgets('UI test of a song\'s chords widget', (tester) async {
    const name = 'Вахтёрам';
    const author = 'Бумбокс';
    const content = 'Тебе не нравится дым';

    final song = SongModel(author: author, name: name, content: content);

    await tester.pumpWidget(MaterialApp(
      home: ProviderScope(
        child: Material(
          child: SongChordsScreen(
            song: song,
          ),
        ),
      ),
    ));

    // We have to find the song's lyrics on this screen, but not sure about its name or author
    expect(find.text(content), findsAtLeastNWidgets(1));
  });
}
