import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/data/app_error.dart';
import 'package:flutter_boilerplate/data/models/post/post.dart';
import 'package:flutter_boilerplate/data/remote/dio_client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final postRepositoryProvider = Provider<PostRepository>(
  (ref) => PostRepositoryImpl(ref.watch(dioClientProvider)),
);

abstract class PostRepository {
  Future<List<Post>> getPosts();
}

class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<Post>> getPosts() async {
    try {
      final res = await _dio.get<List<dynamic>>('/posts');
      return (res.data ?? [])
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList();
    } on Exception catch (e) {
      throw AppException.from(e);
    }
  }
}
