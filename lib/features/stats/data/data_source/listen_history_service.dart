import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focus_up/features/stats/data/models/listening_history_model.dart';
import 'package:focus_up/features/stats/domain/models/listening_history.dart';

class ListeningHistoryService {
  final FirebaseFirestore firebase;

  ListeningHistoryService({required this.firebase});

  Future<List<ListeningHistory>> fetchListeningHistory() async {
    final snapshot = await firebase.collection('listening-history').get();
    final lhData =
        snapshot.docs
            .map((e) => ListeningHistoryModel.fromFirestore(e))
            .toList();
    log('Listening history: ${lhData.toString()}');
    return lhData;
  }

  Future<void> addListeningHistory(
    ListeningHistoryModel listeningHistory,
  ) async {
    final data = listeningHistory.toFirestore();
    log('Adding history to db...');
    await firebase.collection('listening-history').add(data);
  }
}
