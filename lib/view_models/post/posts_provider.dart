import 'package:flutter_boilerplate/data/models/post/post.dart';
import 'package:flutter_boilerplate/data/repositories/post_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final postsProvider = FutureProvider.autoDispose<List<Post>>(
  (ref) => ref.watch(postRepositoryProvider).getPosts(),
);
