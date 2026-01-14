import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Post({required this.title, required this.content});

  final String title;
  final String content;

  factory Post.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return Post(title: data?['title'], content: data?['content']);
  }

  Map<String, dynamic> toFirestore() {
    return {'title': title, 'content': content};
  }

  String get postTitle => title;
  String get postContent => content;
}
