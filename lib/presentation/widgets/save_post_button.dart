import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tech_task/data/models/post_model.dart';
import 'package:flutter_tech_task/presentation/providers/saved_posts_notifier.dart';

/// A reusable widget that handles save/unsave functionality for posts
/// Following Single Responsibility Principle - only handles save state logic
class SavePostButton extends ConsumerWidget {
  const SavePostButton({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedPostsAsync = ref.watch(savedPostsProvider);
    
    return savedPostsAsync.when(
      data: (savedPosts) {
        final isSaved = savedPosts.any((p) => p.id == post.id);
        return IconButton(
          icon: Icon(
            isSaved ? Icons.bookmark : Icons.bookmark_border,
            color: isSaved ? Colors.blue : null,
          ),
          onPressed: () {
            ref.read(savedPostsProvider.notifier).toggle(post);
          },
        );
      },
      loading: () => IconButton(
        icon: const Icon(Icons.bookmark_border),
        onPressed: () {
          ref.read(savedPostsProvider.notifier).toggle(post);
        },
      ),
      error: (error, stack) => IconButton(
        icon: const Icon(Icons.bookmark_border),
        onPressed: () {
          ref.read(savedPostsProvider.notifier).toggle(post);
        },
      ),
    );
  }
}