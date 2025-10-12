import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tech_task/presentation/widgets/post_list_item.dart';
import 'package:flutter_tech_task/presentation/widgets/api_error_widget.dart';
import 'package:flutter_tech_task/data/models/post_model.dart';
import 'package:flutter_tech_task/presentation/providers/connectivity_notifier.dart';
import 'package:flutter_tech_task/presentation/providers/post_list_provider.dart';


class ListPage extends ConsumerStatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ListPage> createState() => _ListPageState();
}

class _ListPageState extends ConsumerState<ListPage>
    with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final asyncPosts = ref.watch(postListProvider);
    final isConnected = ref.watch(isConnectedProvider);
    
    return Scaffold(
      body: asyncPosts.when(
        data: (List<Post> posts) {
          if (posts.isEmpty) {
            return const Center(child: Text('No posts available'));
          }
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(
              key: const PageStorageKey<String>('post-list'),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return PostListItem(post: post);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          return ApiErrorWidget(
            isConnected: isConnected,
            error: error.toString(),
            onRetry: () {
              ref.read(postListProvider.notifier).fetchPosts();
            },
            offlineSubtitle: 'Please check your internet connection and try again',
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
