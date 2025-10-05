import 'package:dart_either/dart_either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tech_task/data/models/post_model.dart';
import 'package:flutter_tech_task/data/repository/post_repository.dart';
import 'package:flutter_tech_task/data/repository/post_repository_impl.dart';
import 'package:flutter_tech_task/utils/api_error.dart';

/// Use case for fetching a single post by ID
/// Handles the business logic for getting a specific post
class GetPostByIdUseCase {
  GetPostByIdUseCase({required PostRepository repository}) : _repository = repository;

  final PostRepository _repository;

  /// Execute the use case to get a post by ID
  /// First checks if the post is saved locally, then tries remote API
  Future<Either<ApiError, Post>> call(int postId) async {
    // For now, we directly
    // fetch from remote API
    return await _repository.getPostById(postId);
  }
}

/// Riverpod provider for GetPostByIdUseCase
final getPostByIdUseCaseProvider = Provider<GetPostByIdUseCase>((ref) {
  final repository = ref.read(postRepositoryProvider);
  return GetPostByIdUseCase(repository: repository);
});