import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:focus_up/features/post/data/models/post.dart';
import 'package:focus_up/features/post/data/repositories/post_repository.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository postRepository;
  PostCubit({required this.postRepository}) : super(PostInitial());

  Future<void> fetchPosts() async {
    emit(PostLoading());

    final posts = await postRepository.fetchPosts();

    posts.fold(
      ifLeft: (fail) => emit(PostError(message: fail)),
      ifRight: (posts) => emit(PostLoaded(posts: posts)),
    );
  }
}
