import 'package:dart_either/dart_either.dart';
import 'package:focus_up/features/post/data/models/post.dart';

abstract class PostRepository {
  Future<Either<String, List<Post>>> fetchPosts();
}
