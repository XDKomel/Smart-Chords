import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import 'available_songs_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("title".i18n()),
        ),
        body: const AvailableSongsScreen(),
      );
}
