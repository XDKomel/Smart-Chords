import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseController {
  FirebaseController();
  Future<Iterable<Map<String, dynamic>>> getData() async {
    final db = FirebaseFirestore.instance;
    return await db.collection("songs").get().then((value) {
      return value.docs.map((e) => e.data());
    });
  }
}
