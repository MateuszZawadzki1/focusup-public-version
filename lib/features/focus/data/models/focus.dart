import 'package:cloud_firestore/cloud_firestore.dart';

class FocusModel {
  final String image;
  final String description;
  final String title;

  FocusModel({
    required this.title,
    required this.image,
    required this.description,
  });

  factory FocusModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return FocusModel(
      title: data?['title'],
      image: data?['image_url'],
      description: data?['description'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {'image_url': image, 'description': description, 'title': title};
  }
}
