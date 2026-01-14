import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class SetImage {
  String? id;
  final String name;
  final String originalUrl;
  final String thumbUrl;

  SetImage({
    required this.name,
    required this.originalUrl,
    required this.thumbUrl,
    this.id,
  });

  factory SetImage.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    log('Document ${snapshot.id} data: $data');

    return SetImage(
      name: data?['name'] as String,
      originalUrl: data?['originalurl'] as String,
      thumbUrl: data?['thumburl'] as String,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {'name': name, 'originalurl': originalUrl, 'thumburl': thumbUrl};
  }
}
