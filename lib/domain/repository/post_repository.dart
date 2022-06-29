import 'package:dio/dio.dart';
import '/domain/model/auth/post_entity.dart';
import '/domain/model/post/create_post_request_entity.dart';

abstract class PostRepository {
  Future<PostEntity>? getPostById({
    required int id,
  });

  Future<List<PostEntity>>? getPosts({String? city});

  Future<Response> createPost(
      {required CreatePostRequestEntity createPostRequestEntity});
}
