import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focus_up/features/post/data/models/post.dart';

class PostService {
  final FirebaseFirestore firebase;

  PostService({required this.firebase});

  Future<List<Post>> fetchPosts() async {
    final snapshot = await firebase.collection('posts').get();
    log(snapshot.toString());
    final postsData = snapshot.docs.map((e) => Post.fromFirestore(e)).toList();
    log('postsData: ${postsData.toString()}');
    return postsData;
  }
}
