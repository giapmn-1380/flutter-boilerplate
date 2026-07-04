import 'package:flutter_boilerplate/data/models/post/post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Post', () {
    const json = {
      'userId': 1,
      'id': 10,
      'title': 'Hello',
      'body': 'World',
    };

    test('fromJson parses all fields', () {
      final post = Post.fromJson(json);

      expect(post.userId, 1);
      expect(post.id, 10);
      expect(post.title, 'Hello');
      expect(post.body, 'World');
    });

    test('toJson round-trips', () {
      final post = Post.fromJson(json);

      expect(post.toJson(), json);
    });
  });
}
