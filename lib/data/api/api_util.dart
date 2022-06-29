import 'package:dio/dio.dart';
import '/data/api/service/favorite_service.dart';
import '/data/api/service/post_service.dart';
import '/data/api/service/profile_service.dart';
import '/data/mapper/favorite/favorite_mapper.dart';
import '/data/mapper/profile/profile_mapper.dart';
import '/domain/model/favorite/favorite_entity.dart';
import '/domain/model/post/create_post_request_entity.dart';
import '/domain/model/profile/profile_entity.dart';

import '../../di/post_di.dart';
import '../../domain/model/auth/post_entity.dart';
import '../mapper/auth/post_mapper.dart';

class ApiUtil {
  final PostService _postService = serviceDiPost<PostService>();
  final ProfileService _profileService = serviceDiPost<ProfileService>();
  final FavoriteService _favoriteService = serviceDiPost<FavoriteService>();

  Future<PostEntity> getPostById({
    required int id,
  }) async {
    final result = await _postService.getPostById(id);
    return PostMapper.fromApi(result);
  }

  Future<List<PostEntity>> getPosts({String? city}) async {
    final result = await _postService.getPosts(city: city);
    List<PostEntity> list = [];
    for (var element in result) {
      list.add(PostMapper.fromApi(element));
    }
    return list;
  }

  Future<ProfileEntity> getProfile({required int id}) async {
    final result = await _profileService.getProfile(id: id);
    return ProfileMapper.fromApi(result);
  }

  Future<ProfileEntity> getProfileSelf() async {
    final result = await _profileService.getProfileSelf();
    return ProfileMapper.fromApi(result);
  }

  Future<List<ProfileEntity>> getProfiles(
      {String? city, String? type, int? gender}) async {
    final result = await _profileService.getProfiles(
        city: city, type: type, gender: gender);
    List<ProfileEntity> list = [];
    for (var element in result) {
      list.add(ProfileMapper.fromApi(element));
    }
    return list;
  }

  Future<List<FavoriteEntity>>? getFavorites() async {
    final result = await _favoriteService.getFavorites();
    List<FavoriteEntity> list = [];
    for (var element in result) {
      list.add(FavoriteMapper.fromApi(element));
    }
    return list;
  }

  Future<List<ProfileEntity>>? getTalents({String? city}) async {
    final result = await _profileService.getTalents(city: city);
    List<ProfileEntity> list = [];
    for (var element in result) {
      list.add(ProfileMapper.fromApi(element));
    }
    return list;
  }

  Future<Response> createPost({required CreatePostRequestEntity body}) async {
    return await _profileService.createPost(body);
  }
}
