import 'package:flutter/material.dart';
import 'package:focus_up/features/post/data/models/post.dart';
import 'package:focus_up/features/post/presentation/widgets/post_item.dart';

class PostsList extends StatelessWidget {
  const PostsList({super.key, required this.posts});

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return Scrollbar(
      thumbVisibility: true,
      controller: _scrollController,
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.all(8),
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return PostItem(post: posts[index]);
        },
      ),
    );
  }
}
