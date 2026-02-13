import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tech_task/domain/usecases/get_posts_usecase.dart';
import 'package:flutter_tech_task/data/models/post_model.dart';
import 'package:flutter_tech_task/utils/api_error.dart';

class PostListNotifier extends AsyncNotifier<List<Post>> {
  late GetPostsUseCase _getPostsUseCase;

  @override
  Future<List<Post>> build() async {
    _getPostsUseCase = ref.read(getPostsUseCaseProvider);
    return await _fetchPosts();
  }

  Future<List<Post>> _fetchPosts() async {
    final result = await _getPostsUseCase.call();
    return result.fold(
      ifLeft: (ApiError error) => throw Exception(error.message),
      ifRight: (List<Post> posts) => posts,
    );
  }

  Future<void> fetchPosts() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchPosts());
  }
}

final postListProvider = AsyncNotifierProvider<PostListNotifier, List<Post>>(() {
  return PostListNotifier();
});