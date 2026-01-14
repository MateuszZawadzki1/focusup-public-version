import 'package:flutter/material.dart';
import 'package:focus_up/features/post/data/models/post.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Text(post.title),
          ),
        ),
        SizedBox(height: 5),
        Card(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(post.content),
          ),
        ),
        SizedBox(height: 25),
      ],
    );
  }
}
