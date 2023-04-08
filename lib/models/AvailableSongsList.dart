import 'package:flutter/cupertino.dart';

@immutable
class AvailableSongsList {
  const AvailableSongsList({required this.songs});

  final Iterable<Map<String, dynamic>> songs;
}
