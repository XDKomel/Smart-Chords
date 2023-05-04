class SongModel {
  String author;
  String content;
  String name;

  SongModel({required this.author, required this.content, required this.name});

  @override
  bool operator ==(Object other) {
    if (other is SongModel) {
      return other.name == name &&
          other.content == content &&
          other.author == author;
    }
    return false;
  }
}
