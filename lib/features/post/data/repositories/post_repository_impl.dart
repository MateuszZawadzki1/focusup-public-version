import 'package:dart_either/src/dart_either.dart';
import 'package:focus_up/features/post/data/data_source/post_service.dart';
import 'package:focus_up/features/post/data/repositories/post_repository.dart';
import 'package:focus_up/features/post/data/models/post.dart';

class PostRepositoryImpl implements PostRepository {
  final PostService postService;

  PostRepositoryImpl({required this.postService});

  @override
  Future<Either<String, List<Post>>> fetchPosts() async {
    try {
      final posts = await postService.fetchPosts();
      return Right(posts);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
