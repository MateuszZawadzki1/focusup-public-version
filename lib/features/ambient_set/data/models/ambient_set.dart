import 'package:cloud_firestore/cloud_firestore.dart';

class AmbientSet {
  final String name;
  List<Map<String, dynamic>>? ambients;
  String image;
  Timestamp timestamp;
  String? id;
  int playCount;
  List<String> tags;

  AmbientSet({
    required this.name,
    required this.ambients,
    required this.image,
    this.id,
    required this.timestamp,
    this.playCount = 0,
    required this.tags,
  });
  AmbientSet.database({
    required this.name,
    required this.ambients,
    required this.image,
    required this.timestamp,
    this.id,
    this.playCount = 0,
    required this.tags,
  });
  AmbientSet.favSet({
    required this.name,
    required this.ambients,
    required this.image,
    required this.id,
    required this.timestamp,
    this.playCount = 0,
    required this.tags,
  });

  factory AmbientSet.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    final ambientsList = List<Map<String, dynamic>>.from(data?['urls'] ?? []);
    return AmbientSet.database(
      id: snapshot.id,
      name: data?['name'],
      ambients: ambientsList,
      image: data?['image'],
      timestamp: data?['timestamp'],
      playCount: data?['playcount'] ?? 0,
      tags:
          (data?['tags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'urls': ambients,
      'image': image,
      'timestamp': timestamp,
      'playcount': playCount,
      'tags': tags,
    };
  }

  // Recently played
  factory AmbientSet.recentlyFromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    final ambientsList = List<Map<String, dynamic>>.from(
      data?['urls'] ?? [], // Sprawdzic potem dzialanie
    );
    return AmbientSet.favSet(
      name: data?['name'],
      ambients: ambientsList, //data?['urls'],
      image: data?['image'],
      id: snapshot.id,
      timestamp: data?['timestamp'],
      playCount: data?['playcount'] ?? 0,
      tags:
          (data?['tags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> recentlyToFirestore() {
    return {
      'name': name,
      'urls': ambients,
      'image': image,
      'timestamp': timestamp,
      'playcount': playCount,
      'tags': tags,
    };
  }
}
