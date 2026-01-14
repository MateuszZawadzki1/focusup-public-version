import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focus_up/features/focus/data/models/focus.dart';

class FocusService {
  final FirebaseFirestore firebase;

  FocusService({required this.firebase});

  Future<List<FocusModel>> fetchFocusMethods() async {
    final snapshot = await firebase.collection('foci').get();
    final fociData =
        snapshot.docs.map((e) => FocusModel.fromFirestore(e)).toList();
    return fociData;
  }
}
