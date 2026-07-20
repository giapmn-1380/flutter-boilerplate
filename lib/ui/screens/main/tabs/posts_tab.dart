import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/data/models/post/post.dart';
import 'package:flutter_boilerplate/ui/widgets/common/async_value_widget.dart';
import 'package:flutter_boilerplate/view_models/post/posts_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Tab demo gọi API public (jsonplaceholder.typicode.com) và hiển thị danh sách.
class PostsTab extends ConsumerWidget {
  const PostsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(title: Text('posts'.tr())),
      body: AsyncValueWidget<List<Post>>(
        value: postsAsync,
        onRetry: () => ref.invalidate(postsProvider),
        data: (posts) => RefreshIndicator(
          onRefresh: () => ref.refresh(postsProvider.future),
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: posts.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final post = posts[index];
              return ListTile(
                leading: CircleAvatar(child: Text('${post.id}')),
                title: Text(
                  post.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  post.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
