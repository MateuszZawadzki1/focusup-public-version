import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focus_up/features/ambient/data/models/ambient.dart';

class AmbientService {
  final FirebaseFirestore firebase;

  AmbientService({required this.firebase});

  Future<List<Ambient>> fetchAmbients() async {
    final snapshot = await firebase.collection('songs').get();
    log(snapshot.toString());
    final songsData =
        snapshot.docs.map((e) => Ambient.fromFirestore(e)).toList();
    log('Fetched Ambients: ${songsData.toString()}');
    return songsData;
  }
}
