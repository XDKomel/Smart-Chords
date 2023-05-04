import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseController {
  final FirebaseFirestore _firestoreInstance;

  FirebaseController(this._firestoreInstance);

  Future<Iterable<Map<String, dynamic>>> getData() async {
    return await _firestoreInstance.collection("songs").get().then((value) {
      return value.docs.map((e) => e.data());
    });
  }
}
