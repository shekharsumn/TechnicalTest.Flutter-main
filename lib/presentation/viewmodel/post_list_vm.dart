import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_task/data/models/post_model.dart';
import 'package:flutter_tech_task/domain/usecases/get_posts_usecase.dart';
import 'package:flutter_tech_task/presentation/viewmodel/base_viewmodel.dart';
import 'package:flutter_tech_task/utils/api_error.dart';

class PostListViewModel extends ChangeNotifier with BaseViewModel {
  final GetPostsUseCase getPostsUseCase;

  Either<ApiError, List<Post>> _posts = const Right(<Post>[]);
  Either<ApiError, List<Post>> get posts => _posts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  PostListViewModel({required this.getPostsUseCase});

  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _posts = await getPostsUseCase.call();
    } catch (e) {
      _posts = Left(ApiError(message: e.toString(), type: ApiErrorType.unknown));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void init() {
    fetchPosts();
  }

  @override
  void dispose() {
    _isLoading = false;
    _posts = const Right(<Post>[]);
    super.dispose();
  }
}
