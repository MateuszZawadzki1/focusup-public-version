import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focus_up/features/stats/domain/models/listening_history.dart';

class ListeningHistoryModel extends ListeningHistory {
  ListeningHistoryModel({required super.ambientSetId, required super.tags});

  factory ListeningHistoryModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return ListeningHistoryModel(
      ambientSetId: data?['ambientsetid'],
      tags: List<String>.from(data?['tags']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {'ambientsetid': ambientSetId, 'tags': tags};
  }
}
