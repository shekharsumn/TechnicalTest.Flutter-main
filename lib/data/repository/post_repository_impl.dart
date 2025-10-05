import 'package:dart_either/dart_either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tech_task/data/models/post_model.dart';
import 'package:flutter_tech_task/data/models/comment_model.dart';
import 'package:flutter_tech_task/data/repository/post_repository.dart';
import 'package:flutter_tech_task/data/service/api_interface.dart';
import 'package:flutter_tech_task/data/service/dio_service.dart';
import 'package:flutter_tech_task/utils/api_error.dart';

/// Concrete implementation of PostRepository
/// Handles both remote API calls and local storage operations
class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl({
    required ApiInterface apiService,
  }) : _apiService = apiService;

  final ApiInterface _apiService;

  @override
  Future<Either<ApiError, List<Post>>> getPosts() async {
    return await _apiService.getPosts();
  }

  @override
  Future<Either<ApiError, Post>> getPostById(int id) async {
    return await _apiService.getPostById(id);
  }

  @override
  Future<Either<ApiError, List<CommentModel>>> getCommentsForPost(
      int postId) async {
    return await _apiService.getCommentsForPost(postId);
  }
}

/// Riverpod provider for PostRepository
/// Provides a singleton instance of PostRepository for dependency injection via Riverpod.
final postRepositoryProvider = Provider<PostRepository>((ref) {
  final apiService = ref.read(dioServiceProvider);
  return PostRepositoryImpl(apiService: apiService);
});
