import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import './firebase_options.dart';

class FirebaseController {
  FirebaseController();
  Future<Iterable<Map<String, dynamic>>> getData() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final db = FirebaseFirestore.instance;
    return await db.collection("songs").get().then((value) {
      return value.docs.map((e) => e.data());
    });
  }
}
