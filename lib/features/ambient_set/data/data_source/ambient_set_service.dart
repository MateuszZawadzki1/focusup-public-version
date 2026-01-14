import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focus_up/features/ambient_set/data/models/ambient_set.dart';
import 'package:focus_up/features/ambient_set/data/models/set_image.dart';

class AmbientSetService {
  final FirebaseFirestore firebase;

  AmbientSetService({required this.firebase});

  Future<List<AmbientSet>> fetchAmbientSets() async {
    final snapshot = await firebase.collection('sets').get();
    final setsData =
        snapshot.docs.map((e) => AmbientSet.fromFirestore(e)).toList();
    log('Ambient sets data: ${setsData.toString()}');
    return setsData;
  }

  Future<void> addAmbientSets(AmbientSet ambientSet) async {
    final data = ambientSet.toFirestore();
    await firebase.collection('sets').add(data);
    log('Proba dodania setu do bazy');
  }

  Future<List<AmbientSet>> fetchFavAmbientSets() async {
    final snapshot =
        await firebase
            .collection('sets')
            .orderBy('timestamp', descending: true)
            .limit(6)
            .get();
    final favSetsData =
        snapshot.docs.map((e) => AmbientSet.recentlyFromFirestore(e)).toList();
    log('Fav Ambient sets data: ${favSetsData.toString()}');
    return favSetsData;
  }

  Future<void> updateSetName(String id, String name) async {
    await firebase.collection('sets').doc(id).update({"name": name});
  }

  Future<void> updateSetTimestamp(String id) async {
    await firebase.collection('sets').doc(id).update({
      'timestamp': Timestamp.fromDate(DateTime.now()),
    });
  }

  Future<List<SetImage>> fetchSetImages() async {
    final snapshot = await firebase.collection('images').get();
    log(snapshot.docs.toString());
    final imagesData =
        snapshot.docs.map((e) => SetImage.fromFirestore(e)).toList();
    log('Ambient Images data: $imagesData');
    return imagesData;
  }

  Future<void> updatePlayCounter(String id) async {
    await firebase.collection('sets').doc(id).update({
      'playcount': FieldValue.increment(1),
    });
  }
}
