import 'package:dio/dio.dart';
import '/data/api/api_util.dart';
import '/di/post_di.dart';
import '/domain/model/auth/post_entity.dart';
import '/domain/model/post/create_post_request_entity.dart';
import '../../domain/repository/post_repository.dart';

class PostRepositoryImpl extends PostRepository {
  final ApiUtil _apiUtil = serviceDiPost<ApiUtil>();

  @override
  Future<PostEntity>? getPostById({required int id}) {
    return _apiUtil.getPostById(id: id);
  }

  @override
  Future<List<PostEntity>>? getPosts({
    String? city,
  }) {
    return _apiUtil.getPosts(city: city);
  }

  @override
  Future<Response> createPost(
      {required CreatePostRequestEntity createPostRequestEntity}) {
    return _apiUtil.createPost(body: createPostRequestEntity);
  }
}
